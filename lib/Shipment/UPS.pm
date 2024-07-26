package Shipment::UPS;
use strict;
use warnings;

use Shipment::UPS::API;

=head1 NAME

Shipment::UPS - Interface to UPS Shipping Web Services

=head1 SYNOPSIS

  use Shipment::UPS;
  use Shipment::Address;
  use Shipment::Package;

  my $shipment = Shipment::UPS->new(
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

This class provides an interface to the UPS RESTful APIs for rating and shipping. You must sign up for a developer access key in order to make use of this module.

https://developer.ups.com/api/reference

=cut

use Try::Tiny;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use MooX::Aliases;
use namespace::clean;

extends 'Shipment::Base';

=head1 Class Attributes

=head2 client_id, client_secret

Credentials required to access UPS Online Tools.

=cut

has 'client_id' => (
  is => 'ro',
  isa => Str,
  alias => 'username',
);

has 'client_secret' => (
  is => 'ro',
  isa => Str,
  alias => 'password',
);

has 'proxy_domain' => (
  is => 'rw',
  isa => Str,
  trigger => sub {
    my ($self, $value) = @_;
    $self->environment('production') if $value eq 'https://onlinetools.ups.com';
  },
);

has 'environment' => (
  is => 'rw',
  isa => Enum[ qw( cie production ) ],
  default => 'cie',
  trigger => sub {
    my $self = shift;
    $self->clear_api();
  }
);

has 'api' => (
  is => 'ro',
  isa => InstanceOf['Shipment::UPS::API'],
  lazy => 1,
  clearer => 1,
  builder => 1,
);

sub _build_api {
  my $self = shift;
  return Shipment::UPS::API->new(
    debug => $self->debug,
    client_id => $self->client_id,
    client_secret => $self->client_secret,
    account_number => $self->account,
    api_url => ($self->environment eq 'production' ? 'https://onlinetools.ups.com' : 'https://wwwcie.ups.com'),
    preserve_token => $self->preserve_token ? $self->preserve_token : undef
  );
};

=head2 preserve_token

  A subroutine that handle saving and retrieving the access token.
  This sub is useful when you want to save the access token to prevent
  rate limiting on the UPS Auth API.

  Default behavior is to save the access token and expired time to a file
  in your system's temp directory.

=cut
has 'preserve_token' => (
  is => 'rw',
  isa => CodeRef,
  default => sub {
    my $self = shift;

    # Write the access token to a file and read it again to
    # prevent rate limiting on UPS API
    sub {
      my ($args) = @_;

      use File::Slurp qw(write_file read_file);
      use File::Spec;
      use Try::Tiny;
      my $tmp_dir = File::Spec->tmpdir();
      if ($args->{access_token} && $args->{expires_in}) {
        # To prevent edge case of almost expired token,
        # we set it to expire 10 mins early.
        my $expired_time = time + ($args->{expires_in} * 1) - 600;
        try {
          write_file(
            $tmp_dir . "/ups_access_token_" . $self->client_id,
            join('|', $args->{access_token}, $expired_time)
          );
        } catch {
          warn "Failed to write access token to file: $_" if $self->debug;
        }
      }

      try {
        my $preserve_token = read_file($tmp_dir . '/ups_access_token_' . $self->client_id);
        my ($access_token, $expired_time) = split(/\|/, $preserve_token);
        return $access_token if $expired_time > time;
      } catch {
        warn "Failed to read access_token from file: $_" if $self->debug;
      }
    };
  }
);


=head2 negotiated_rates

Turn negotiated rates on or off.

The Shipper Account/UserID used must be qualified to receive negotiated rates. You will most likely need to contact UPS to have set this up.

If the Shipper Account/UserID is not qualified, the published rates will be used instead and a notice set.

Default is off.

=cut

has 'negotiated_rates' => (
  is => 'rw',
  isa => Bool,
  default => 0,
);

=head2 residential_address

Flag the ship to address as residential.

Default is false.

=cut

has 'residential_address' => (
  is => 'rw',
  isa => Bool,
  default => 0,
);

=head2 address_validation

Turn address validation on or off. When on, ship will fail if the address does not pass UPS address validation

Default is on.

=cut

has 'address_validation' => (
  is => 'rw',
  isa => Bool,
  default => 1,
);

=head2 label_height

The label height. Can be either 6" or 8". The label width is fixed at 4".

=cut

has 'label_height' => (
  is => 'rw',
  isa => Enum[ qw( 6 8 ) ],
  default => 6,
);

=head2 control_log_receipt

In certain cases (i.e. for shipments with declared value over $999), UPS will return a control log receipt which must be printed off along with the label.

type: Array[Shipment::Label]

=cut

has 'control_log_receipt' => (
  is => 'rw',
  isa => ArrayRef[InstanceOf['Shipment::Label']],
  default => sub { [] },
);

=head2 carbon_neutral

Set the Carbon Neutral Indicator - http://www.ups.com/content/us/en/resources/ship/carbonneutral/shipping.html

type: Bool

=cut

has 'carbon_neutral' => (
  is => 'rw',
  isa => Bool,
  default => undef,
);

=head1 Type Maps

=head2 service_map

UPS returns service codes without descriptions. This is mapped here so that we can display 'UPS Ground' instead of '03'.

=cut

my %service_map = (
  '01' => 'UPS Next Day Air',
  '02' => 'UPS Second Day Air',
  '03' => 'UPS Ground',
  '07' => 'UPS Worldwide Express',
  '08' => 'UPS Worldwide Expedited',
  '11' => 'UPS Standard',
  '12' => 'UPS Three-Day Select',
  '13' => 'UPS Next Day Air Saver',
  '14' => 'UPS Next Day Air Early A.M.',
  '54' => 'UPS Worldwide Express Plus',
  '59' => 'UPS Second Day Air A.M.',
  '65' => 'UPS Saver',
  '82' => 'UPS Today Standard',
  '83' => 'UPS Today Dedicated Courier',
  '85' => 'UPS Today Express',
  '86' => 'UPS Today Express Saver',
  '93' => 'UPS SurePost 1 lb or Greater',
  'CA' => {
    '01' => 'UPS Express',
    '13' => 'UPS Express Saver',
    '65' => 'UPS Worldwide Express Saver',
    '02' => 'UPS Expedited',
  },
);

## Rating code to Shipping code map for cases when they differ
my %service_code_map = (
  'CA' => {
    '07' => '01',
    '13' => '65',
    '02' => '08',
  },
);

=head2 country_code_map

UPS needs the country code overridden for some US territories

=cut

my %country_code_map = (
  'GU' => 'GU',
  'PR' => 'PR',
  'MP' => 'MP',
  'AS' => 'AS',
  'VI' => 'VI',
  'FM' => 'FM',
);

=head2 Shipment::Base type maps

Shipment::Base provides abstract types which need to be mapped to UPS codes (i.e. bill_type of "sender" maps to UPS "BillShipper")

=cut

my %bill_type_map = (
  'sender'      => 'BillShipper',
  'recipient'   => 'BillReceiver',
  'third_party' => 'BillThirdParty',
);

my %signature_type_map = (
  'default'      => undef,
  'required'     => '1',
  'not_required' => undef,
  'adult'        => '2',
);

my %package_type_map = (
  'custom'              => '02',
  'envelope'            => '01',
  'tube'                => '03',
  'box'                 => '21',
  'pack'                => '04',
  '25kg_box'            => '24',
  '10kg_box'            => '25',
  'pallet'              => '30',
  'small_express_box'   => '2a',
  'medium_express_box'  => '2b',
  'large_express_box'   => '2c',
);

my %units_type_map = (
  'lb'          => 'LBS',
  'kg'          => 'KGS',
  'in'          => 'IN',
  'cm'          => 'CM',
);

=head2 custom package types

UPS provides package types in addition to the defaults in Shipment::Base
  * 25kg_box
  * 10kg_box
  * pallet
  * small_express_box
  * medium_express_box
  * large_express_box

=cut

has '+package_type' => (
  isa => Enum[qw( custom envelope tube box pack 25kg_box 10kg_box pallet small_express_box medium_express_box large_express_box )]
);

my %printer_type_map = (
  'pdf'     => '',
  'thermal' => 'EPL',
  'image'   => 'GIF',
  'ZPL'     => 'ZPL',
  'SPL'     => 'SPL',
  'STARPL'  => 'STARPL',
);

my %label_content_type_map = (
  'thermal' => 'text/ups-epl',
  'image'   => 'image/gif',
  'ZPL'     => 'text/ups-zpl',
  'SPL'     => 'text/ups-spl',
  'STARPL'  => 'text/ups-starpl',
);

=head2 custom printer types

UPS does not offer a pdf option for labels, so the default printer type is image (gif).

UPS does offer additional thermal options:
  * ZPL
  * SPL
  * STARPL

=cut

# FIXME: check whether this is needed:
#enum 'PrinterOptions' => [qw( thermal image ZPL SPL STARPL )];

has '+printer_type' => (
  default => 'image',
);

=head2 default currency

The default currency is USD

=cut

has '+currency' => (
  default => 'USD',
);

=head2 surepost

Enable UPS SurePost

=cut

has 'surepost' => (
  is => 'rw',
  isa => Bool,
  default => undef,
);

=head1 Class Methods

=head2 _build_services

This calls the Rating API with RequestOption => 'Shop'

Each RatedShipment that is returned is added to services

The following service mapping is used:
  * ground => 03 (UPS Ground) or 11 (UPS Standard)
  * express => 02 (UPS Second Day Air)
  * priority => 01 (UPS Next Day Air)

This method ignores what is in $self->packages and uses a single package weighing 1 pound for rating. The idea is to list what services are available, but for accurate rate comparisons, the rate method should be used.

=cut

sub _build_services {
  my $self = shift;

  use Shipment::Package;
  use Shipment::Service;

  my $response;

    my $options;
    $options->{DeliveryConfirmation}->{DCISType} = $signature_type_map{$self->signature_type} if defined $signature_type_map{$self->signature_type};
    $options->{DeclaredValue}->{CurrencyCode} = $self->currency;

    my $rating_options;
    $rating_options->{NegotiatedRatesIndicator} = "1" if $self->negotiated_rates;

    my $shipment_options;
    $shipment_options->{UPScarbonneutralIndicator} = '' if $self->carbon_neutral;

    my @pieces;
    foreach (@{ $self->packages }) {
      $options->{DeclaredValue}->{MonetaryValue} = '' . $self->insured_value->value;

      ## SurePost doesn't accept service options
      $options = undef if $self->surepost;

      push @pieces,
        {
            PackagingType => {
              Code => $package_type_map{$self->package_type} || $self->package_type,
            },
            Dimensions => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->dim_unit} || $self->dim_unit,
              },
              Length => '' . $_->length,
              Width => '' . $_->width,
              Height => '' . $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->weight_unit} || $self->weight_unit,
              },
              Weight => '' . $_->weight,
            },
            PackageServiceOptions => $options,
        };
    }

    my @from_addresslines = (
      $self->from_address->address1,
      $self->from_address->address2,
      $self->from_address->address3
    );
    my @to_addresslines = (
      $self->to_address->address1,
      $self->to_address->address2,
      $self->to_address->address3
    );

  my $shipto = {
            Address => {
              AddressLine       => \@to_addresslines,
              City              => $self->to_address()->city,
              StateProvinceCode => $self->to_address()->province_code,
              PostalCode        => $self->to_address()->postal_code,
              CountryCode       => $country_code_map{$self->to_address()->province_code} || $self->to_address()->country_code,
            },
  };
  $shipto->{Address}->{ResidentialAddressIndicator} = "1" if $self->{residential_address};
  $shipto->{Phone}{Number} = $self->to_address->phone
     if $self->to_address->phone;

  my %services;
  try {
    $response = $self->api->shop(
      {
        Request => {
          RequestOption => 'Shop',
        },
        Shipment => {
          Shipper => {
            ShipperNumber => $self->account,
            Address => {
              AddressLine       => \@from_addresslines,
              City              => $self->from_address()->city,
              StateProvinceCode => $self->from_address()->province_code,
              PostalCode        => $self->from_address()->postal_code,
              CountryCode       => $self->from_address()->country_code,
            },
          },
          ShipTo => $shipto,
          ShipmentRatingOptions => $rating_options,
          Package => \@pieces,
          ShipmentServiceOptions => $shipment_options,
        },
      }
    );

    foreach my $service (@{ $response->{RateResponse}->{RatedShipment} }) {
      my $rate = $service->{TotalCharges}->{MonetaryValue};
      my $currency = $service->{TotalCharges}->{CurrencyCode};
      if ($self->negotiated_rates) {
        if ($service->{NegotiatedRateCharges}) {
          $rate = $service->{NegotiatedRateCharges}->{TotalCharge}->{MonetaryValue};
          $currency = $service->{NegotiatedRateCharges}->{TotalCharge}->{CurrencyCode};
        }
      }
      $services{$service->{Service}->{Code}} = Shipment::Service->new(
          id => $service->{Service}->{Code},
          name => (
              $service_map{$self->from_address()->country_code}->{$service->{Service}->{Code}}
                ||
              $service_map{$service->{Service}->{Code}}
            ),
          cost => Data::Currency->new($rate, $currency),
        );
    }
    $services{ground} = $services{'03'} || $services{'11'} || undef;
    $services{express} = $services{'02'} || $services{'13'} || $services{'65'} || undef;
    $services{priority} = $services{'01'} || undef;
    foreach (qw/ground express priority/) {
      delete $services{$_} if !$services{$_};
    }

    $self->notice( '' );
    if ( $response->{Response}->{Alert} ) {
      foreach my $alert (@{$response->{Response}->{Alert}}) {
        warn "Notice: " . $alert->{Description} if $self->debug;
        $self->add_notice( $alert->{Description} . "\n" );
      }
    }

  } catch {
    my $error = $_;
    warn $error if $self->debug;
    $self->error( $error );
  };

  if ($self->surepost) {
    if ($self->error) {
      $self->add_notice( 'All services other than SurePost failed due to error: ' . $self->error . "\n" );
      $self->error('');
    }
    $services{93} = Shipment::Service->new(
        id => '93',
        name => $service_map{93},
      );
    $services{surepost} = $services{93};
  }

  \%services;
}

