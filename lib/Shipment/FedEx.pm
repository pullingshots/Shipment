package Shipment::FedEx;
use strict;
use warnings;

=head1 NAME

Shipment::FedEx - Interface to FedEx Shipping Web Services

=head1 SYNOPSIS

  use Shipment::FedEx;
  use Shipment::Address;
  use Shipment::Package;

  my $shipment = Shipment::FedEx->new(
    from_address => Shipment::Address->new( ... ),
    to_address => Shipment::Address->new( ... ),
    packages => [ Shipment::Package->new( ... ), ],
  );

  foreach my $service ( $shipment->all_services ) {
    print $service->id . "\n";
  }

  $shipment->rate( 'express' );
  print $service->cost . "\n";

  $shipment->ship( 'ground' );
  $shipment->get_package(0)->label->save;

=head1 ABOUT

This class provides an interface to the FedEx Web Services for Shipping. You must sign up for a developer test key in order to make use of this module.

https://www.fedex.com/wpor/web/jsp/drclinks.jsp?links=techresources/index.html

It is an extension of Shipment::Base.

It makes extensive use of SOAP::WSDL in order to create/decode xml requests and responses. The Shipment::FedEx::WSDL interface was created primarily using the wsdl2perl.pl script from SOAP::WSDL.

=cut

use Try::Tiny;
use Moose 2.0000;
use Moose::Util::TypeConstraints;
use Shipment::SOAP::WSDL;

extends 'Shipment::Base';

=head1 Class Attributes

=head2 meter, key, password

Credentials required to access FedEx Web Services

=cut

has 'meter' => (
  is => 'rw',
  isa => 'Str',
);

has 'key' => (
  is => 'rw',
  isa => 'Str',
);

has 'password' => (
  is => 'rw',
  isa => 'Str',
);

=head2 proxy_domain

This determines whether you will use the FedEx Web Services Testing Environment or the production (live) environment
  * wsbeta.fedex.com:443 (testing)
  * ws.fedex.com:443 (live)

=cut

has 'proxy_domain' => (
  is => 'rw',
  isa => enum( [ qw(
    wsbeta.fedex.com:443
    ws.fedex.com:443
  ) ] ),
  default => 'wsbeta.fedex.com:443',
);

=head2 label_stock_type

The label dimensions/type. 

Default: 4x6

=cut

enum 'LabelStockOptions' => qw( 
  STOCK_4X6
  STOCK_4X6.75_LEADING_DOC_TAB
  STOCK_4X6.75_TRAILING_DOC_TAB
  STOCK_4X8
  STOCK_4X9_LEADING_DOC_TAB
  STOCK_4X9_TRAILING_DOC_TAB
  PAPER_4X6
  PAPER_4X8
  PAPER_4X9
  PAPER_7X4.75
  PAPER_8.5X11_BOTTOM_HALF_LABEL
  PAPER_8.5X11_TOP_HALF_LABEL
  PAPER_LETTER
);

has 'label_stock_type' => (
  is => 'rw',
  isa => 'LabelStockOptions',
  lazy => 1,
  default => sub { 
    my $self = shift;
    
    return 'STOCK_4X6' if $self->printer_type eq 'thermal';
    return 'PAPER_4X6';
  },
);

=head1 Type Maps

=head2 Shipment::Base type maps

Shipment::Base provides abstract types which need to be mapped to FedEx codes (i.e. bill_type of "sender" maps to FedEx "SENDER")

=cut

=head2 Collect billing

