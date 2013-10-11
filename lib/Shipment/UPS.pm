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

This class provides an interface to the UPS Online Tools. You must sign up for a developer access key in order to make use of this module.

https://www.ups.com/upsdeveloperkit

It is an extension of L<Shipment::Base>.

It makes extensive use of SOAP::WSDL in order to create/decode xml requests and responses. The Shipment::UPS::WSDL interface was created primarily using the wsdl2perl.pl script from SOAP::WSDL.

=cut

use Try::Tiny;
use Moose 2.0000;
use Moose::Util::TypeConstraints;
use Shipment::SOAP::WSDL;

extends 'Shipment::Base';

=head1 Class Attributes

=head2 username, password, key

Credentials required to access UPS Online Tools.

=cut

has 'username' => (
  is => 'rw',
  isa => 'Str',
);

has 'password' => (
  is => 'rw',
  isa => 'Str',
);

has 'key' => (
  is => 'rw',
  isa => 'Str',
);

=head2 proxy_domain

This determines whether you will use the UPS Customer Integration Environment (for development) or the production (live) environment
  * wwwcie.ups.com (development)
  * onlinetools.ups.com (production)

=cut

has 'proxy_domain' => (
  is => 'rw',
  isa => enum( [ qw(
    wwwcie.ups.com
    onlinetools.ups.com
  ) ] ),
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
  isa => 'Bool',
  default => 0,
);

=head2 residential_address

Flag the ship to address as residential.

Default is false.

=cut

has 'residential_address' => (
  is => 'rw',
  isa => 'Bool',
  default => 0,
);

=head2 address_validation

Turn address validation on or off. When on, ship will fail if the address does not pass UPS address validation

Default is on.

=cut

has 'address_validation' => (
  is => 'rw',
  isa => 'Bool',
  default => 1,
);

=head2 label_height

The label height. Can be either 6" or 8". The label width is fixed at 4".

=cut

has 'label_height' => (
  is => 'rw',
  isa => enum( [ qw( 6 8 ) ] ),
  default => 6,
);

=head2 control_log_receipt

In certain cases (i.e. for shipments with declared value over $999), UPS will return a control log receipt which must be printed off along with the label.

type: Shipment::Label

=cut

has 'control_log_receipt' => (
  is => 'rw',
  isa => 'Shipment::Label',
);

=head2 carbon_neutral

Set the Carbon Neutral Indicator - http://www.ups.com/content/us/en/resources/ship/carbonneutral/shipping.html

type: Bool

=cut