=head2 rate

This calls ProcessRate from the Rating API with RequestOption => 'Rate'

=cut

sub rate {
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

    my $options;
    $options->{DeliveryConfirmation}->{DCISType} = $signature_type_map{$self->signature_type} if defined $signature_type_map{$self->signature_type};
    $options->{DeclaredValue}->{CurrencyCode} = $self->currency;

    my $rating_options;
    $rating_options->{NegotiatedRatesIndicator} = "1" if $self->negotiated_rates;

    my $shipment_options;
    $shipment_options->{UPScarbonneutralIndicator} = '' if $self->carbon_neutral;

    my @pieces;
    foreach (@{ $self->packages }) {
      $options->{DeclaredValue}->{MonetaryValue} = '' .$self->insured_value->value;

      ## SurePost doesn't accept service options
      $options = undef if $self->surepost && $service_id eq '93';

      push @pieces,
        {
            PackagingType => {
              Code => $package_type_map{$self->package_type} || $self->package_type,
            },
            Dimensions => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->dim_unit} || $self->dim_unit,
              },
              Length => '' . $_->length,
              Width => ''. $_->width,
              Height => '' . $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->weight_unit} || $self->weight_unit,
              },
              Weight => '' . $_->weight,
            },
            PackageServiceOptions => $options,
        };
    }

    my @from_addresslines = (
      $self->from_address->address1,
      $self->from_address->address2,
      $self->from_address->address3
    );
    my @to_addresslines = (
      $self->to_address->address1,
      $self->to_address->address2,
      $self->to_address->address3
    );


  my $shipto = {
            Address => {
              AddressLine       => \@to_addresslines,
              City              => $self->to_address()->city,
              StateProvinceCode => $self->to_address()->province_code,
              PostalCode        => $self->to_address()->postal_code,
              CountryCode       => $country_code_map{$self->to_address()->province_code} || $self->to_address()->country_code,
            },
  };
  $shipto->{Address}->{ResidentialAddressIndicator} = "1" if $self->{residential_address};
  $shipto->{Phone}{Number} = $self->to_address->phone
     if $self->to_address->phone;

  my $response;
  try {
    $response = $self->api->rate(
      {
        Request => {
          RequestOption => 'Rate',
        },
        Shipment => {
          Shipper => {
            ShipperNumber => $self->account,
            Address => {
              AddressLine       => \@from_addresslines,
              City              => $self->from_address->city,
              StateProvinceCode => $self->from_address->province_code,
              PostalCode        => $self->from_address->postal_code,
              CountryCode       => $self->from_address->country_code,
            },
          },
          ShipTo => $shipto,
          ShipmentRatingOptions => $rating_options,
          Service => {
            Code => $service_id,
          },
          Package => \@pieces,
          ShipmentServiceOptions => $shipment_options,
        },
      }
    );

    use Data::Currency;
    use Shipment::Service;
    my $rate = $response->{RateResponse}->{RatedShipment}->{TotalCharges}->{MonetaryValue};
    my $currency = $response->{RateResponse}->{RatedShipment}->{TotalCharges}->{CurrencyCode};
    if ($self->negotiated_rates) {
      if ($response->{RateResponse}->{RatedShipment}->{NegotiatedRateCharges}) {
        $rate = $response->{RateResponse}->{RatedShipment}->{NegotiatedRateCharges}->{TotalCharge}->{MonetaryValue};
        $currency = $response->{RateResponse}->{RatedShipment}->{NegotiatedRateCharges}->{TotalCharge}->{CurrencyCode};
      }
    }
    $self->service(
      new Shipment::Service(
        id        => $service_id,
        name      => (
              $service_map{$self->from_address()->country_code}->{$response->{RateResponse}->{RatedShipment}->{Service}->{Code}}
                ||
              $service_map{$response->{RateResponse}->{RatedShipment}->{Service}->{Code}}
            ),
        cost      => Data::Currency->new($rate, $currency),
      )
    );

    $self->notice( '' );
    if ( $response->{Response}->{Alert} ) {
      foreach my $alert (@{$response->{Response}->{Alert}}) {
        warn $alert->{Description} if $self->debug;
        $self->add_notice( $alert->{Description} . "\n" );
      }
    }
  } catch {
    my $error = $_;
    warn $error if $self->debug;
    $self->error( $error );
  };

}