FedEx offers collect billing (without the need for a billing account #)

=cut

enum 'BillingOptions' => qw( sender recipient third_party collect );

has '+bill_type' => (
  isa => 'BillingOptions',
);

my %bill_type_map = (
  'sender'      => 'SENDER',
  'recipient'   => 'RECIPIENT',
  'third_party' => 'THIRD_PARTY',
  'collect'     => 'COLLECT',
);

my %signature_type_map = (
  'default'      => 'SERVICE_DEFAULT',
  'required'     => 'DIRECT',
  'not_required' => 'NO_SIGNATURE_REQUIRED',
  'adult'        => 'ADULT',
);

my %pickup_type_map = (
  'pickup'      => 'REGULAR_PICKUP',
  'dropoff'     => 'STATION',
);

my %package_type_map = (
  'custom'      => 'YOUR_PACKAGING',
  'envelope'    => 'FEDEX_ENVELOPE',
  'tube'        => 'FEDEX_TUBE',
  'box'         => 'FEDEX_BOX',
  'pack'        => 'FEDEX_PAK',
);

my %units_type_map = (
  'lb'          => 'LB',
  'kg'          => 'KG',
  'in'          => 'IN',
  'cm'          => 'CM',
);

my %printer_type_map = (
  'pdf'        => 'PDF',
  'thermal'        => 'EPL2',
  'image'      => 'PNG',
);

my %label_content_type_map = (
  'pdf'        => 'application/pdf',
  'thermal'        => 'text/fedex-epl',
  'image'      => 'image/png',
);

=head2 custom package types

FedEx provides package types in addition to the defaults in Shipment::Base
  * FEDEX_10KG_BOX
  * FEDEX_25KG_BOX

=cut

enum 'PackageOptions' => qw( custom envelope tube box pack FEDEX_10KG_BOX FEDEX_25KG_BOX );

has '+package_type' => (
  isa => 'PackageOptions',
);

=head2 default currency

The default currency is USD

=cut

has '+currency' => (
  default => 'USD',
);

=head1 Class Methods

=head2 _build_services

This calls getRates from the Rate Services API

Each Service that is returned is added to services

The following service mapping is used:
  * ground => FEDEX_GROUND or INTERNATIONAL_GROUND
  * express => FEDEX_2_DAY or INTERNATIONAL_ECONOMY
  * priority => PRIORITY_OVERNIGHT or INTERNATIONAL_PRIORITY

This method ignores what is in $self->packages and uses a single package weighing 1 pound for rating. The idea is to list what services are available, but for accurate rate comparisons, the rate method should be used.

=cut

sub _build_services {
  my $self = shift;

  use Shipment::Package;
  use Shipment::Service;
  use Shipment::FedEx::WSDL::RateInterfaces::RateService::RateServicePort;

  my $interface = Shipment::FedEx::WSDL::RateInterfaces::RateService::RateServicePort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );
  my $response;

  my %services;

  my @to_streetlines;
  push @to_streetlines, $self->to_address()->address1;
  push @to_streetlines, $self->to_address()->address2 if $self->to_address()->address2;

  my @from_streetlines;
  push @from_streetlines, $self->from_address()->address1;
  push @from_streetlines, $self->from_address()->address2 if $self->from_address()->address2;

  try {
    $response = $interface->getRates( 
      { 
        WebAuthenticationDetail =>  {
          UserCredential =>  { 
            Key =>  $self->key,
            Password => $self->password,
          },
        },
        ClientDetail =>  { 
          AccountNumber =>  $self->account,
          MeterNumber =>  $self->meter,
        },
        Version =>  {
          ServiceId =>  'crs',
          Major =>  9,
          Intermediate =>  0,
          Minor =>  0,
        },
        ReturnTransitAndCommit =>  1,
        RequestedShipment =>  {
          DropoffType => $pickup_type_map{$self->pickup_type} || $self->pickup_type,
          PackagingType => 'YOUR_PACKAGING',
          Shipper =>  {
            Address =>  { 
              StreetLines         =>  \@from_streetlines,
              City                =>  $self->from_address()->city,
              StateOrProvinceCode =>  $self->from_address()->province_code,
              PostalCode          =>  $self->from_address()->postal_code,
              CountryCode         =>  $self->from_address()->country_code,
            },
          },
          Recipient =>  {
            Address =>  { 
              StreetLines         =>  \@to_streetlines,
              City                =>  $self->to_address()->city,
              StateOrProvinceCode =>  $self->to_address()->province_code,
              PostalCode          =>  $self->to_address()->postal_code,
              CountryCode         =>  $self->to_address()->country_code,
            },
          },
          PackageCount =>  1,
          PackageDetail => 'INDIVIDUAL_PACKAGES',
          RequestedPackageLineItems =>  { 
            Weight => {
              Value => 1,
              Units => $units_type_map{$self->weight_unit} || $self->weight_unit,
            }, 
          },
        },
      },
    );
    #warn $response;

    foreach my $service (@{ $response->get_RateReplyDetails() }) {
      $services{$service->get_ServiceType()->get_value} = Shipment::Service->new(
          id => $service->get_ServiceType()->get_value,
          name => $service->get_ServiceType()->get_value,
          package => Shipment::Package->new(
            id => 'YOUR_PACKAGING',
            name => 'Customer Supplied',
          ),
        );
    }
    $services{ground} = $services{'FEDEX_GROUND'} || $services{'INTERNATIONAL_GROUND'} || Shipment::Service->new();
    $services{express} = $services{'FEDEX_2_DAY'} || $services{'INTERNATIONAL_ECONOMY'} || Shipment::Service->new();
    $services{priority} = $services{'PRIORITY_OVERNIGHT'} || $services{'INTERNATIONAL_PRIORITY'} || Shipment::Service->new();

  } catch {
      warn $_;
      try {
        warn $response->get_Notifications()->get_Message;
        $self->error( $response->get_Notifications()->get_Message->get_value );
      } catch {
        warn $response->get_faultstring;
        $self->error( $response->get_faultstring->get_value ); 
      };
  };

  \%services;
}

