package Shipment::UPS::API;

use JSON qw();
use LWP::UserAgent;
use HTTP::Headers;
use MIME::Base64;
use Data::Dumper qw/Dumper/;

use Moo;
use MooX::Types::MooseLike::Base qw/:all/;

has 'client_id' => (
  is => 'ro',
  isa => Str,
);

has 'client_secret' => (
  is => 'ro',
  isa => Str,
);

has 'account_number' => (
  is => 'ro',
  isa => Str,
);

has 'access_token' => (
  is => 'rwp',
  isa => Str,
  lazy => 1,
  builder => '_build_access_token',
  writer => '_set_access_token'
);

sub _build_access_token {
  my ($self, $opts) = @_;

  # Use $opts so the function is clear about what it is doing when being called
  my $force_refresh = $opts->{force_refresh} || 0;

  return $self->preserve_token->() if
  $self->preserve_token
  && $self->preserve_token->() && !$force_refresh;

  if (!$self->client_id || !$self->client_secret || !$self->account_number) {
    $self->errors(['client_id, client_secret, account_number are required']);
    return '';
  }

  my $ua = LWP::UserAgent->new;
  my $request = HTTP::Request->new( POST => $self->api_url . '/security/v1/oauth/token',
    [
      'x-merchant-id' => $self->account_number,
      'Content-Type' => 'application/x-www-form-urlencoded',
    ],
    'grant_type=client_credentials',
  );
  $request->authorization_basic($self->client_id, $self->client_secret);
  my $res = $ua->request( $request );

  if ($self->debug) {
    warn $res->request->as_string;
    warn $res->as_string;
  }

  my $doc = $self->json->decode($res->decoded_content);

  if (!$res->is_success) {
    if ($doc->{response}->{errors}->[0]->{code}) {
      die 'Failed to get access token: ' . $doc->{response}->{errors}->[0]->{code} . ': ' . $doc->{response}->{errors}->[0]->{message};
    }
    else {
      die 'Failed to get access token: ' . $res->status_line . ': ' . Dumper($doc->{response}->{errors});
    }
  }
  else {
    warn $doc->{status} if $self->debug;
    $self->preserve_token->($doc) if $self->preserve_token;
    return $doc->{access_token};
  }
};

=head2 preserve_token

  A callback to preserve the data returned from the auth request
  @params
    HashRef $1: the data returned from the auth request

  @return
    String $access_token: preserved access token from previous auth request
      You should check the expiration time before reusing the token

=cut

has 'preserve_token' => (
  is => 'ro',
  isa => CodeRef,
);

has 'debug' => (
  is => 'ro',
  isa => Bool,
);

has 'ua' => (
  is => 'rwp',
  isa => InstanceOf['LWP::UserAgent'],
  lazy => 1,
  builder => "_build_ua",
  writer => '_set_ua'
);

sub _build_ua {
  my $self = shift;
  my $h = HTTP::Headers->new;
  $h->header('Authorization' => 'Bearer ' . $self->access_token);
  $h->header('Content-Type' => 'application/json');

  return LWP::UserAgent->new(
    agent => 'Shipment::UPS::API/1.0',
    default_headers => $h,
  );
};

has 'api_url' => (
  is => 'rw',
  isa => Enum[ qw(
    https://wwwcie.ups.com
    https://onlinetools.ups.com
  ) ],
  default => 'https://wwwcie.ups.com',
);

has 'json' => (
  is => 'ro',
  isa => InstanceOf['JSON'],
  lazy => 1,
  default => sub { JSON->new->utf8->pretty->allow_nonref->canonical },
);

sub _post_request {
    my ($self, $url, $data, $type, @extra_headers) = @_;

    return unless $url;

    $type ||= 'post';

    my $response = eval {
      my $r = $self->ua->$type(
        $url,
        @extra_headers,
        'Content' => $self->json->encode($data),
      );

      if ($self->debug) {
        warn "Request:\n" . $r->request->as_string;
        warn "Response:\n" . $r->as_string;
      }

      # Attempt to retry the request if request fails with code 401
      # by refreshing the access token and trying the request again
      if (!$r->is_success && $r->status_line =~ /401 Unauthorized/) {
        my $new_access_token = $self->_build_access_token({ force_refresh => 1 });
        warn "New Access Token: $new_access_token" if $self->debug;
        $self->_set_access_token($new_access_token);
        # Rebuild the user agent with the new access token
        $self->_set_ua($self->_build_ua);
        $r = $self->ua->$type(
          $url,
          @extra_headers,
          'Content' => $self->json->encode($data),
        );
      }

      if (!$r->is_success && $r->decoded_content) {
        my $errors = $self->json->decode($r->decoded_content);
        die join '\n', map { $_->{code} . ' - ' . $_->{message} . "\n" } @{ $errors->{response}->{errors} } if $errors;
        die 'Request failed: ' . $r->status_line . ': ' . $r->decoded_content;
      } elsif (!$r->is_success) {
        die 'Request failed: ' . $r->status_line . ': No decoded content';
      }

      return $self->json->decode($r->decoded_content);
    };

    die $@ if $@;

    return $response;
}

sub shop {
  my ($self, $data) = @_;

  return $self->_post_request($self->api_url . '/api/rating/v1/Shop', { RateRequest => $data });
}

sub rate {
  my ($self, $data) = @_;

  return $self->_post_request($self->api_url . '/api/rating/v1/Rate', { RateRequest => $data });
}

sub ship {
  my ($self, $data) = @_;

  return $self->_post_request($self->api_url . '/api/shipments/v1/ship', { ShipmentRequest => $data });
}

sub cancel {
  my ($self, $data) = @_;
  die 'ShipmentIdentificationNumber is required' if !$data->{ShipmentIdentificationNumber};
  my $tracking_number_array = '[' . join(',', @{$data->{TrackingNumber}}) . ']' if $data->{TrackingNumber} && ref $data->{TrackingNumber} eq 'ARRAY' && scalar @{$data->{TrackingNumber}} > 1;
  my $query = $tracking_number_array ? "?trackingnumber=$tracking_number_array" : '';
  return $self->_post_request($self->api_url . '/api/shipments/v1/void/cancel/' . $data->{ShipmentIdentificationNumber} . $query, undef, 'delete');
}

sub xav {
  my ($self, $data) = @_;
  die 'requestoption is required' if !$data->{Request}->{RequestOption};
  return $self->_post_request($self->api_url . '/api/addressvalidation/v2/' . $data->{Request}->{RequestOption}, {
    XAVRequest => $data
  });
}

sub track {
  my ($self, $data) = @_;
  die 'inquiryNumber is required' if !$data->{Request}->{InquiryNumber};
  return $self->_post_request(
    $self->api_url . '/api/track/v1/details/' . $data->{Request}->{InquiryNumber},
    undef,
    "get",
    transactionSrc => "Shipment::UPS::API",
    transId => 'Shipment::UPS::API-' . time()
  );
}

no Moo;

1;