=head2 ship

This method calls ProcessShipment from the Shipping API

=cut

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

    my $package_options;
    $package_options->{DeliveryConfirmation}->{DCISType} = $signature_type_map{$self->signature_type} if defined $signature_type_map{$self->signature_type};
    $package_options->{DeclaredValue}->{CurrencyCode} = $self->currency;

    my $shipment_options;
    if ($self->to_address->email) {
      $shipment_options->{Notification}->{NotificationCode} = '6';
      $shipment_options->{Notification}->{EMail}->{EMailAddress} = $self->to_address->email;
      $shipment_options->{Notification}->{EMail}->{SubjectCode} = '03'; 
    }
    $shipment_options->{UPScarbonneutralIndicator} = '' if $self->carbon_neutral;

    my $rating_options;
    $rating_options->{NegotiatedRatesIndicator} = "1" if $self->negotiated_rates;

    my @pieces;
    my $reference_index = 1;
    foreach (@{ $self->packages }) {
      $package_options->{DeclaredValue}->{MonetaryValue} = ''. $self->insured_value->value;

      ## SurePost doesn't accept service options
      $package_options = undef if $self->surepost && $service_id eq '93';

      my @references;
      if (
        $self->references &&
        $self->from_address->country_code =~ /(US|PR)/ &&
        $self->to_address->country_code =~ /(US|PR)/ &&
        $self->from_address->country_code eq $self->to_address->country_code
      ) {
        foreach ($self->get_reference(0), $self->get_reference(1)) {
          next if !$_;
          push @references, {
            Code => '' . $reference_index,
            Value => $_,
          };
          $reference_index++;
        }
      }
      push @pieces,
        {
            Packaging => {
              Code => $package_type_map{$self->package_type} || $self->package_type,
            },
            Dimensions => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->dim_unit} || $self->dim_unit,
              },
              Length => ''. $_->length,
              Width => ''. $_->width,
              Height => ''. $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->weight_unit} || $self->weight_unit,
              },
              Weight => ''. $_->weight,
            },
            ReferenceNumber => \@references,
            PackageServiceOptions => $package_options,
        };
    }

    my $payment_option;
    $payment_option->{Type} = '01';
    $payment_option->{$bill_type_map{$self->bill_type}}->{AccountNumber} = $self->bill_account;
    $payment_option->{$bill_type_map{$self->bill_type}}->{Address}->{PostalCode} = $self->bill_address->postal_code if $self->bill_type =~ /(recipient|third_party)/ && $self->bill_address;
    $payment_option->{$bill_type_map{$self->bill_type}}->{Address}->{CountryCode} = $self->bill_address->country_code if $self->bill_type eq 'third_party' && $self->bill_address;

    my @from_addresslines = (
      $self->from_address->address1,
      $self->from_address->address2,
      $self->from_address->address3
    );
    my @to_addresslines = (
      $self->to_address->address1,
      $self->to_address->address2,
      $self->to_address->address3
    );

  my $shipto = {
            Name => $self->to_address->company,
            AttentionName => $self->to_address->name,
            Address => {
              AddressLine       => \@to_addresslines,
              City              => $self->to_address->city,
              StateProvinceCode => $self->to_address->province_code,
              PostalCode        => $self->to_address->postal_code,
              CountryCode       => $country_code_map{$self->to_address->province_code} || $self->to_address->country_code,
            },
          };
  $shipto->{Address}->{ResidentialAddressIndicator} = "1" if $self->{residential_address};
  $shipto->{Phone}{Number} = $self->to_address->phone
     if $self->to_address->phone;

  my $response;
  try {
    $response = $self->api->ship(
      {
        Request => {
          RequestOption => ($self->address_validation) ? 'validate' : 'nonvalidate',
        },
        Shipment => {
          Shipper => {
            Name => $self->from_address->company,
            AttentionName => $self->from_address->name,
            ShipperNumber => $self->account,
            Address => {
              AddressLine       => \@from_addresslines,
              City              => $self->from_address->city,
              StateProvinceCode => $self->from_address->province_code,
              PostalCode        => $self->from_address->postal_code,
              CountryCode       => $self->from_address->country_code,
            },
            Phone => { Number => $self->from_address()->phone || '0000000000' },
          },
          ShipTo => $shipto,
          ShipmentRatingOptions => $rating_options,
          Service => {
            Code => ($service_code_map{$self->from_address->country_code}->{$service_id} || $service_id),
          },
          Package => \@pieces,
          PaymentInformation =>  {
            ShipmentCharge => $payment_option,
          },
          ShipmentServiceOptions => $shipment_options,
        },
        LabelSpecification =>  {
          LabelImageFormat =>  {
            Code =>  $printer_type_map{$self->printer_type},
          },
          LabelStockSize =>  {
            Height => '' . $self->label_height,
            Width =>  '4',
          },
        },
      }
    );

    use Data::Currency;
    use Shipment::Service;
    $self->tracking_id( $response->{ShipmentResponse}->{ShipmentResults}->{ShipmentIdentificationNumber} );
    my $rate = 0;
    my $currency = $self->currency;
    if ($response->{ShipmentResponse}->{ShipmentResults}->{ShipmentCharges} && $response->{ShipmentResponse}->{ShipmentResults}->{ShipmentCharges}->{TotalCharges}) {
      $rate = $response->{ShipmentResponse}->{ShipmentResults}->{ShipmentCharges}->{TotalCharges}->{MonetaryValue};
      $currency = $response->{ShipmentResponse}->{ShipmentResults}->{ShipmentCharges}->{TotalCharges}->{CurrencyCode};
    }
    if ($self->negotiated_rates) {
      if ($response->{ShipmentResponse}->{ShipmentResults}->{NegotiatedRateCharges} && $response->{ShipmentResponse}->{ShipmentResults}->{NegotiatedRateCharges}->{TotalCharge}) {
        $rate = $response->{ShipmentResponse}->{ShipmentResults}->{NegotiatedRateCharges}->{TotalCharge}->{MonetaryValue};
        $currency = $response->{ShipmentResponse}->{ShipmentResults}->{NegotiatedRateCharges}->{TotalCharge}->{CurrencyCode};
      }
    }
    $self->service(
      new Shipment::Service(
        id        => $service_id,
        name      => $self->services->{$service_id}->name,
        cost      => Data::Currency->new($rate, $currency),
      )
    );

    use Shipment::Label;
    use MIME::Base64;
    my $package_index = 0;

    # PackageResults can be either an object or an array of objects
    # If it's an object, convert it to an array
    my @package_results;
    if (ref $response->{ShipmentResponse}->{ShipmentResults}->{PackageResults} eq 'HASH') {
      @package_results = ( $response->{ShipmentResponse}->{ShipmentResults}->{PackageResults} );
    } else {
      @package_results = @{ $response->{ShipmentResponse}->{ShipmentResults}->{PackageResults} };
    }

    foreach (@package_results) {
      $self->get_package($package_index)->tracking_id( $_->{TrackingNumber} );

      ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file.
      ## This is needed for cases when the printer defaults to the incorrect orientation.
      my $data = "ZT\n" if $printer_type_map{$self->printer_type} eq 'EPL';
      $data .= decode_base64($_->{ShippingLabel}->{GraphicImage});

      $self->get_package($package_index)->label(
        Shipment::Label->new(
          {
            tracking_id => $_->{TrackingNumber},
            content_type => $label_content_type_map{$self->printer_type},
            data => $data,
            file_name => $_->{TrackingNumber} . '.' . lc $printer_type_map{$self->printer_type},
          },
        )
      );
      $package_index++;
    }

    if (ref $response->{ShipmentResponse}->{ShipmentResults}->{ControlLogReceipt} eq 'ARRAY') {
      my $receipt_index = 0;
      foreach (@{ $response->{ShipmentResponse}->{ShipmentResults}->{ControlLogReceipt} }) {
        ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file.
        ## This is needed for cases when the printer defaults to the incorrect orientation.
        my $data = "ZT\n" if $printer_type_map{$self->printer_type} eq 'EPL';
        $data .= decode_base64($_->{GraphicImage});

        push @{ $self->control_log_receipt },
          Shipment::Label->new(
            {
              content_type => $label_content_type_map{$self->printer_type},
              data => $data,
              file_name => 'control_log_receipt_' . $receipt_index . '.' . lc $printer_type_map{$self->printer_type},
            }
          );
        $receipt_index++;
      }
    }

    $self->notice( '' );
    if ( $response->{Response}->{Alert} ) {
      foreach my $alert (@{$response->{Response}->{Alert}}) {
        warn $alert->{Description} if $self->debug;
        $self->add_notice( $alert->{Description} . "\n" );
      }
    }

  } catch {
    my $error = $_;
    warn $error if $self->debug;
    $self->error( $error );
  };

}

