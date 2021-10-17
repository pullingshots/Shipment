package Shipment::CanadaPost;
use strict;
use warnings;

use Shipment::CanadaPost::XSD;
use XML::Compile::Schema;
use LWP::UserAgent;
use Shipment::Label;

=head1 NAME

Shipment::CanadaPost - Interface to Canada Post Web Services API

=head1 SYNOPSIS

  use Shipment::CanadaPost;
  use Shipment::Address;
  use Shipment::Package;

  my $shipment = Shipment::CanadaPost->new(
    from_address => Shipment::Address->new( ... ),
    to_address => Shipment::Address->new( ... ),
    packages => [ Shipment::Package->new( ... ), ],
  );

  foreach my $service ( $shipment->all_services ) {
    print $service->id . " (" . $service->cost . ")\n";
  }

  $shipment->rate( 'express' );
  print $shipment->service->cost . "\n";

  $shipment->ship( 'ground' );
  $shipment->get_package(0)->label->save;

=head1 ABOUT

This class provides an interface to the Canada Post Web Services API. You must sign up for a developer access key in order to make use of this module.

https://www.canadapost-postescanada.ca/information/app/drc/home

It is an extension of L<Shipment::Base>.

=cut

use Try::Tiny;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use namespace::clean;

extends 'Shipment::Base';

=head1 Class Attributes

=head2 username, password

Credentials required to access Canada Post Web Services

=cut

has 'username' => (
  is => 'rw',
  isa => Str,
);

has 'password' => (
  is => 'rw',
  isa => Str,
);

=head2 endpoint

This determines whether you will use the development or production environment
  * ct.soa-gw.canadapost.ca (development)
  * soa-gw.canadapost.ca (production)

=cut

has 'endpoint' => (
  is => 'rw',
  isa => Enum[ qw(
    ct.soa-gw.canadapost.ca
    soa-gw.canadapost.ca
  ) ],
  default => 'ct.soa-gw.canadapost.ca',
);

=head2 contract_id

The Canada Post contract number which unlocks restricted services, negotiated rates, and payment accounts

=cut

has 'contract_id' => (
  is => 'rw',
  isa => Str,
);

=head2 currency

Only CAD currency is supported

=cut

has '+currency' => (
  isa => Enum[ qw( CAD ) ],
  default => 'CAD',
);

=head2 customs_currency, customs_conversion, customs_reason

Currency, conversion rate and reason used for customs clearance

Default: CAD

=cut

has 'customs_currency' => (
  is => 'rw',
  isa => Str,
  default => 'CAD',
);

has 'customs_conversion' => (
  is => 'rw',
  isa => Num,
  default => 1,
);

has 'customs_reason' => (
  is => 'rw',
  isa => Enum[ qw( DOC SAM REP SOG ) ],
  default => 'SOG',
);

=head2 non-delivery handling

RASE - Return at Sender's Expense
RTS - Return to Sender
ABAN - Abandon

Default: RTS

=cut

has 'non_delivery_handling' => (
  is => 'rw',
  isa => Enum[ qw( RASE RTS ABAN ) ],
);

=head2 services_rates

get rates when building services

=cut

has 'services_rates' => (
  is => 'rw',
  isa => Bool,
  default => 0,
);

=head1 Class Methods

=head2 _messages

Parse a web services xml messages response and return as text

=cut

sub _messages {
  my ($self, $xml) = @_;

  my $schema = XML::Compile::Schema->new([
    $Shipment::CanadaPost::XSD::messages,
  ]);

  my $reader = $schema->compile(READER => '{http://www.canadapost.ca/ws/messages}messages');
  my $data = $reader->($xml);

  my $messages = '';
  foreach my $message (@{ $data->{message} }) {
    $messages .= $message->{code} . ': ' . $message->{description} . "\n";
  }
  warn $messages if $self->debug;

  $messages;
}

=head2 _build_services

This calls DiscoverServices or GetRates (if services_rates attribute is set))

Defaults to shipping to Canada