=head2 rate

This calls getRates from the Rate Services API

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

  my $total_weight;
  $total_weight += $_->weight for @{ $self->packages };

  my $total_insured_value;
  $total_insured_value += $_->insured_value->value for @{ $self->packages };

  use Shipment::Package;
  use Shipment::Service;
  use Shipment::FedEx::WSDL::RateInterfaces::RateService::RateServicePort;

  my $interface = Shipment::FedEx::WSDL::RateInterfaces::RateService::RateServicePort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );
  my $response;

  my $options;
  $options->{SpecialServiceTypes} = 'SIGNATURE_OPTION';
  $options->{SignatureOptionDetail}->{OptionType} = $signature_type_map{$self->signature_type} || $self->signature_type;

  my @pieces;
  my $sequence = 1;
  foreach (@{ $self->packages }) {
    push @pieces,
      { 
          SequenceNumber => $sequence,
          InsuredValue =>  {
            Currency =>  $_->insured_value->code || $self->currency,
            Amount =>  $_->insured_value->value,
          },
          Weight => {
            Value => $_->weight,
            Units => $units_type_map{$self->weight_unit} || $self->weight_unit,
          },
          Dimensions => {
            Length => $_->length,
            Width => $_->width,
            Height => $_->height,
            Units => $units_type_map{$self->dim_unit} || $self->dim_unit,
          },
          SpecialServicesRequested => $options,
      };
    $sequence++;
  }

  my @to_streetlines;
  push @to_streetlines, $self->to_address()->address1;
  push @to_streetlines, $self->to_address()->address2 if $self->to_address()->address2;

  my @from_streetlines;
  push @from_streetlines, $self->from_address()->address1;
  push @from_streetlines, $self->from_address()->address2 if $self->from_address()->address2;

  my %services;

  try {
    $response = $interface->getRates( 
      { 
        WebAuthenticationDetail =>  {
          UserCredential =>  { 
            Key =>  $self->key,
            Password => $self->password,
          },
        },
        ClientDetail =>  { 
          AccountNumber =>  $self->account,
          MeterNumber =>  $self->meter,
        },
        Version =>  {
          ServiceId =>  'crs',
          Major =>  9,
          Intermediate =>  0,
          Minor =>  0,
        },
        ReturnTransitAndCommit =>  1,
        RequestedShipment =>  {
          ServiceType => $service_id,
          DropoffType => 'REGULAR_PICKUP',
          PackagingType => 'YOUR_PACKAGING',
          TotalWeight => {
            Value => $total_weight,
            Units => $units_type_map{$self->weight_unit} || $self->weight_unit,
          },
          TotalInsuredValue =>  {
            Currency =>  $self->currency,
            Amount =>  $total_insured_value,
          },
          Shipper =>  {
            Address =>  { 
              StreetLines         =>  \@from_streetlines,
              City                =>  $self->from_address()->city,
              StateOrProvinceCode =>  $self->from_address()->province_code,
              PostalCode          =>  $self->from_address()->postal_code,
              CountryCode         =>  $self->from_address()->country_code,
            },
          },
          Recipient =>  {
            Address =>  { 
              StreetLines         =>  \@to_streetlines,
              City                =>  $self->to_address()->city,
              StateOrProvinceCode =>  $self->to_address()->province_code,
              PostalCode          =>  $self->to_address()->postal_code,
              CountryCode         =>  $self->to_address()->country_code,
            },
          },
          PackageCount =>  $self->count_packages,
          PackageDetail => 'INDIVIDUAL_PACKAGES',
          RequestedPackageLineItems =>  \@pieces,  
        },
      },
    );
    #warn $response;

    use Data::Currency;
    use Shipment::Service;
    $self->service( 
      new Shipment::Service( 
        id        => $service_id,
        name      => $self->services->{$service_id}->name,
        cost      => Data::Currency->new(
            $response->get_RateReplyDetails()->get_RatedShipmentDetails->[0]->get_ShipmentRateDetail->get_TotalNetCharge->get_Amount, 
            $response->get_RateReplyDetails()->get_RatedShipmentDetails->[0]->get_ShipmentRateDetail->get_TotalNetCharge->get_Currency, 
          ),
      )
    );
  } catch {
      warn $_;
      try {
        warn $response->get_Notifications()->get_Message;
        $self->error( $response->get_Notifications()->get_Message->get_value );
      } catch {
        warn $response->get_faultstring;
        $self->error( $response->get_faultstring->get_value ); 
      };
  };
}