=head2 return

This method calls ProcessShipment from the Shipping API with
  ReturnService => Code => 9
which provides the return label to be printed off.

This method has only been implemented for the purpose of obtaining certification with UPS. It has not been fully tested and does not offer some core options (such as the ability to email the return label).

It assumes that you are first creating an outgoing shipment and creating the return shipment at the same time. Because of this, it uses the "to_address" as the origin and the "from_address" as the destination.

=cut

sub return {
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

    my $package_options;
    $package_options->{DeclaredValue}->{CurrencyCode} = $self->currency;

    my @pieces;
    foreach (@{ $self->packages }) {
      $package_options->{DeclaredValue}->{MonetaryValue} = '' . $self->insured_value->value;
      push @pieces,
        {
            Description => 'n/a',
            Packaging => {
              Code => $package_type_map{$self->package_type} || $self->package_type,
            },
            Dimensions => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->dim_unit} || $self->dim_unit,
              },
              Length => '' . $_->length,
              Width => '' . $_->width,
              Height => '' . $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->weight_unit} || $self->weight_unit,
              },
              Weight => '' . $_->weight,
            },
            PackageServiceOptions => $package_options,
        };
    }

    my $payment_option;
    $payment_option->{Type} = '01';
    $payment_option->{$bill_type_map{$self->bill_type}}->{AccountNumber} = $self->bill_account;
    $payment_option->{$bill_type_map{$self->bill_type}}->{Address}->{PostalCode} = $self->bill_address->postal_code if $self->bill_type =~ /(recipient|third_party)/; 
    $payment_option->{$bill_type_map{$self->bill_type}}->{Address}->{CountryCode} = $self->bill_address->country_code if $self->bill_type eq 'third_party'; 

    my @from_addresslines = (
      $self->from_address->address1,
      $self->from_address->address2,
      $self->from_address->address3
    );
    my @to_addresslines = (
      $self->to_address->address1,
      $self->to_address->address2,
      $self->to_address->address3
    );

  my $response;
  try {
    $response = $self->api->ship(
      {
        Request => {
          RequestOption => ($self->address_validation) ? 'validate' : 'nonvalidate',
        },
        Shipment => {
          ReturnService => {
            Code => '9',
          },
          Shipper => {
            Name => $self->from_address->company,
            AttentionName => $self->from_address->name,
            ShipperNumber => $self->account,
            Address => {
              AddressLine       => \@from_addresslines,
              City              => $self->from_address->city,
              StateProvinceCode => $self->from_address->province_code,
              PostalCode        => $self->from_address->postal_code,
              CountryCode       => $self->from_address->country_code,
            },
          },
          ShipFrom => {
            Name => $self->to_address->company,
            AttentionName => $self->to_address->name,
            Address => {
              AddressLine       => \@to_addresslines,
              City              => $self->to_address->city,
              StateProvinceCode => $self->to_address->province_code,
              PostalCode        => $self->to_address->postal_code,
              CountryCode       => $country_code_map{$self->to_address->province_code} || $self->to_address->country_code,
            },
            EmailAddress => $self->from_address->email,
          },
          ShipTo => {
            Name => $self->from_address->company,
            AttentionName => $self->from_address->name,
            Address => {
              AddressLine       => \@from_addresslines,
              City              => $self->from_address->city,
              StateProvinceCode => $self->from_address->province_code,
              PostalCode        => $self->from_address->postal_code,
              CountryCode       => $self->from_address->country_code,
            },
            EmailAddress => $self->to_address->email,
          },
          Service => {
            Code => $service_id,
          },
          Package => \@pieces,
          PaymentInformation =>  {
            ShipmentCharge => $payment_option,
          },
        },
        LabelSpecification =>  {
          LabelImageFormat =>  {
            Code =>  $printer_type_map{$self->printer_type},
          },
          LabelStockSize =>  {
            Height =>  '' . $self->label_height,
            Width =>  '4',
          },
        },
      }
    );

    $self->tracking_id( $response->{ShipmentResponse}->{ShipmentResults}->{ShipmentIdentificationNumber} );
    use Data::Currency;
    use Shipment::Service;
    $self->service(
      new Shipment::Service(
        id        => $service_id,
        name      => $self->services->{$service_id}->name,
        cost      => Data::Currency->new($response->{ShipmentResponse}->{ShipmentResults}->{ShipmentCharges}->{TotalCharges}->{MonetaryValue}, $response->{ShipmentResponse}->{ShipmentResults}->{ShipmentCharges}->{TotalCharges}->{CurrencyCode}),
      )
    );

    use Shipment::Label;
    use MIME::Base64;
    my $package_index = 0;
    # PackageResults can be either an object or an array of objects
    # If it's an object, convert it to an array
    my @package_results;
    if (ref $response->{ShipmentResponse}->{ShipmentResults}->{PackageResults} eq 'HASH') {
      @package_results = ( $response->{ShipmentResponse}->{ShipmentResults}->{PackageResults} );
    } else {
      @package_results = @{ $response->{ShipmentResponse}->{ShipmentResults}->{PackageResults} };
    }

    foreach (@package_results) {

      ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file.
      ## This is needed for cases when the printer defaults to the incorrect orientation.
      my $data = "ZT\n" if $printer_type_map{$self->printer_type} eq 'EPL';
      $data .= decode_base64($_->{ShippingLabel}->{GraphicImage});

      $self->get_package($package_index)->tracking_id( $_->{TrackingNumber} );
      $self->get_package($package_index)->label(
        Shipment::Label->new(
          {
            tracking_id => $_->{TrackingNumber},
            content_type => $label_content_type_map{$self->printer_type},
            data => $data,
            file_name => $_->{TrackingNumber} . '.' . lc $printer_type_map{$self->printer_type},
          },
        )
      );
      $package_index++;
    }

    if (ref $response->{ShipmentResults}->{ControlLogReceipt} eq 'ARRAY') {
      my $receipt_index = 0;
      foreach (@{ $response->get_ShipmentResults()->get_ControlLogReceipt }) {

        ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file.
        ## This is needed for cases when the printer defaults to the incorrect orientation.
        my $data = "ZT\n" if $printer_type_map{$self->printer_type} eq 'EPL';
        $data .= decode_base64($_->get_GraphicImage->get_value);

        push @{ $self->control_log_receipt },
          Shipment::Label->new(
            {
              content_type => $label_content_type_map{$self->printer_type},
              data => $data,
              file_name => 'control_log_receipt_' . $receipt_index . '.' . lc $printer_type_map{$self->printer_type},
            }
          );
        $receipt_index++;
      }
    }

    $self->notice( '' );
    if ( $response->{Response}->{Alert} ) {
      foreach my $alert (@{$response->{Response}->{Alert}}) {
        warn $alert->{Description} if $self->debug;
        $self->add_notice( $alert->{Description} . "\n" );
      }
    }

  } catch {
    my $error = $_;
    warn $error if $self->debug;
    $self->error( $error );
  };

}