Each service that is returned is added to services

The following service mapping is used:
  * ground =>  DOM.RP / DOM.EP (Regular/Expedited Parcel) USA.TP / USA.EP (USA Tracked Packet / Expedited Parcel) or INT.TP / INT.IP.AIR / INT.IP.SURF (International Tracked Packet / Parcel) / INT.XP
  * express => DOM.XP / USA.XP / INT.XP (Xpresspost)
  * priority => DOM.PC (Priority) or INT.PW.PARCEL (Priority Worldwide)

This method ignores what is in $self->packages and uses a single package weighing 1 pound for rating. The idea is to list what services are available, but for accurate rating, the rate method should be used.

=cut

sub _build_services {
  my $self = shift;

  my %services;
 
  my $ua = LWP::UserAgent->new();
  $ua->credentials($self->endpoint . ':443','login', $self->username, $self->password);

  if (
      $self->services_rates
        &&
      $self->from_address() && $self->from_address()->postal_code
        &&
      $self->to_address() && $self->to_address()->postal_code
    ) {
    
    my $country_code = $self->to_address()->country_code || 'CA';
    my $data = {
      'parcel-characteristics' => {
        'weight' => 1,
      },
      'origin-postal-code' => $self->from_address()->postal_code,
    };

    if ($self->account) {
      $data->{'customer-number'} = $self->account;
      $data->{'contract-id'} = $self->contract_id if $self->contract_id;
    }
    else {
      $data->{'quote-type'} = 'counter';
    }

    if ($country_code eq 'CA') {
      $data->{'destination'}->{'domestic'}->{'postal-code'} = $self->to_address()->postal_code;
    }
    elsif ($country_code eq 'US') {
      $data->{'destination'}->{'united-states'}->{'zip-code'} = $self->to_address()->postal_code;
    }
    else {
      $data->{'destination'}->{'international'}->{'country-code'} = $country_code;
      $data->{'destination'}->{'international'}->{'postal-code'} = $self->to_address()->postal_code;
    }

    my $schema = XML::Compile::Schema->new( $Shipment::CanadaPost::XSD::rating . $Shipment::CanadaPost::XSD::common );
    my $xml_data = $schema->compile('WRITER', '{http://www.canadapost.ca/ws/ship/rate-v4}mailing-scenario')->(
        XML::LibXML::Document->new('1.0', 'UTF-8'), $data
      )->toString;
    warn 'XML Request: ' . $xml_data if $self->debug;

    my $url = 'https://' . $self->endpoint . '/rs/ship/price';
    my $header = [
        'Content-Type' => 'application/vnd.cpc.ship.rate-v4+xml',
        'Accept' => 'application/vnd.cpc.ship.rate-v4+xml',
      ];
    my $request = HTTP::Request->new(POST => $url, $header, $xml_data);

    my $response = $ua->request( $request );
    if (!$response->is_success) {
      warn $response->status_line if $self->debug;
      $self->error( 'services request failed with status: ' . $response->status_line . ' and message: ' . $self->_messages($response->content) );
      return \%services;
    }

    warn 'XML Response: ' . $response->content if $self->debug;

    my $reader = $schema->compile(READER => '{http://www.canadapost.ca/ws/ship/rate-v4}price-quotes');
    $data = $reader->($response->content);
    foreach my $service (@{ $data->{'price-quote'} }) {
      my ($y, $m, $d) = split('-', $service->{'service-standard'}->{'expected-delivery-date'});
      my $eta;
      if ($y && $m && $d) {
        $eta = { year => $y, month => $m, day => $d };
      }
      $services{$service->{'service-code'}} = Shipment::Service->new(
          id => $service->{'service-code'},
          name => $service->{'service-name'},
          cost => Data::Currency->new($service->{'price-details'}->{'due'}, 'CAD'),
          etd => $service->{'service-standard'}->{'expected-transit-time'},
          eta => $eta,
        );
    }

  }
  else {

    my $url = 'https://' . $self->endpoint . '/rs/ship/service?country=' . (($self->to_address() && $self->to_address()->country_code) ? $self->to_address()->country_code : 'CA');
    $url .= '&contract=' . $self->contract_id if $self->contract_id;
    $url .= '&origpc=' . $self->from_address()->postal_code if $self->from_address() && $self->from_address()->postal_code;
    $url .= '&destpc=' . $self->to_address()->postal_code if $self->to_address() && $self->to_address()->postal_code;

    my $response = $ua->get( $url, 'Accept' => 'application/vnd.cpc.ship.rate-v4+xml');

    if (!$response->is_success) {
      warn $response->status_line if $self->debug;
      $self->error( 'services request failed with status: ' . $response->status_line );
      return \%services;
    }

    warn 'XML Response: ' . $response->content if $self->debug;

    my $schema = XML::Compile::Schema->new( $Shipment::CanadaPost::XSD::discovery . $Shipment::CanadaPost::XSD::common );
    my $reader = $schema->compile(READER => '{http://www.canadapost.ca/ws/ship/rate-v4}services');
    my $data = $reader->($response->content);

    foreach my $service (@{ $data->{service} }) {
      $services{$service->{'service-code'}} = Shipment::Service->new(
          id => $service->{'service-code'},
          name => $service->{'service-name'},
        );
    }

  }

  $services{ground} = $services{'DOM.RP'} || $services{'DOM.EP'} || $services{'USA.TP'} || $services{'USA.EP'} || $services{'INT.TP'} || $services{'INT.IP.AIR'} || $services{'INT.IP.SURF'} || $services{'INT.XP'} || undef;
  $services{express} = $services{'DOM.XP'} || $services{'USA.XP'} || $services{'INT.XP'} || undef;
  $services{priority} = $services{'DOM.PC'} || $services{'USA.PW.PARCEL'} || $services{'INT.PW.PARCEL'};
  foreach (qw/ground express priority/) {
    delete $services{$_} if !$services{$_};
  }

  \%services;
}