has 'carbon_neutral' => (
  is => 'rw',
  isa => 'Bool',
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
  '07' => 'UPS Worldwide ExpressSM',
  '08' => 'UPS Worldwide ExpeditedSM',
  '11' => 'UPS Standard',
  '12' => 'UPS Three-Day Select',
  '13' => 'UPS Next Day Air Saver',
  '14' => 'UPS Next Day Air Early A.M. SM',
  '54' => 'UPS Worldwide Express PlusSM',
  '59' => 'UPS Second Day Air A.M.',
  '65' => 'UPS Saver',
  '82' => 'UPS Today StandardSM',
  '83' => 'UPS Today Dedicated CourrierSM',
  '85' => 'UPS Today Express',
  '86' => 'UPS Today Express Saver',
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
  'default'      => '1',
  'required'     => '2',
  'not_required' => undef,
  'adult'        => '3',
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

enum 'PackageOptions' => qw( custom envelope tube box pack 25kg_box 10kg_box pallet small_express_box medium_express_box large_express_box );

has '+package_type' => (
  isa => 'PackageOptions',
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

enum 'PrinterOptions' => qw( thermal image ZPL SPL STARPL );

has '+printer_type' => (
  default => 'image',
);

=head2 default currency

The default currency is USD

=cut

has '+currency' => (
  default => 'USD',
);

=head1 Class Methods

=head2 _build_services

This calls ProcessRate from the Rating API with RequestOption => 'Shop'

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
  use Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort;
  
  my $interface = Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );
  my $response;


  my $rating_options;
  $rating_options->{NegotiatedRatesIndicator} = 1 if $self->negotiated_rates;

  my $shipto = { 
            Address => {
              City              => $self->to_address()->city,
              StateProvinceCode => $self->to_address()->province_code,
              PostalCode        => $self->to_address()->postal_code,
              CountryCode       => $self->to_address()->country_code,
            },
  };
  $shipto->{Address}->{ResidentialAddressIndicator} = 1 if $self->{residential_address};

  my %services;
  try {
    $response = $interface->ProcessRate( 
      {
        Request => {
          RequestOption => 'Shop',
        },
        Shipment => {
          Shipper => {
            ShipperNumber => $self->account,
            Address => {
              City              => $self->from_address()->city,
              StateProvinceCode => $self->from_address()->province_code,
              PostalCode        => $self->from_address()->postal_code,
              CountryCode       => $self->from_address()->country_code,
            },
          },
          ShipTo => $shipto,
          ShipmentRatingOptions => $rating_options,
          Package => {
            PackagingType => {
              Code => $package_type_map{$self->package_type} || $self->package_type,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->weight_unit} || $self->weight_unit,
              },
              Weight => 1,
            },
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
    #warn $response;

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
          name => $service_map{$service->get_Service()->get_Code()->get_value},
          cost => Data::Currency->new($rate, $currency),
        );
    }
    $services{ground} = ($services{'03'}) ? $services{'03'} : $services{'11'} if ($services{'03'} || $services{'11'});
    $services{express} = $services{'02'} if $services{'02'};
    $services{priority} = $services{'01'} if $services{'01'};

    $self->notice( '' );
    if ( $response->get_Response->get_Alert ) {
      foreach my $alert (@{$response->get_Response->get_Alert}) {
        warn $alert->get_Description->get_value;
        $self->add_notice( $alert->get_Description->get_value . "\n" );
      }
    }

  } catch {
      warn $_;
      try {
        warn $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        warn $_;
        warn $response->get_faultstring;
        $self->error( $response->get_faultstring->get_value );
      };
  };


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
    warn $_;
    warn "service ($service_id) not available";
    $self->error( "service ($service_id) not available" );
    $service_id = '';
  };
  return unless $service_id;

    my $options;
    $options->{DeliveryConfirmation}->{DCISType} = $signature_type_map{$self->signature_type} if defined $signature_type_map{$self->signature_type};
    $options->{DeclaredValue}->{CurrencyCode} = $self->currency;
    
    my $rating_options;
    $rating_options->{NegotiatedRatesIndicator} = 1 if $self->negotiated_rates;

    my $shipment_options;
    $shipment_options->{UPScarbonneutralIndicator} = '' if $self->carbon_neutral;

    my @pieces;
    foreach (@{ $self->packages }) {
      $options->{DeclaredValue}->{MonetaryValue} = $_->insured_value->value;
      push @pieces,
        {
            PackagingType => {
              Code => $package_type_map{$self->package_type} || $self->package_type,
            },
            Dimensions => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->dim_unit} || $self->dim_unit,
              },
              Length => $_->length,
              Width => $_->width,
              Height => $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->weight_unit} || $self->weight_unit,
              },
              Weight => $_->weight,
            },
            PackageServiceOptions => $options,
        };
    }


  my $shipto = { 
            Address => {
              City              => $self->to_address()->city,
              StateProvinceCode => $self->to_address()->province_code,
              PostalCode        => $self->to_address()->postal_code,
              CountryCode       => $self->to_address()->country_code,
            },
  };
  $shipto->{Address}->{ResidentialAddressIndicator} = 1 if $self->{residential_address};

  use Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort;
  
  my $interface = Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );

  my $response;
  try {

    $response = $interface->ProcessRate( 
      {
        Request => {
          RequestOption => 'Rate',
        },
        Shipment => {
          Shipper => {
            ShipperNumber => $self->account,
            Address => {
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
    #warn $response;

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
      new Shipment::Service( 
        id        => $service_id,
        name      => $self->services->{$service_id}->name,
        cost      => Data::Currency->new($rate, $currency),
      )
    );

    $self->notice( '' );
    if ( $response->get_Response->get_Alert ) {
      foreach my $alert (@{$response->get_Response->get_Alert}) {
        warn $alert->get_Description->get_value;
        $self->add_notice( $alert->get_Description->get_value . "\n" );
      }
    }
  } catch {
      warn $_;
      try {
        warn $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        warn $_;
        warn $response->get_faultstring;
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
    warn $_;
    warn "service ($service_id) not available";
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
    $rating_options->{NegotiatedRatesIndicator} = 1 if $self->negotiated_rates;

    my @pieces;
    my $reference_index = 1;
    foreach (@{ $self->packages }) {
      $package_options->{DeclaredValue}->{MonetaryValue} = $_->insured_value->value;
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
            Code => $reference_index,
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
              Length => $_->length,
              Width => $_->width,
              Height => $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->weight_unit} || $self->weight_unit,
              },
              Weight => $_->weight,
            },
            ReferenceNumber => \@references,
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

  use Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort;
  
  my $interface = Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );

  my $response;
  try {
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
            Code => $service_id,
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
    #warn $response;

    $self->tracking_id( $response->get_ShipmentResults()->get_ShipmentIdentificationNumber()->get_value );
    use Data::Currency;
    use Shipment::Service;
    my $rate = $response->get_ShipmentResults->get_ShipmentCharges->get_TotalCharges->get_MonetaryValue;
    my $currency = $response->get_ShipmentResults->get_ShipmentCharges->get_TotalCharges->get_CurrencyCode;
    if ($self->negotiated_rates) {
      if ($response->get_ShipmentResults->get_NegotiatedRateCharges) {
        $rate = $response->get_ShipmentResults->get_NegotiatedRateCharges->get_TotalCharge->get_MonetaryValue;
        $currency = $response->get_ShipmentResults->get_NegotiatedRateCharges->get_TotalCharge->get_CurrencyCode;
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
    foreach (@{ $response->get_ShipmentResults()->get_PackageResults() }) {
      $self->get_package($package_index)->tracking_id( $_->get_TrackingNumber()->get_value );

      ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file. 
      ## This is needed for cases when the printer defaults to the incorrect orientation.
      my $data = "ZT\n" if $printer_type_map{$self->printer_type} eq 'EPL';
      $data .= decode_base64($_->get_ShippingLabel()->get_GraphicImage->get_value);

      $self->get_package($package_index)->label(
        Shipment::Label->new(
          {
            tracking_id => $_->get_TrackingNumber()->get_value,
            content_type => $label_content_type_map{$self->printer_type},
            data => $data,
            file_name => $_->get_TrackingNumber()->get_value . '.' . lc $printer_type_map{$self->printer_type},
          },
        )
      );
      $package_index++;
    }

    if ( $response->get_ShipmentResults()->get_ControlLogReceipt ) {

      ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file. 
      ## This is needed for cases when the printer defaults to the incorrect orientation.
      my $data = "ZT\n" if $printer_type_map{$self->printer_type} eq 'EPL';
      $data .= decode_base64($response->get_ShipmentResults()->get_ControlLogReceipt()->get_GraphicImage->get_value);

      $self->control_log_receipt(
        Shipment::Label->new(
          {
            content_type => $label_content_type_map{$self->printer_type},
            data => $data,
            file_name => 'control_log_receipt.' . lc $printer_type_map{$self->printer_type},
          }
        )
      );
    }

    $self->notice( '' );
    if ( $response->get_Response->get_Alert ) {
      foreach my $alert (@{$response->get_Response->get_Alert}) {
        warn $alert->get_Description->get_value;
        $self->add_notice( $alert->get_Description->get_value . "\n" );
      }
    }

  } catch {
      warn $_;
      try {
        warn $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        warn $_;
        warn $response->get_faultstring;
        $self->error( $response->get_faultstring->get_value );
      };
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
    warn $_;
    warn "service ($service_id) not available";
    $self->error( "service ($service_id) not available" );
    $service_id = '';
  };
  return unless $service_id;

    my $package_options;
    $package_options->{DeclaredValue}->{CurrencyCode} = $self->currency;

    my @pieces;
    foreach (@{ $self->packages }) {
      $package_options->{DeclaredValue}->{MonetaryValue} = $_->insured_value->value;
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
              Length => $_->length,
              Width => $_->width,
              Height => $_->height,
            },
            PackageWeight => {
              UnitOfMeasurement => {
                Code => $units_type_map{$self->weight_unit} || $self->weight_unit,
              },
              Weight => $_->weight,
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

  use Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort;
  
  my $interface = Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );

  my $response;
  try {
    $response = $interface->ProcessShipment( 
      {
        Request => {
          RequestOption => ($self->address_validation) ? 'validate' : 'nonvalidate',
        },
        Shipment => {
          ReturnService => {
            Code => 9,
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
    #warn $response;

    $self->tracking_id( $response->get_ShipmentResults()->get_ShipmentIdentificationNumber()->get_value );
    use Data::Currency;
    use Shipment::Service;
    $self->service( 
      new Shipment::Service( 
        id        => $service_id,
        name      => $self->services->{$service_id}->name,
        cost      => Data::Currency->new($response->get_ShipmentResults()->get_ShipmentCharges->get_TotalCharges()->get_MonetaryValue, $response->get_ShipmentResults()->get_ShipmentCharges()->get_TotalCharges()->get_CurrencyCode),
      )
    );

    use Shipment::Label;
    use MIME::Base64;
    my $package_index = 0;
    foreach (@{ $response->get_ShipmentResults()->get_PackageResults() }) {

      ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file. 
      ## This is needed for cases when the printer defaults to the incorrect orientation.
      my $data = "ZT\n" if $printer_type_map{$self->printer_type} eq 'EPL';
      $data .= decode_base64($_->get_ShippingLabel()->get_GraphicImage->get_value);

      $self->get_package($package_index)->tracking_id( $_->get_TrackingNumber()->get_value );
      $self->get_package($package_index)->label(
        Shipment::Label->new(
          {
            tracking_id => $_->get_TrackingNumber()->get_value,
            content_type => $label_content_type_map{$self->printer_type},
            data => $data,
            file_name => $_->get_TrackingNumber()->get_value . '.' . lc $printer_type_map{$self->printer_type},
          },
        )
      );
      $package_index++;
    }

    if ( $response->get_ShipmentResults()->get_ControlLogReceipt ) {

      ## For EPL labels, force Top Orientation by inserting the ZT command at the beginning of the file. 
      ## This is needed for cases when the printer defaults to the incorrect orientation.
      my $data = "ZT\n" if $printer_type_map{$self->printer_type} eq 'EPL';
      $data .= decode_base64($response->get_ShipmentResults()->get_ControlLogReceipt()->get_GraphicImage->get_value);

      $self->control_log_receipt(
        Shipment::Label->new(
          {
            content_type => $label_content_type_map{$self->printer_type},
            data => $data,
            file_name => 'control_log_receipt.' . lc $printer_type_map{$self->printer_type},
          }
        )
      );
    }

    $self->notice( '' );
    if ( $response->get_Response->get_Alert ) {
      foreach my $alert (@{$response->get_Response->get_Alert}) {
        warn $alert->get_Description->get_value;
        $self->add_notice( $alert->get_Description->get_value . "\n" );
      }
    }

  } catch {
      warn $_;
      try {
        warn $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        warn $_;
        warn $response->get_faultstring;
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
    #warn $response;

    $success = $response->get_SummaryResult->get_Status->get_Description->get_value;

    $self->notice( '' );
    if ( $response->get_Response->get_Alert ) {
      foreach my $alert (@{$response->get_Response->get_Alert}) {
        warn $alert->get_Description->get_value;
        $self->add_notice( $alert->get_Description->get_value . "\n" );
      }
    }

  } catch {
      warn $_;
      try {
        warn $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description;
        $self->error( $response->get_detail()->get_Errors()->get_ErrorDetail()->get_PrimaryErrorCode()->get_Description->get_value );
      } catch {
        warn $_;
        warn $response->get_faultstring;
        $self->error( $response->get_faultstring->get_value );
      };
  };

  return $success;

}

no Moose::Util::TypeConstraints;
no Moose;

=head1 AUTHOR

Andrew Baerg @ <andrew at pullingshots dot ca>

http://pullingshots.ca/

=head1 BUGS

Please contact me directly.

=head1 COPYRIGHT

Copyright (C) 2010 Andrew J Baerg, All Rights Reserved

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