=head2 cancel

This method calls ProcessVoid from the Shipping API

It uses $self->tracking_id for the shipment identification number in order
to void a single package shipment.

It will use all package tracking id's
to void one or more packages within a multi-package shipment.

returns "Voided" if successful

=cut

sub cancel {
  my $self = shift;

  if (!$self->tracking_id) {
    $self->error('no tracking id provided');
    return;
  }

  my $void->{ShipmentIdentificationNumber} = $self->tracking_id;

  my @tracking_ids;
  foreach ($self->all_packages) {
    push @tracking_ids, $_->tracking_id;
  }
  if ( $#tracking_ids ) {
    $void->{TrackingNumber} = \@tracking_ids;
  }

  my $response;
  my $success;

  try {
    $response = $self->api->cancel($void);
    $success = $response->{VoidShipmentResponse}->{SummaryResult}->{Status}->{Description};

    $self->notice( '' );
    if ( $response->{VoidShipmentResponse}->{Response}->{Alert} ) {
      foreach my $alert (@{$response->{VoidShipmentResponse}->{Response}->{Alert}}) {
        warn $alert->{Description} if $self->debug;
        $self->add_notice( $alert->{Description} . "\n" );
      }
    }

  } catch {
    my $error = $_;
    warn $error if $self->debug;
    $self->error( $error );
  };

  return $success;

}