=head2 ship

This method calls processShipment from the Ship Services API

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

  my $total_weight;
  $total_weight += $_->weight for @{ $self->packages };

  my $total_insured_value;
  $total_insured_value += $_->insured_value->value for @{ $self->packages };

  my $package_options;
  $package_options->{SpecialServiceTypes} = 'SIGNATURE_OPTION';
  $package_options->{SignatureOptionDetail}->{OptionType} = $signature_type_map{$self->signature_type} || $self->signature_type;

  my $shipment_options;
  my @email_notifications;
  if ($self->to_address->email) {
    push @email_notifications, {
      EMailNotificationRecipientType => 'RECIPIENT',
      EMailAddress => $self->to_address->email,
      NotifyOnShipment => 1,
      Format => 'TEXT',
      Localization => {
        LanguageCode => 'EN',
      },
    };
    $shipment_options->{SpecialServiceTypes} = 'EMAIL_NOTIFICATION';
    $shipment_options->{EMailNotificationDetail}->{Recipients} = \@email_notifications;
  }

  my @references;
  push @references, {
    CustomerReferenceType => 'CUSTOMER_REFERENCE',
    Value => $self->get_reference(0),
  } if $self->get_reference(0);
  push @references, {
    CustomerReferenceType => 'INVOICE_NUMBER',
    Value => $self->get_reference(1),
  } if $self->get_reference(1);
  push @references, {
    CustomerReferenceType => 'P_O_NUMBER',
    Value => $self->get_reference(2),
  } if $self->get_reference(2);

  my @to_streetlines;
  push @to_streetlines, $self->to_address()->address1;
  push @to_streetlines, $self->to_address()->address2 if $self->to_address()->address2;

  my @from_streetlines;
  push @from_streetlines, $self->from_address()->address1;
  push @from_streetlines, $self->from_address()->address2 if $self->from_address()->address2;

    my $response;
    my $sequence = 1;
    my $master_tracking_id = {};

    use Shipment::Label;
    use MIME::Base64;
    use Data::Currency;
    use Shipment::Service;
    use DateTime;

    use Shipment::FedEx::WSDL::ShipInterfaces::ShipService::ShipServicePort;

    my $interface = Shipment::FedEx::WSDL::ShipInterfaces::ShipService::ShipServicePort->new(
      {
        proxy_domain => $self->proxy_domain,
      }
    );

    foreach (@{ $self->packages }) {

      try {
        $response = $interface->processShipment( 
          { 
            WebAuthenticationDetail =>  {
              UserCredential =>  { 
                Key =>  $self->key,
                Password => $self->password,
              },
            },
            ClientDetail =>  { 
              AccountNumber =>  $self->account,
              MeterNumber =>  $self->meter,
            },
            Version =>  {
              ServiceId =>  'ship',
              Major =>  9,
              Intermediate =>  0,
              Minor =>  0,
            },
            RequestedShipment => {
              ShipTimestamp => DateTime->now->datetime,
              ServiceType => $service_id,
              DropoffType => $pickup_type_map{$self->pickup_type} || $self->pickup_type,
              PackagingType => $package_type_map{$self->package_type} || $self->package_type,
              TotalWeight => {
                Value => $total_weight,
                Units => $units_type_map{$self->weight_unit} || $self->weight_unit,
              },
              TotalInsuredValue =>  {
                Currency =>  $self->currency,
                Amount =>  $total_insured_value,
              },
              Shipper =>  {
                Contact => {
                  PersonName          =>  $self->from_address()->name,
                  CompanyName         =>  $self->from_address()->company,
                  PhoneNumber         =>  $self->from_address()->phone,
                },
                Address =>  { 
                  StreetLines         =>  \@from_streetlines,
                  City                =>  $self->from_address()->city,
                  StateOrProvinceCode =>  $self->from_address()->province_code,
                  PostalCode          =>  $self->from_address()->postal_code,
                  CountryCode         =>  $self->from_address()->country_code,
                },
              },
              Recipient =>  {
                Contact => {
                  PersonName          =>  $self->to_address()->name,
                  CompanyName         =>  $self->to_address()->company,
                  PhoneNumber         =>  $self->to_address()->phone,
                },
                Address =>  { 
                  StreetLines         =>  \@to_streetlines,
                  City                =>  $self->to_address()->city,
                  StateOrProvinceCode =>  $self->to_address()->province_code,
                  PostalCode          =>  $self->to_address()->postal_code,
                  CountryCode         =>  $self->to_address()->country_code,
                },
              },
              ShippingChargesPayment =>  { 
                PaymentType => $bill_type_map{$self->bill_type} || $self->bill_type,
                Payor =>  { 
                  AccountNumber =>  $self->bill_account,
                  CountryCode   =>  ($self->bill_address) ? $self->bill_address->country_code : $self->from_address->country_code,
                },
              },
              SpecialServicesRequested => $shipment_options,
              RateRequestTypes => 'ACCOUNT',
              PackageCount =>  $self->count_packages,
              PackageDetail => 'INDIVIDUAL_PACKAGES',
              MasterTrackingId => $master_tracking_id,
              RequestedPackageLineItems => {
                SequenceNumber => $sequence,
                InsuredValue =>  {
                  Currency =>  $self->currency,
                  Amount =>  $_->insured_value->value,
                },
                Weight => {
                  Value => $_->weight,
                  Units => $units_type_map{$self->weight_unit} || $self->weight_unit,
                },
                Dimensions => {
                  Length => $_->length,
                  Width => $_->width,
                  Height => $_->height,
                  Units => $units_type_map{$self->dim_unit} || $self->dim_unit,
                },
                SpecialServicesRequested => $package_options,
                CustomerReferences => \@references,
              },
              LabelSpecification =>  {
                LabelFormatType => 'COMMON2D',
                ImageType       => $printer_type_map{$self->printer_type} || $self->printer_type,
                LabelStockType  => $self->label_stock_type,
              },
            },
          },
        );
        #warn $response;
        my $package_details = $response->get_CompletedShipmentDetail->get_CompletedPackageDetails;
        
        if ($self->count_packages > 1) {
          my $master_tracking = $response->get_CompletedShipmentDetail->get_MasterTrackingId;
          $self->tracking_id( $master_tracking->get_TrackingNumber->get_value );
          $master_tracking_id = {
                TrackingIdType => $master_tracking->get_TrackingIdType->get_value,
                TrackingNumber => $master_tracking->get_TrackingNumber->get_value,
          };
        } else {
          $self->tracking_id( $package_details->get_TrackingIds->get_TrackingNumber->get_value );
        }
        $_->tracking_id( $package_details->get_TrackingIds->get_TrackingNumber->get_value );

        if ($package_details->get_PackageRating) {
          $_->cost(
            Data::Currency->new(
              $package_details->get_PackageRating->get_PackageRateDetails->[0]->get_NetCharge->get_Amount->get_value,
              $package_details->get_PackageRating->get_PackageRateDetails->[0]->get_NetCharge->get_Currency->get_value,
            ) 
          );
        } elsif ($response->get_CompletedShipmentDetail->get_ShipmentRating) {
          $_->cost(
            Data::Currency->new(
              $response->get_CompletedShipmentDetail->get_ShipmentRating->get_ShipmentRateDetails->[0]->get_TotalNetCharge->get_Amount->get_value,
              $response->get_CompletedShipmentDetail->get_ShipmentRating->get_ShipmentRateDetails->[0]->get_TotalNetCharge->get_Currency->get_value,
            ) 
          );
        }
        $_->label(
          Shipment::Label->new(
            {
              tracking_id => $package_details->get_TrackingIds->get_TrackingNumber->get_value,
              content_type => $label_content_type_map{$self->printer_type},
              data => decode_base64($package_details->get_Label->get_Parts->get_Image->get_value),
              file_name => $package_details->get_TrackingIds->get_TrackingNumber->get_value . '.' . lc $printer_type_map{$self->printer_type},
            },
          )
        );
        
      } catch {
          warn $_;
          try {
            warn $response->get_Notifications()->get_Message;
            $self->error( $response->get_Notifications()->get_Message->get_value );
          } catch {
            warn $response->get_faultstring;
            $self->error( $response->get_faultstring->get_value ); 
          };
      };
    last if $self->error;
    $sequence++;
  }

  if (!$self->error) {
    my $total_charge_amount = 0;
    my $total_charge_currency = $self->currency;
    try {
      my $total_charge = $response->get_CompletedShipmentDetail->get_ShipmentRating->get_ShipmentRateDetails->[0]->get_TotalNetCharge;
      $total_charge_amount = $total_charge->get_Amount->get_value;
      $total_charge_currency = $total_charge->get_Currency->get_value;
    } catch {
      # for other billing (recipient/third_party/collect), no rate details are returned, so we ignore the caught error
      #warn $_;
    };
    $self->service( 
      new Shipment::Service( 
        id        => $service_id,
        name      => $self->services->{$service_id}->name,
        cost      => Data::Currency->new(
            $total_charge_amount,
            $total_charge_currency,
          ),
      )
    );
  }

}