=head2 rate

This calls the GetRates service for the selected service id

=cut

sub rate {
  my ( $self, $service_id ) = @_;

  if ($service_id eq 'ground') {
    foreach my $id (qw/DOM.RP DOM.EP USA.TP USA.EP INT.TP INT.IP.AIR INT.IP.SURF INT.XP/) {
      if ($self->services->{$id}) {
        $self->error('');
        $self->rate($id);
        if (!$self->error) {
          return;
        }
      }
    }
    return;
  }

  try { 
    $service_id = $self->services->{$service_id}->id;
  } catch {
    warn $_ if $self->debug;
    warn "service ($service_id) not available" if $self->debug;
    $self->error( "service ($service_id) not available" );
    $service_id = '';
  };
  return unless $service_id;

  my $ua = LWP::UserAgent->new();
  $ua->credentials($self->endpoint . ':443','login', $self->username, $self->password);

  if (
      $self->from_address() && $self->from_address()->postal_code
        &&
      $self->to_address() && $self->to_address()->postal_code
    ) {
    
    my $country_code = $self->to_address()->country_code || 'CA';
    my $data = {
      'services' => { 'service-code' => [$service_id] },
      'origin-postal-code' => $self->from_address()->postal_code,
    };

    if ($self->account) {
      $data->{'customer-number'} = $self->account;
      $data->{'contract-id'} = $self->contract_id if $self->contract_id;
    }
    else {
      $data->{'quote-type'} = 'counter';
    }

    if ($country_code eq 'CA') {
      $data->{'destination'}->{'domestic'}->{'postal-code'} = $self->to_address()->postal_code;
    }
    elsif ($country_code eq 'US') {
      $data->{'destination'}->{'united-states'}->{'zip-code'} = $self->to_address()->postal_code;
    }
    else {
      $data->{'destination'}->{'international'}->{'country-code'} = $country_code;
      $data->{'destination'}->{'international'}->{'postal-code'} = $self->to_address()->postal_code;
    }

    my $schema = XML::Compile::Schema->new( $Shipment::CanadaPost::XSD::rating . $Shipment::CanadaPost::XSD::common );

    my $cost = 0;
    my $etd = 0;
    my $eta;

    foreach my $package (@{ $self->packages }) {

      my $weight = $package->weight;
      if ($self->weight_unit eq 'lb') {
        $weight = sprintf('%.4f', $weight * 0.4535924);
      }
      elsif ($self->weight_unit eq 'oz') {
        $weight = sprintf('%.4f', $weight * 0.02834952);
      }
      my ($l, $w, $h) = ($package->length, $package->width, $package->height);
      if ($self->dim_unit eq 'in') {
        $l = sprintf('%.4f', $l * 2.54);
        $w = sprintf('%.4f', $w * 2.54);
        $h = sprintf('%.4f', $h * 2.54);
      }
      $data->{'parcel-characteristics'} = {
        weight => $weight,
        dimensions => {
          length => $l,
          width => $w,
          height => $h,
        },
      };

      my $xml_data;
      try {
        $xml_data = $schema->compile('WRITER', '{http://www.canadapost.ca/ws/ship/rate-v4}mailing-scenario')->(
            XML::LibXML::Document->new('1.0', 'UTF-8'), $data
          )->toString;
        warn 'XML Request: ' . $xml_data if $self->debug;
      } catch {
        warn $_ if $self->debug;
        my $error = $_;
        $error =~ s/\`//g;
        $self->error( $error );
      };
      return unless $xml_data;

      my $url = 'https://' . $self->endpoint . '/rs/ship/price';
      my $header = [
          'Content-Type' => 'application/vnd.cpc.ship.rate-v4+xml',
          'Accept' => 'application/vnd.cpc.ship.rate-v4+xml',
        ];
      my $request = HTTP::Request->new(POST => $url, $header, $xml_data);

      my $response = $ua->request( $request );
      if (!$response->is_success) {
        warn $response->status_line if $self->debug;
        $self->error( $self->_messages($response->content) );
        return;
      }

      warn 'XML Response: ' . $response->content if $self->debug;

      my $reader = $schema->compile(READER => '{http://www.canadapost.ca/ws/ship/rate-v4}price-quotes');
      my $response_data = $reader->($response->content);
      my $service = $response_data->{'price-quote'}->[0];
      $cost += $service->{'price-details'}->{'due'};
      $etd = $service->{'service-standard'}->{'expected-transit-time'};
      my ($y, $m, $d) = split('-', $service->{'service-standard'}->{'expected-delivery-date'});
      if ($y && $m && $d) {
        $eta = { year => $y, month => $m, day => $d };
      }
    }

    $self->service( Shipment::Service->new(
        id => $service_id,
        name => $self->services->{$service_id}->name,
        cost => Data::Currency->new($cost, 'CAD'),
        etd => $etd,
        eta => $eta,
      )
    );
  }
  else {
    # from and to address required
    $self->error( "Both from and to address are required for rating." );
  }

  return;
}

=head2 ship

This method calls the CreateShipment service

Manifests are not supported, transmit-shipment is always set to true

cpc-pickup-indicator is always set to true with the requested-shipping-point set to the from postal code

Only payment on account is currently supported

Note: this method calls the curl binary instead of using LWP::UserAgent or Net::Curl due to a bug in the Canada Post API shipping service endpoint. It also writes the xml to a temporary file.

=cut

has 'tmp_file_dir' => (
  is => 'rw',
  isa => Str,
  default => 'tmp',
);

sub ship {
  my ( $self, $service_id ) = @_;

  try { 
    $service_id = $self->services->{$service_id}->id;
  } catch {
    warn $_ if $self->debug;
    warn "service ($service_id) not available" if $self->debug;
    $self->error( "service ($service_id) not available" );
    $service_id = '';
  };
  return unless $service_id;

  my $ua = LWP::UserAgent->new();
  $ua->credentials($self->endpoint . ':443','login', $self->username, $self->password);

  if (
      $self->from_address() && $self->from_address()->postal_code
        &&
      $self->to_address() && $self->to_address()->postal_code
    ) {
    
    my $country_code = $self->to_address()->country_code || 'CA';
    my $data = {
      'transmit-shipment' => 'true',
      'cpc-pickup-indicator' => 'true',
      'requested-shipping-point' => $self->from_address()->postal_code,
      'provide-pricing-info' => 'true',
      'delivery-spec' => {
        'service-code' => $service_id,
        'sender' => {
          'company' => $self->from_address->company,
          'name' => $self->from_address->name,
          'address-details' => {
            'address-line-1'    => $self->from_address->address1,
            'address-line-2'    => $self->from_address->address2,
            'city'              => $self->from_address->city,
            'prov-state'        => $self->from_address->province_code,
            'postal-zip-code'   => $self->from_address->postal_code,
            'country-code'      => $self->from_address->country_code,
          },
          'contact-phone' => $self->from_address()->phone || '0000000000',
        },
        'destination' => {
          'company' => $self->to_address->name,
          'name' => $self->to_address->company,
          'address-details' => {
            'address-line-1'    => $self->to_address->address1,
            'address-line-2'    => $self->to_address->address2,
            'city'              => $self->to_address->city,
            'prov-state'        => $self->to_address->province_code,
            'postal-zip-code'   => $self->to_address->postal_code,
            'country-code'      => $self->to_address->country_code,
          },
          'client-voice-number' => $self->to_address()->phone || '',
        },
        'preferences' => {
          'show-packing-instructions' => 'false',
        },
        'settlement-info' => {
          'paid-by-customer' => $self->bill_account,
          'contract-id' => $self->contract_id,
          'intended-method-of-payment' => 'Account',
        },
      },
    };

    if ($self->signature_type eq 'required') {
      push @{ $data->{'delivery-spec'}->{'options'}->{option} }, { 'option-code' => 'SO' };
    }
    elsif ($self->signature_type eq 'adult') {
      push @{ $data->{'delivery-spec'}->{'options'}->{option} }, { 'option-code' => 'PA18' };
    }

    if ($self->to_address->country_code ne 'CA') {
      my $non_delivery_handling = $self->non_delivery_handling;
      if (!$non_delivery_handling) {
        if ($service_id eq 'USA.TP' || $service_id eq 'INT.TP') {
          $non_delivery_handling = 'RTS';
        }
        else {
          $non_delivery_handling = 'RASE';
        }
      }
      push @{ $data->{'delivery-spec'}->{'options'}->{option} }, { 'option-code' => $non_delivery_handling };
    }

    if ($self->to_address->email) {
      $data->{'delivery-spec'}->{'notification'} = {
        'email' => $self->to_address->email,
        'on-shipment' => 'true',
        'on-exception' => 'true',
        'on-delivery' => 'true',
      };
    }

    if ($self->printer_type =~ /(thermal|zpl)/i) {
      $data->{'delivery-spec'}->{'print-preferences'} = {
        'output-format' => '4x6',
        'encoding' => 'ZPL',
      };
    }
    else {
      $data->{'delivery-spec'}->{'print-preferences'} = {
        'output-format' => '8.5x11',
        'encoding' => 'PDF',
      };
    }

    if ($self->get_reference(0)) {
      $data->{'delivery-spec'}->{'references'}->{'customer-ref-1'} = $self->get_reference(0);
    }
    if ($self->get_reference(1)) {
      $data->{'delivery-spec'}->{'references'}->{'customer-ref-2'} = $self->get_reference(1);
    }

    my $schema = XML::Compile::Schema->new( $Shipment::CanadaPost::XSD::shipment . $Shipment::CanadaPost::XSD::common );

    my $shipment_id;
    my $cost = 0;
    my $etd = 0;
    my $eta;
    my $package_index = 0;
    foreach my $package (@{ $self->packages }) {

      my $weight = $package->weight;
      if ($self->weight_unit eq 'lb') {
        $weight = sprintf('%.4f', $weight * 0.4535924);
      }
      elsif ($self->weight_unit eq 'oz') {
        $weight = sprintf('%.4f', $weight * 0.02834952);
      }
      my ($l, $w, $h) = ($package->length, $package->width, $package->height);
      if ($self->dim_unit eq 'in') {
        $l = sprintf('%.4f', $l * 2.54);
        $w = sprintf('%.4f', $w * 2.54);
        $h = sprintf('%.4f', $h * 2.54);
      }
      $data->{'delivery-spec'}->{'parcel-characteristics'} = {
        weight => $weight,
        dimensions => {
          length => $l,
          width => $w,
          height => $h,
        },
      };

      if ($self->to_address->country_code ne 'CA') {
        $data->{'delivery-spec'}->{'customs'} = {
          'currency' => $self->customs_currency,
          'conversion-from-cad' => $self->customs_conversion,
          'reason-for-export' => $self->customs_reason,
          'sku-list' => { 'item' => [] },
        };
        foreach my $item (@{$package->items}) {
          my $origin_country;
          if ($item->{origin_country}) {
            my $origin_country = $item->{origin_country};
            if ($origin_country =~ /korea/i) {
              $origin_country = 'KR';
            }
            use Locale::SubCountry;
            my $country = Locale::SubCountry->new($origin_country);
            $origin_country = $country->country_code if $country && $country->country_code;
          }
          my $item_weight = $item->{weight};
          if ($item_weight) {
            if ($self->weight_unit eq 'lb') {
              $item_weight = sprintf('%.4f', $item_weight * 0.4535924);
            }
            elsif ($self->weight_unit eq 'oz') {
              $item_weight = sprintf('%.4f', $item_weight * 0.02834952);
            }
          }
          push @{$data->{'delivery-spec'}->{'customs'}->{'sku-list'}->{'item'}}, {
            'customs-number-of-units' => $item->{quantity} || 1,
            'customs-description' => substr($item->{customs_description},0,44) || 'Misc',
            'unit-weight' => $item_weight || $weight,
            'customs-value-per-unit' => $item->{customs_value} || 1,
            'country-of-origin' => $origin_country,
          };
        }
        if (!scalar @{$data->{'delivery-spec'}->{'customs'}->{'sku-list'}->{item}}) {
          push @{$data->{'delivery-spec'}->{'customs'}->{'sku-list'}->{'item'}}, {
            'customs-number-of-units' => 1,
            'customs-description' => 'Misc',
            'unit-weight' => $weight,
            'customs-value-per-unit' => 1,
          };
        }
      }

      my $xml_data = $schema->compile('WRITER', '{http://www.canadapost.ca/ws/shipment-v8}shipment')->(
          XML::LibXML::Document->new('1.0', 'UTF-8'), $data
        )->toString;
      warn 'XML Request: ' . $xml_data if $self->debug;

      my $url = 'https://' . $self->endpoint . '/rs/' . $self->account . '/' . $self->bill_account . '/shipment';

      use File::Util;
      my $f = File::Util->new();
      my $tmp_file = $self->tmp_file_dir . '/shipment_canada_post' . time();
      $f->write_file( file => $tmp_file, bitmask => 0644, content => $xml_data );
      my $username = $self->username;
      my $password = $self->password;
      my $response = `curl -s -w "%{http_code}" -H "Content-Type: application/vnd.cpc.shipment-v8+xml" -H "Accept: application/vnd.cpc.shipment-v8+xml" -u $username:$password -d \@$tmp_file $url`;
      unlink $tmp_file;
      $response =~ s/(\d\d\d)$//;
      my $status = $1;
      warn 'HTTP Status: ' . $status if $self->debug;
      warn 'XML Response: ' . $response if $self->debug;

      if ($status ne '200') {
        $self->error( 'shipment request failed with message: ' . $self->_messages($response) );
        return;
      }

      my $reader = $schema->compile(READER => '{http://www.canadapost.ca/ws/shipment-v8}shipment-info');
      my $shipment = $reader->($response);

      $shipment_id ||= $shipment->{'shipment-id'};
      $cost += $shipment->{'shipment-price'}->{'due-amount'};
      $etd ||= $shipment->{'shipment-price'}->{'service-standard'}->{'expected-transmit-time'} || $shipment->{'shipment-price'}->{'service-standard'}->{'expected-transit-time'};
      my ($y, $m, $d) = split('-', $shipment->{'shipment-price'}->{'service-standard'}->{'expected-delivery-date'});
      if ($y && $m && $d) {
        $eta ||= { year => $y, month => $m, day => $d };
      }

      my $tracking_id = $shipment->{'tracking-pin'};
      $self->get_package($package_index)->id( $shipment->{'shipment-id'} );
      $self->get_package($package_index)->tracking_id( $tracking_id );
      $self->get_package($package_index)->cost( Data::Currency->new($shipment->{'shipment-price'}->{'due-amount'}, 'CAD') );

      my $label_url;
      my $commercial_invoice_url;
      my $label_data;
      foreach my $link (@{$shipment->{'links'}->{'link'}}) {
        if ($link->{'rel'} eq 'label') {
          $label_url = $link->{'href'};
        }
        if ($link->{'rel'} eq 'commercialInvoice') {
          $commercial_invoice_url = $link->{'href'};
        }
      }
      if ($label_url) {
        my $response = $ua->get( $label_url, 'Accept' => ($self->printer_type =~ /(thermal|zpl)/i ? 'application/zpl' : 'application/pdf'));

        if (!$response->is_success) {
          warn $response->status_line if $self->debug;
          $self->error( 'label request failed with status: ' . $response->status_line );
        }
        else {

          warn 'LABEL Response: ' . $response->content if $self->debug;
          $label_data = $response->content;
        }
      }

      if ($commercial_invoice_url) {
        my $response = $ua->get( $commercial_invoice_url, 'Accept' => ($self->printer_type =~ /(thermal|zpl)/i ? 'application/zpl' : 'application/pdf'));

        if (!$response->is_success) {
          warn $response->status_line if $self->debug;
          $self->error( 'commercial invoice request failed with status: ' . $response->status_line );
        }
        else {

          warn 'COMMERCIAL INVOICE Response: ' . $response->content if $self->debug;
          $label_data .= "\n\n" . $response->content;
        }
      }

      if ($label_data) {
        $self->get_package($package_index)->label(
          Shipment::Label->new(
            {
              tracking_id => $tracking_id,
              content_type => ($self->printer_type =~ /(thermal|zpl)/i ? 'text/canadapost-zpl' : 'application/pdf'),
              data => $label_data,
              file_name => $shipment->{'tracking-pin'} . '.' . ($self->printer_type =~ /(thermal|zpl)/i ? 'zpl' : 'pdf'),
            },
         )
        );
      }
      $package_index++;
      
    }

    $self->tracking_id( $shipment_id );
    $self->service( 
       Shipment::Service->new( 
        id    => $service_id,
        name  => $self->services->{$service_id}->name,
        cost  => Data::Currency->new($cost, 'CAD'),
        etd   => $etd,
        eta   => $eta,
      )
    );

  }
  else {
    # from and to address required
    $self->error( "Both from and to address are required for shipping." );
  }

  return;

}


=head1 AUTHOR

Andrew Baerg @ <andrew at pullingshots dot ca>

http://pullingshots.ca/

=head1 BUGS

Please contact me directly.

=head1 COPYRIGHT

Copyright (C) 2021 Andrew J Baerg, All Rights Reserved

=head1 NO WARRANTY

Absolutely, positively NO WARRANTY, neither express or implied, is
offered with this software.  You use this software at your own risk.  In
case of loss, no person or entity owes you anything whatsoever.  You
have been warned.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