=head2 xav

UPS Address validation

This method calls ProcessXAV from the Shipping API
request_option defaults to 1
1 address validation
2 address classification
3 address validation and classification

=cut

sub xav {
  my ( $self, $request_option ) = @_;

  $request_option //= 1;

  my $response;
  my $success;
  my $result;
  my $classification;
  my @candidates;

  my @to_addresslines = (
    $self->to_address->address1,
    $self->to_address->address2,
    $self->to_address->address3
  );

  try {

    $response = $self->api->xav(
      {
        Request => {
          RequestOption => '' . $request_option
        },
        AddressKeyFormat => {
          AddressLine        => \@to_addresslines,
          PoliticalDivision2 => $self->to_address->city,
          PoliticalDivision1 => $self->to_address->province_code,
          PostcodePrimaryLow => $self->to_address->postal_code,
          CountryCode        => $self->to_address->country_code,
        }
      }
    );
    warn $response if $self->debug > 1;


    if ( $request_option =~ m/[23]/ ) {
      try {
        my $ac = $response->{XAVResponse}->{AddressClassification};
        $classification->{code}        = $ac->{Code};
        $classification->{description} = $ac->{Description};
      }
      catch {};
    }

    try {
      $result = "valid" if defined($response->{XAVResponse}->{ValidAddressIndicator});
    }
    catch {};

    try {
      $result = "invalid" if defined($response->{XAVResponse}->{AmbiguousAddressIndicator})
    }
    catch {};

    try {
      $result = "nocandidates" if defined($response->{XAVResponse}->{NoCandidatesIndicator});
    }
    catch {};

    if ( $result && $result ne "nocandidates" ) {

      # If we are asking for address classification, canidites will also
      # include classification results
      try {

        for my $candidate ( @{ $response->{XAVResponse}->{Candidate} } ) {
          my %a_hash = (
            address1 =>
            $candidate->{AddressKeyFormat}->{AddressLine},
            city => $candidate->{AddressKeyFormat}->{PoliticalDivision2},
            province => $candidate->{AddressKeyFormat}->{PoliticalDivision1},
            postal_code => $candidate->{AddressKeyFormat}
            ->{PostcodePrimaryLow} . "-"
            . $candidate->{AddressKeyFormat}
            ->{PostcodeExtendedLow},
            country =>
            $candidate->{AddressKeyFormat}->{CountryCode},
          );

          if ( $request_option == 3 ) {
            $a_hash{classification}{code} =
            $candidate->{AddressClassification}->{Code};
            $a_hash{classification}{description} =
            $candidate->{AddressClassification}->{Description};
          }
          push @candidates, \%a_hash;
        }

      }
      catch { warn $_ };
    }

  } catch {
    warn $_ if $self->debug;
    my $error = join "\n",  map { $_->{code} . ' - ' . $_->{message} } @{ $response->{response}->{errors} };
    warn $error if $self->debug;
    $self->error( $error );
  };

  return { 'result' => $result, 'candidate' => \@candidates, 'classification' => $classification };
}

