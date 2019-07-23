package Shipment::UPS;
use strict;
use warnings;

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

This class provides an interface to the UPS Online Tools.

For code examples, see https://github.com/pullingshots/Shipment/tree/master/eg

You must sign up for a developer access key in order to make use of this module.

https://www.ups.com/upsdeveloperkit

See related modules for documentation on options and how to access rates and labels:
  
L<Shipment::Base> - common attributes and methods for all interfaces

L<Shipment::Address> - define an from or to address

L<Shipment::Package> - define package details, weight, dimensions, etc

L<Shipment::Service> - access information about a service, rate, etd, etc

L<Shipment::Label> - access the label file

It makes extensive use of SOAP::WSDL in order to create/decode xml requests and responses. The Shipment::UPS::WSDL interface was created primarily using the wsdl2perl.pl script from SOAP::WSDL.

=cut

use Try::Tiny;
use Shipment::SOAP::WSDL;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use namespace::clean;

extends 'Shipment::Base';

=head1 Class Attributes

=head2 username, password, key

Credentials required to access UPS Online Tools.

=cut

has 'username' => (
  is => 'rw',
  isa => Str,
);

has 'password' => (
  is => 'rw',
  isa => Str,
);

has 'key' => (
  is => 'rw',
  isa => Str,
);

=head2 proxy_domain

This determines whether you will use the UPS Customer Integration Environment (for development) or the production (live) environment
  * wwwcie.ups.com (development)
  * onlinetools.ups.com (production)

=cut