=head2 cancel

This method calls deleteShipment from the Ship Services API

If the tracking id is greater than 12 digits, it assumes that it is a Ground shipment.

Currently only supports deleting one package (tracking id) at a time - DeletionControl = 'DELETE_ONE_PACKAGE'

returns "SUCCESS" if successful

=cut


sub cancel {
  my $self = shift;

  if (!$self->tracking_id) {
    $self->error('no tracking id provided');
    return;
  }

  use Shipment::FedEx::WSDL::ShipInterfaces::ShipService::ShipServicePort;

  my $interface = Shipment::FedEx::WSDL::ShipInterfaces::ShipService::ShipServicePort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );
  my $response;

  my $type = (length $self->tracking_id > 12) ? 'GROUND' : 'EXPRESS';
  my $success;

  try {
    $response = $interface->deleteShipment(
          { 
            WebAuthenticationDetail =>  {
              UserCredential =>  { 
                Key =>  $self->key,
                Password => $self->password,
              },
            },
            ClientDetail =>  { 
              AccountNumber =>  $self->account,
              MeterNumber =>  $self->meter,
            },
            Version =>  {
              ServiceId =>  'ship',
              Major =>  9,
              Intermediate =>  0,
              Minor =>  0,
            },
            TrackingId =>  { 
              TrackingIdType => $type,
              TrackingNumber => $self->tracking_id,
            },
            DeletionControl => 'DELETE_ONE_PACKAGE',
          },
        );
    #warn $response;
    $success = $response->get_HighestSeverity->get_value; 
  } catch {
      warn $_;
      try {
        warn $response->get_Notifications()->get_Message;
        $self->error( $response->get_Notifications()->get_Message->get_value );
      } catch {
        warn $response->get_faultstring;
        $self->error( $response->get_faultstring->get_value ); 
      };
  };

  return $success;
}