=head2 track

This method calls ProcessTrack from the Shipping API

=cut

sub track {
  my ($self) = @_;

  if (!$self->tracking_id) {
    $self->error('no tracking id provided');
    return;
  }

  my $response;

  try {

    $response = $self->api->track(
      {
        Request => {
          InquiryNumber  => $self->tracking_id,
        }
      }
    );

    warn "Response\n" . $response if $self->debug > 1;

    my $shipments = $response->{trackResponse}->{shipment};

    $shipments->[0] or die 'failed to get tracking';

    my $shipment = $shipments->[0];

    my @activities = ();
    for my $package ( @{ $shipment->{package} } ) {
      for my $activity ( @{ $package->{activity} } ) {

        my ($city, $state, $country);

        if ($activity->{location} && $activity->{location}->{address}) {
          $city = $activity->{location}->{address}->{city};
          $state = $activity->{location}->{address}->{state};
          $country = $activity->{location}->{address}->{country};
        }

        if ($self->can('add_activity')) {
          eval { require Shipment::Activity; };
          use DateTime::Format::ISO8601;

          $self->add_activity(
            Shipment::Activity->new(
              description => $activity->{status}->{description},
              date => DateTime::Format::ISO8601->parse_datetime($activity->{date} . 'T' . $activity->{time}),
              location => Shipment::Address->new(
                city => ($city || ''),
                state => ($state || ''),
                country => ($country || '')
              )
            )
          );
        }
      }
    }
    return 1;
  } catch {
    warn $_ if $self->debug;
    my $error = join "\n",  map {
      $_->{code} . ' - ' . $_->{message}
    } @{ $response->{response}->{errors} };
    warn $error if $self->debug;
    $self->error( $error );
  };
}

=head1 AUTHOR

Andrew Baerg @ <andrew at pullingshots dot ca>

http://pullingshots.ca/

William Taylor @ <williamt at sonic dot net>

=head1 BUGS

Issues can be submitted at https://github.com/pullingshots/Shipment/issues

=head1 COPYRIGHT

Copyright (C) 2016 Andrew J Baerg, All Rights Reserved

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