has 'proxy_domain' => (
  is => 'rw',
  isa => Enum[ qw(
    wwwcie.ups.com
    onlinetools.ups.com
  ) ],
  default => 'wwwcie.ups.com',
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

type: Shipment::Label

=cut

has 'control_log_receipt' => (
  is => 'rw',
  isa => InstanceOf['Shipment::Label'],
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

has 'service_map' => (
    is      => 'ro',
    isa     => HashRef [],
    default => sub {
        {
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
            '92' => 'UPS SurePost Less than 1 lb',
            '93' => 'UPS SurePost 1 lb or Greater',
            '94' => 'UPS SurePost BPM',
            '95' => 'UPS SurePost Media',
            'CA' => {
                '01' => 'UPS Express',
                '13' => 'UPS Express Saver',
                '65' => 'UPS Worldwide Express Saver',
                '02' => 'UPS Expedited',
            },
        };
    }
);

## Rating code to Shipping code map for cases when they differ
has 'service_code_map' => (
    is      => 'ro',
    isa     => HashRef [],
    default => sub {
        {
            'CA' => {
                '07' => '01',
                '13' => '65',
                '02' => '08',
            },
        };
    }
);

=head2 Shipment::Base type maps

Shipment::Base provides abstract types which need to be mapped to UPS codes (i.e. bill_type of "sender" maps to UPS "BillShipper")

=cut

has 'bill_type_map' => (
    is      => 'ro',
    isa     => HashRef [],
    default => sub {
        {
            'sender'      => 'BillShipper',
            'recipient'   => 'BillReceiver',
            'third_party' => 'BillThirdParty',
        };
    }
);

has 'signature_type_map' => (
    is      => 'ro',
    isa     => HashRef [],
    default => sub {
        {
            'default'      => '1',
            'required'     => '2',
            'not_required' => undef,
            'adult'        => '3',
        };
    }
);


has 'package_type_map' => (
    is      => 'ro',
    isa     => HashRef [],
    default => sub {
        {
            'custom'             => '02',
            'envelope'           => '01',
            'tube'               => '03',
            'box'                => '21',
            'pack'               => '04',
            '25kg_box'           => '24',
            '10kg_box'           => '25',
            'pallet'             => '30',
            'small_express_box'  => '2a',
            'medium_express_box' => '2b',
            'large_express_box'  => '2c',
        };
    }
);

has 'units_type_map' => (
    is      => 'ro',
    isa     => HashRef [],
    default => sub {
        {
            'lb' => 'LBS',
            'kg' => 'KGS',
            'in' => 'IN',
            'cm' => 'CM',
            'oz' => 'OZS',
        };
    }
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

has 'printer_type_map' => (
    is    => 'ro',
    isa   => HashRef [],
    default => sub {
        {
            'pdf'     => '',
            'thermal' => 'EPL',
            'image'   => 'GIF',
            'ZPL'     => 'ZPL',
            'SPL'     => 'SPL',
            'STARPL'  => 'STARPL',
        };
    }
);

has 'label_content_type_map' => (
    is    => 'ro',
    isa   => HashRef [],
    default => sub {
        {
            'thermal' => 'text/ups-epl',
            'image'   => 'image/gif',
            'ZPL'     => 'text/ups-zpl',
            'SPL'     => 'text/ups-spl',
            'STARPL'  => 'text/ups-starpl',
        };
    }
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
This includes surepost 1 lb or Greater and Surepost less than 1 lb
Note: for less than 1 lb (service id 92) weight must be in ounces
specified as oz 
=cut

has 'surepost' => (
  is => 'rw',
  isa => Bool,
  default => undef,
);

=head2 surepost_bpm

Enable UPS SurePost BPM
Bound printed matter parcels

=cut

has 'surepost_bpm' => (
  is => 'rw',
  isa => Bool,
  default => undef,
);

=head2 surepost_media

Enable UPS SurePost media 
Media parcesl with weight 1 lb to 70 lbs

=cut

has 'surepost_media' => (
  is => 'rw',
  isa => Bool,
  default => undef,
);

=head1 Class Methods

=head2 _build_services

This calls ProcessRate from the Rating API with RequestOption => 'Shop'

Each RatedShipment that is returned is added to services

The following service mapping is used:
  * ground => 03 (UPS Ground) or 11 (UPS Standard)
  * express => 02 (UPS Second Day Air)
  * priority => 01 (UPS Next Day Air)

=cut

sub _build_services {
  my $self = shift;

  use Shipment::Package;
  use Shipment::Service;
  use Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort;
  
  my $interface = Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );
  my $response;
  my %services;

  if ($self->weight_unit ne 'oz')
  {
    my $options;
    $options->{DeliveryConfirmation}->{DCISType} = $self->signature_type_map->{$self->signature_type} if defined $self->signature_type_map->{$self->signature_type};
    $options->{DeclaredValue}->{CurrencyCode} = $self->currency;
    
    my $rating_options;
    $rating_options->{NegotiatedRatesIndicator} = 1 if $self->negotiated_rates;

    my $shipment_options;
    $shipment_options->{UPScarbonneutralIndicator} = '' if $self->carbon_neutral;

    my @pieces;
    foreach (@{ $self->packages }) {
      $options->{DeclaredValue}->{MonetaryValue} = $self->insured_value->value;

      push @pieces,
        {
            PackagingType => {
              Code => $self->package_type_map->{$self->package_type} || $self->package_type,
            },
            Dimensions => {
              UnitOfMeasurement => {
                Code => $self->units_type_map->{$self->dim_unit} || $self->dim_unit,
              },
              Length => $_->length,
              Width => $_->width,
              Height => $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $self->units_type_map->{$self->weight_unit} || $self->weight_unit,
              },
              Weight => $_->weight,
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
              CountryCode       => $self->to_address()->country_code,
            },
  };
  $shipto->{Address}->{ResidentialAddressIndicator} = 1 if $self->{residential_address};
  $shipto->{Phone}{Number} = $self->to_address->phone
     if $self->to_address->phone;
  
  try {
    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    $response = $interface->ProcessRate( 
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
      },
      {
             UsernameToken =>  {
               Username =>  $self->username,
               Password =>  $self->password,
             },
             ServiceAccessToken =>  {
               AccessLicenseNumber =>  $self->key,
             },
      },
    );
    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    foreach my $service (@{ $response->get_RatedShipment() }) {
      my $rate = $service->get_TotalCharges->get_MonetaryValue;
      my $currency = $service->get_TotalCharges->get_CurrencyCode;
      if ($self->negotiated_rates) {
        if ($service->get_NegotiatedRateCharges) {
          $rate = $service->get_NegotiatedRateCharges->get_TotalCharge->get_MonetaryValue;
          $currency = $service->get_NegotiatedRateCharges->get_TotalCharge->get_CurrencyCode;
        }
      }
      $services{$service->get_Service()->get_Code()->get_value} = Shipment::Service->new(
          id => $service->get_Service()->get_Code()->get_value,
          name => (
              $self->service_map->{$self->from_address()->country_code}->{$service->get_Service()->get_Code()->get_value}
                ||
              $self->service_map->{$service->get_Service()->get_Code()->get_value}
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
    if ( $response->get_Response->get_Alert ) {
      foreach my $alert (@{$response->get_Response->get_Alert}) {
        warn "Notice: " . $alert->get_Description->get_value if $self->debug;
        $self->add_notice( $alert->get_Description->get_value . "\n" );
      }
    }

  } catch {
      warn $_ if $self->debug;
      try {
        warn "Error: " . $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description if $self->debug;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn "Error: " . $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
  };
  }

  if ($self->surepost) {
    if ($self->error) {
      $self->add_notice( 'All services other than SurePost failed due to error: ' . $self->error . "\n" );
      $self->error('');
    }

    if ( $self->weight_unit eq 'oz' ) {
        $services{92} = Shipment::Service->new(
            id   => '92',
            name => $self->service_map->{92},
        );

        $services{surepost_oz} = $services{92};

    }
    else {
        $services{93} = Shipment::Service->new(
            id   => '93',
            name => $self->service_map->{93},
        );
        $services{surepost} = $services{93};

        # These are contract specific with UPS
        # They are disabled by default
        if ( $self->surepost_bpm ) {
            $services{94} = Shipment::Service->new(
                id   => '94',
                name => $self->service_map->{94},
            );
            $services{surepost_bpm} = $services{94};
        }

        if ( $self->surepost_media ) {

            $services{95} = Shipment::Service->new(
                id   => '95',
                name => $self->service_map->{95},
            );
            $services{surepost_media} = $services{95};
        }

    }


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
    $options->{DeliveryConfirmation}->{DCISType} = $self->signature_type_map->{$self->signature_type} if defined $self->signature_type_map->{$self->signature_type};
    $options->{DeclaredValue}->{CurrencyCode} = $self->currency;
    
    my $rating_options;
    $rating_options->{NegotiatedRatesIndicator} = 1 if $self->negotiated_rates;

    my $shipment_options;
    $shipment_options->{UPScarbonneutralIndicator} = '' if $self->carbon_neutral;

    my @pieces;
    foreach (@{ $self->packages }) {
      $options->{DeclaredValue}->{MonetaryValue} = $self->insured_value->value;

      ## SurePost doesn't accept service options
      $options = undef if $self->surepost && $service_id =~ /9[2-5]/;

      push @pieces,
        {
            PackagingType => {
              Code => $self->package_type_map->{$self->package_type} || $self->package_type,
            },
            Dimensions => {
              UnitOfMeasurement => {
                Code => $self->units_type_map->{$self->dim_unit} || $self->dim_unit,
              },
              Length => $_->length,
              Width => $_->width,
              Height => $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $self->units_type_map->{$self->weight_unit} || $self->weight_unit,
              },
              Weight => $_->weight,
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
              CountryCode       => $self->to_address()->country_code,
            },
  };
  $shipto->{Address}->{ResidentialAddressIndicator} = 1 if $self->{residential_address};
  $shipto->{Phone}{Number} = $self->to_address->phone
     if $self->to_address->phone;

  use Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort;
  
  my $interface = Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );

  my $response;
  try {
    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    $response = $interface->ProcessRate( 
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
      },
      {
             UsernameToken =>  {
               Username =>  $self->username,
               Password =>  $self->password,
             },
             ServiceAccessToken =>  {
               AccessLicenseNumber =>  $self->key,
             },
      },
    );
    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    use Data::Currency;
    use Shipment::Service;
    my $rate = $response->get_RatedShipment->get_TotalCharges->get_MonetaryValue;
    my $currency = $response->get_RatedShipment->get_TotalCharges->get_CurrencyCode;
    if ($self->negotiated_rates) {
      if ($response->get_RatedShipment->get_NegotiatedRateCharges) {
        $rate = $response->get_RatedShipment->get_NegotiatedRateCharges->get_TotalCharge->get_MonetaryValue;
        $currency = $response->get_RatedShipment->get_NegotiatedRateCharges->get_TotalCharge->get_CurrencyCode;
      }
    }
    $self->service( 
       Shipment::Service->new( 
        id        => $service_id,
        name      => (
              $self->service_map->{$self->from_address()->country_code}->{$response->get_RatedShipment->get_Service->get_Code->get_value}
                ||
              $self->service_map->{$response->get_RatedShipment->get_Service->get_Code->get_value}
            ),
        cost      => Data::Currency->new($rate, $currency),
      )
    );

    $self->notice( '' );
    if ( $response->get_Response->get_Alert ) {
      foreach my $alert (@{$response->get_Response->get_Alert}) {
        warn $alert->get_Description->get_value if $self->debug;
        $self->add_notice( $alert->get_Description->get_value . "\n" );
      }
    }
  } catch {
      warn $_ if $self->debug;
      try {
        warn $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description if $self->debug;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
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
    $package_options->{DeliveryConfirmation}->{DCISType} = $self->signature_type_map->{$self->signature_type} if defined $self->signature_type_map->{$self->signature_type};
    $package_options->{DeclaredValue}->{CurrencyCode} = $self->currency;

    my $shipment_options;
    if ($self->to_address->email) {
      $shipment_options->{Notification}->{NotificationCode} = '6';
      $shipment_options->{Notification}->{EMail}->{EMailAddress} = $self->to_address->email;
      $shipment_options->{Notification}->{EMail}->{SubjectCode} = '03'; 
    }
    $shipment_options->{UPScarbonneutralIndicator} = '' if $self->carbon_neutral;

    my $rating_options;
    $rating_options->{NegotiatedRatesIndicator} = 1 if $self->negotiated_rates;

    my @pieces;
    my $reference_index = 1;
    foreach (@{ $self->packages }) {
      $package_options->{DeclaredValue}->{MonetaryValue} = $self->insured_value->value;

      ## SurePost doesn't accept service options
      $package_options = undef if $self->surepost && $service_id =~ /9[2-5]/;

      my @references;
      if (
        $self->references && 
        $self->from_address->country_code =~ /(US|PR)/ && 
        $self->to_address->country_code =~ /(US|PR)/ && 
        $self->from_address->country_code eq $self->to_address->country_code
      ) {
        foreach ($self->get_reference(0), $self->get_reference(1)) {
          next if !$_;

	   my ($code, $val);
           if ( ref($_) eq "HASH")
           {
                $code = (keys %$_)[0];
                $val  = (values %$_)[0];
           }
           else
           {
                $code = $reference_index;
                $val  = $_;
           }
          push @references, { Code => $code, Value => $val, };
          $reference_index++;
        }
      }
      push @pieces,
        {
            Packaging => {
              Code => $self->package_type_map->{$self->package_type} || $self->package_type,
            },
            Dimensions => {
              UnitOfMeasurement => {
                Code => $self->units_type_map->{$self->dim_unit} || $self->dim_unit,
              },
              Length => $_->length,
              Width => $_->width,
              Height => $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $self->units_type_map->{$self->weight_unit} || $self->weight_unit,
              },
              Weight => $_->weight,
            },
            ReferenceNumber => \@references,
            PackageServiceOptions => $package_options,
        };
    }

    my $payment_option;
    $payment_option->{Type} = '01';
    $payment_option->{$self->bill_type_map->{$self->bill_type}}->{AccountNumber} = $self->bill_account;
    $payment_option->{$self->bill_type_map->{$self->bill_type}}->{Address}->{PostalCode} = $self->bill_address->postal_code if $self->bill_address && $self->bill_type =~ /(recipient|third_party)/; 
    $payment_option->{$self->bill_type_map->{$self->bill_type}}->{Address}->{CountryCode} = $self->bill_address->country_code if $self->bill_address && $self->bill_type eq 'third_party'; 

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
              CountryCode       => $self->to_address->country_code,
            },
          };
  $shipto->{Address}->{ResidentialAddressIndicator} = 1 if $self->{residential_address};
  $shipto->{Phone}{Number} = $self->to_address->phone
     if $self->to_address->phone;

  use Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort;
  
  my $interface = Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );

  my $response;
  try {
    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    $response = $interface->ProcessShipment( 
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
          },
          ShipTo => $shipto,
          ShipmentRatingOptions => $rating_options,
          Service => {
            Code => ($self->service_code_map->{$self->from_address->country_code}->{$service_id} || $service_id),
          },
          Package => \@pieces,
          PaymentInformation =>  { 
            ShipmentCharge => $payment_option,
          },
          ShipmentServiceOptions => $shipment_options,
        },
        LabelSpecification =>  { 
          LabelImageFormat =>  { 
            Code =>  $self->printer_type_map->{$self->printer_type},
          },
          LabelStockSize =>  { 
            Height =>  $self->label_height,
            Width =>  4,
          },
        },
      },
      {
             UsernameToken =>  {
               Username =>  $self->username,
               Password =>  $self->password,
             },
             ServiceAccessToken =>  {
               AccessLicenseNumber =>  $self->key,
             },
      },
    );
    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    $self->tracking_id( $response->get_ShipmentResults()->get_ShipmentIdentificationNumber()->get_value );
    use Data::Currency;
    use Shipment::Service;
    my $rate = 0;
    my $currency = $self->currency;
    if ($response->get_ShipmentResults->get_ShipmentCharges && $response->get_ShipmentResults->get_ShipmentCharges->get_TotalCharges) {
      $rate = $response->get_ShipmentResults->get_ShipmentCharges->get_TotalCharges->get_MonetaryValue;
      $currency = $response->get_ShipmentResults->get_ShipmentCharges->get_TotalCharges->get_CurrencyCode;
    }
    if ($self->negotiated_rates) {
      if ($response->get_ShipmentResults->get_NegotiatedRateCharges && $response->get_ShipmentResults->get_NegotiatedRateCharges->get_TotalCharge) {
        $rate = $response->get_ShipmentResults->get_NegotiatedRateCharges->get_TotalCharge->get_MonetaryValue;
        $currency = $response->get_ShipmentResults->get_NegotiatedRateCharges->get_TotalCharge->get_CurrencyCode;
      }
    }
    $self->service( 
       Shipment::Service->new( 
        id        => $service_id,
        name      => $self->services->{$service_id}->name,
        cost      => Data::Currency->new($rate, $currency),
      )
    );

    use Shipment::Label;
    use MIME::Base64;
    my $package_index = 0;
    foreach (@{ $response->get_ShipmentResults()->get_PackageResults() }) {
      $self->get_package($package_index)->tracking_id( $_->get_TrackingNumber()->get_value );

      ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file. 
      ## This is needed for cases when the printer defaults to the incorrect orientation.
      my $data = "ZT\n" if $self->printer_type_map->{$self->printer_type} eq 'EPL';
      $data .= decode_base64($_->get_ShippingLabel()->get_GraphicImage->get_value);

      $self->get_package($package_index)->label(
        Shipment::Label->new(
          {
            tracking_id => $_->get_TrackingNumber()->get_value,
            content_type => $self->label_content_type_map->{$self->printer_type},
            data => $data,
            file_name => $_->get_TrackingNumber()->get_value . '.' . lc $self->printer_type_map->{$self->printer_type},
          },
        )
      );
      $package_index++;
    }

    if (ref $response->get_ShipmentResults()->get_ControlLogReceipt eq 'ARRAY') {
      my $receipt_index = 0;
      foreach (@{ $response->get_ShipmentResults()->get_ControlLogReceipt }) {
        ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file.
        ## This is needed for cases when the printer defaults to the incorrect orientation.
        my $data = "ZT\n" if $self->printer_type_map->{$self->printer_type} eq 'EPL';
        $data .= decode_base64($_->get_GraphicImage->get_value);

        push @{ $self->control_log_receipt },
          Shipment::Label->new(
            {
              content_type => $self->label_content_type_map->{$self->printer_type},
              data => $data,
              file_name => 'control_log_receipt_' . $receipt_index . '.' . lc $self->printer_type_map->{$self->printer_type},
            }
          );
        $receipt_index++;
      }
    }

    $self->notice( '' );
    if ( $response->get_Response->get_Alert ) {
      foreach my $alert (@{$response->get_Response->get_Alert}) {
        warn $alert->get_Description->get_value if $self->debug;
        $self->add_notice( $alert->get_Description->get_value . "\n" );
      }
    }

  } catch {
      warn $_ if $self->debug;
      try {
        warn $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description if $self->debug;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
  };

}

=head2 return

This method calls ProcessShipment from the Shipping API with
  ReturnService => Code => $return_code 
$return_code can be either 9, 8 or 2.

9 provides a return label to be printed off.
8 causes UPS to email a return label to $self->from_address->email 
2 causes UPS to mail a return label to $self->from_address

defaults to 9 (print return label)

This method has only been implemented for the purpose of obtaining certification with UPS. It has not been fully tested and does not offer some core options.

It assumes that you are first creating an outgoing shipment and creating the return shipment at the same time. Because of this, it uses the "to_address" as the origin and the "from_address" as the destination.

=cut

sub return {
  my ( $self, $service_id, $rc ) = @_;

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

    # default return code is 9 which means we print a return label
    my $return_code = $rc ? $rc : 9;

    my @pieces;
    my $reference_index = 1;
    foreach (@{ $self->packages }) {
      $package_options->{DeclaredValue}->{MonetaryValue} = $self->insured_value->value;
      my @references;
      if (
        $self->references && 
        $self->from_address->country_code =~ /(US|PR)/ && 
        $self->to_address->country_code =~ /(US|PR)/ && 
        $self->from_address->country_code eq $self->to_address->country_code
      ) {

        foreach ($self->get_reference(0), $self->get_reference(1)) {
          next if !$_;

	   my ($code, $val);
	   if ( ref($_) eq "HASH")
	   {
		$code = (keys %$_)[0];
		$val  = (values %$_)[0];
           }	
	   else
	   {
		$code = $reference_index;
		$val  = $_;
           }
          push @references, {
            Code => $code,
            Value => $val,
          };
          $reference_index++;
        }
      }
      push @pieces,
        {
            Description => 'n/a',
            Packaging => {
              Code => $self->package_type_map->{$self->package_type} || $self->package_type,
            },
            Dimensions => {
              UnitOfMeasurement => {
                Code => $self->units_type_map->{$self->dim_unit} || $self->dim_unit,
              },
              Length => $_->length,
              Width => $_->width,
              Height => $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $self->units_type_map->{$self->weight_unit} || $self->weight_unit,
              },
              Weight => $_->weight,
            },
	    ReferenceNumber => \@references,
            PackageServiceOptions => $package_options,
        };
    }

    my $payment_option;
    $payment_option->{Type} = '01';
    $payment_option->{$self->bill_type_map->{$self->bill_type}}->{AccountNumber} = $self->bill_account;
    $payment_option->{$self->bill_type_map->{$self->bill_type}}->{Address}->{PostalCode} = $self->bill_address->postal_code if $self->bill_address && $self->bill_type =~ /(recipient|third_party)/; 
    $payment_option->{$self->bill_type_map->{$self->bill_type}}->{Address}->{CountryCode} = $self->bill_address->country_code if $self->bill_address && $self->bill_type eq 'third_party'; 

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

  use Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort;
  
  my $interface = Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );

    my %body = (
        Request => {
          RequestOption => ($self->address_validation) ? 'validate' : 'nonvalidate',
        },
        Shipment => {
          ReturnService => {
            Code => $return_code,
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
              CountryCode       => $self->to_address->country_code,
            },
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
            EMailAddress => $self->to_address->email,
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
            Code =>  $self->printer_type_map->{$self->printer_type},
          },
          LabelStockSize =>  { 
            Height =>  $self->label_height,
            Width =>  4,
          },
        },
      );

      my $body = \%body;

	if ($return_code == 8)
	{
		$body->{Shipment}->{ShipmentServiceOptions} =  {
		     LabelDelivery => {
			EMail => {
			  EMailAddress => $self->from_address->email,
			  UndeliverableEMailAddress => $self->to_address->email,
			  FromEMailAddress => $self->to_address->email, 
			},
		        LabelLinksIndicator => '',
		     },
		};
	}


      my %header = (
             UsernameToken =>  {
               Username =>  $self->username,
               Password =>  $self->password,
             },
             ServiceAccessToken =>  {
               AccessLicenseNumber =>  $self->key,
             },
      ); 

   my $response;
   try {
	    $response = $interface->ProcessShipment( \%body, \%header ); 
   	    #warn $response;

	    $self->tracking_id( $response->get_ShipmentResults()->get_ShipmentIdentificationNumber()->get_value );
	    use Data::Currency;
	    use Shipment::Service;
	    $self->service( 
	       Shipment::Service->new( 
		id        => $service_id,
		name      => $self->services->{$service_id}->name,
		cost      => Data::Currency->new($response->get_ShipmentResults()->get_ShipmentCharges->get_TotalCharges()->get_MonetaryValue, $response->get_ShipmentResults()->get_ShipmentCharges()->get_TotalCharges()->get_CurrencyCode),
	      )
	    );

	    # return_code 9 means we are getting a label back to print
	    if ($return_code == 9)
	    {
		    use Shipment::Label;
		    use MIME::Base64;
		    my $package_index = 0;
		    foreach (@{ $response->get_ShipmentResults()->get_PackageResults() }) {

		      ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file. 
		      ## This is needed for cases when the printer defaults to the incorrect orientation.
		      my $data = "ZT\n" if $self->printer_type_map->{$self->printer_type} eq 'EPL';
		      $data .= decode_base64($_->get_ShippingLabel()->get_GraphicImage->get_value);

		      $self->get_package($package_index)->tracking_id( $_->get_TrackingNumber()->get_value );
		      $self->get_package($package_index)->label(
			Shipment::Label->new(
			  {
			    tracking_id => $_->get_TrackingNumber()->get_value,
			    content_type => $self->label_content_type_map->{$self->printer_type},
			    data => $data,
			    file_name => $_->get_TrackingNumber()->get_value . '.' . lc $self->printer_type_map->{$self->printer_type},
			  },
			)
		      );
		      $package_index++;
		    }

        if (ref $response->get_ShipmentResults()->get_ControlLogReceipt eq 'ARRAY') {
          my $receipt_index = 0;
          foreach (@{ $response->get_ShipmentResults()->get_ControlLogReceipt }) {

            ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file.
            ## This is needed for cases when the printer defaults to the incorrect orientation.
            my $data = "ZT\n" if $self->printer_type_map->{$self->printer_type} eq 'EPL';
            $data .= decode_base64($_->get_GraphicImage->get_value);

            push @{ $self->control_log_receipt },
              Shipment::Label->new(
                {
                  content_type => $self->label_content_type_map->{$self->printer_type},
                  data => $data,
                  file_name => 'control_log_receipt_' . $receipt_index . '.' . lc $self->printer_type_map->{$self->printer_type},
                }
              );
            $receipt_index++;
          }
        }

	     }
	     elsif ($return_code == 8)
	     {
		    use Shipment::Label;
		    use MIME::Base64;
		    my $package_index = 0;
	      	    my $label_url = $response->get_ShipmentResults()->get_LabelURL()->get_value;

		    # don't think this foreach makes sense here. I think you can only return one package get package_index is always 0
		    foreach (@{ $response->get_ShipmentResults()->get_PackageResults() }) {

		      $self->get_package($package_index)->tracking_id( $_->get_TrackingNumber()->get_value );
		      $self->get_package($package_index)->label(
			Shipment::Label->new(
			  {
			    tracking_id => $_->get_TrackingNumber()->get_value,
			    content_type => 'url',
			    data => $label_url,
			  },
			)
		      );
		      $package_index++;
		    }

             }
	     elsif ($return_code == 2)
	     {
		    use MIME::Base64;
		    my $package_index = 0;

		    # don't think this foreach makes sense here. I think you can only return one package get package_index is always 0
		    foreach (@{ $response->get_ShipmentResults()->get_PackageResults() }) {
		      $self->get_package($package_index)->tracking_id( $_->get_TrackingNumber()->get_value );
		      $package_index++;
		    }

             }
	    $self->notice( '' );
	    if ( $response->get_Response->get_Alert ) {
	      foreach my $alert (@{$response->get_Response->get_Alert}) {
		warn $alert->get_Description->get_value;
		$self->add_notice( $alert->get_Description->get_value . "\n" );
	      }
	    }

  } catch {
      warn $_ if $self->debug;
      try {
        warn $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description if $self->debug;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
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

  use Shipment::UPS::WSDL::ShipInterfaces::VoidService::VoidPort;
  my $interface = Shipment::UPS::WSDL::ShipInterfaces::VoidService::VoidPort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );

  my $response;
  my $success;

  try {
    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    $response = $interface->ProcessVoid(
      {
        Request =>  { 
          RequestOption => '',
        },
        VoidShipment => $void,
      },
      {
             UsernameToken =>  {
               Username =>  $self->username,
               Password =>  $self->password,
             },
             ServiceAccessToken =>  {
               AccessLicenseNumber =>  $self->key,
             },
      },
    );
    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    $success = $response->get_SummaryResult->get_Status->get_Description->get_value;

    $self->notice( '' );
    if ( $response->get_Response->get_Alert ) {
      foreach my $alert (@{$response->get_Response->get_Alert}) {
        warn $alert->get_Description->get_value if $self->debug;
        $self->add_notice( $alert->get_Description->get_value . "\n" );
      }
    }

  } catch {
      warn $_ if $self->debug;
      try {
        warn $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description if $self->debug;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
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

    use Shipment::UPS::WSDL::XAVInterfaces::XAVService::XAVPort;
    my $interface =
      Shipment::UPS::WSDL::XAVInterfaces::XAVService::XAVPort->new(
        {
            proxy_domain => $self->proxy_domain,
        }
      );

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

  	$response = $interface->ProcessXAV(
  	{
            Request => {
                RequestOption => $request_option,
              },
              AddressKeyFormat => {
                AddressLine        => \@to_addresslines,
                PoliticalDivision2 => $self->to_address->city,
                PoliticalDivision1 => $self->to_address->province_code,
                PostcodePrimaryLow => $self->to_address->postal_code,
                CountryCode        => $self->to_address->country_code,
              }
 	},
 	{
             UsernameToken =>  {
               Username =>  $self->username,
               Password =>  $self->password,
             },
             ServiceAccessToken =>  {
               AccessLicenseNumber =>  $self->key,
             },
	},

  	);
	#warn $response;
	
    if ( $request_option =~ m/[23]/ ) {
        try {
            my $ac = $response->get_AddressClassification;
            $classification->{code}        = $ac->get_Code->get_value();
            $classification->{description} = $ac->get_Description->get_value();
        }
        catch {};
    }

    try {
        if ( defined( $response->get_ValidAddressIndicator->get_value() ) ) {
            $result = "valid";
        }
    }
    catch {};

    try {
        if ( defined( $response->get_AmbiguousAddressIndicator->get_value() ) )
        {
            $result = "invalid";
        }

    }
    catch {};

    try {
        if ( defined( $response->get_NoCandidatesIndicator->get_value() ) )
        {
            $result = "nocandidates";
        }

    }
    catch {};

    if ( $result && $result ne "nocandidates" ) {

        # If we are asking for address classification, canidites will also
        # include classification results
        try {

            for my $candidate ( @{ $response->get_Candidate() } ) {
                my %a_hash = (
                    address1 =>
                      $candidate->get_AddressKeyFormat()->get_AddressLine()
                      ->get_value(),
                    city => $candidate->get_AddressKeyFormat()
                      ->get_PoliticalDivision2()->get_value(),
                    province => $candidate->get_AddressKeyFormat()
                      ->get_PoliticalDivision1()->get_value(),
                    postal_code => $candidate->get_AddressKeyFormat()
                      ->get_PostcodePrimaryLow()->get_value() . "-"
                      . $candidate->get_AddressKeyFormat()
                      ->get_PostcodeExtendedLow()->get_value(),
                    country =>
                      $candidate->get_AddressKeyFormat()->get_CountryCode()
                      ->get_value(),
                );

                if ( $request_option == 3 ) {
                    $a_hash{classification}{code} =
                      $candidate->get_AddressClassification->get_Code
                      ->get_value();
                    $a_hash{classification}{description} =
                      $candidate->get_AddressClassification->get_Description
                      ->get_value();
                }
                push @candidates, \%a_hash;
            }

        }
        catch { warn $_ };
    }

  } catch {
      #warn $_;
      try {
        #warn $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        #warn $_;
        #warn $response->get_faultstring;
        $self->error( $response->get_faultstring->get_value );
      };
  };

    return { 'result' => $result, 'candidate' => \@candidates, 'classification' => $classification };
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