=head2 end_of_day

This method calls groundClose from the Close Services API

The manifest is a plain text file intended to be printed off on standard letter paper

=cut

sub end_of_day {
  my $self = shift;
  
  use Shipment::FedEx::WSDL::CloseInterfaces::CloseService::CloseServicePort;
  my $interface = Shipment::FedEx::WSDL::CloseInterfaces::CloseService::CloseServicePort->new(
    {
      proxy_domain => $self->proxy_domain,
    }
  );
  my $response;

  try {
    $response = $interface->groundClose(
      { 
        WebAuthenticationDetail =>  {
          UserCredential =>  { 
            Key =>  $self->key,
            Password => $self->password,
          },
        },
        ClientDetail =>  { 
          AccountNumber =>  $self->account,
          MeterNumber =>  $self->meter,
        },
        Version =>  {
          ServiceId =>  'clos',
          Major =>  2,
          Intermediate =>  1,
          Minor =>  0,
        },
        TimeUpToWhichShipmentsAreToBeClosed =>  DateTime->now->datetime,
      },
    );
    #warn $response;
    
    $self->manifest(
      Shipment::Label->new(
        content_type => 'text/plain',
        data => decode_base64($response->get_Manifest->get_File->get_value),
        file_name => 'manifest_' . DateTime->now->ymd('_') . '.txt',
      )
    );
  } catch {
    warn $_;
    try {
      warn $response->get_Notifications()->get_Message;
      $self->error( $response->get_Notifications()->get_Message->get_value );
    } catch {
      warn $response->get_faultstring;
      $self->error( $response->get_faultstring->get_value ); 
    };
  };
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
