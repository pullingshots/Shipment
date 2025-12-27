package Shipment::Purolator;
use strict;
use warnings;

=head1 NAME

Shipment::Purolator - Interface to Purolator Shipping Web Services

=head1 SYNOPSIS

  use Shipment::Purolator;
  use Shipment::Address;
  use Shipment::Package;

  my $shipment = Shipment::Purolator->new(
    from_address => Shipment::Address->new( ... ),
    to_address => Shipment::Address->new( ... ),
    packages => [ Shipment::Package->new( ... ), ],
  );

  foreach my $service ( $shipment->all_services ) {
    print $service->id . "\n";
  }

  $shipment->rate( 'express' );
  print $shipment->service->cost . "\n";

  $shipment->ship( 'ground' );
  $shipment->get_package(0)->label->save;


=head1 ABOUT

This class provides an interface to the Purolator E-Ship Web Services.

For code examples, see https://github.com/pullingshots/Shipment/tree/master/eg

You must sign up for a development key in order to make use of this module.

https://eship.purolator.com

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

=head2 key, password

Credentials required to access Puroator E-Ship Web Services

=cut

has 'key' => (
  is => 'rw',
  isa => Str,
);

has 'password' => (
  is => 'rw',
  isa => Str,
);

=head2 proxy_domain

This determines whether you will use the Purolator testing environment (for development) or the production (live) environment
  * devwebservices.purolator.com (development)
  * webservices.purolator.com (production)

=cut

has 'proxy_domain' => (
  is => 'rw',
  isa => Enum[ qw(
    devwebservices.purolator.com
    webservices.purolator.com
  ) ],
  default => 'devwebservices.purolator.com',
);

=head2 Shipment::Base type maps

Shipment::Base provides abstract types which need to be mapped to Purolator codes (i.e. package_type of "custom" maps to Purolator "CustomerPackaging")

=cut

my %bill_type_map = (
  'sender'      => 'Sender',
  'recipient'   => 'Receiver',
  'third_party' => 'ThirdParty',
);

my %pickup_type_map = (
  'pickup'      => 'PreScheduled',
  'dropoff'     => 'DropOff',
);

my %package_type_map = (
  'custom'      => 'CustomerPackaging',
  'envelope'    => 'ExpressEnvelope',
  'tube'        => '',
  'box'         => 'ExpressBox',
  'pack'        => 'ExpressPack',
);

my %units_type_map = (
  'lb'          => 'lb',
  'kg'          => 'kg',
  'in'          => 'in',
  'cm'          => 'cm',
);

=head2 printer types

Purolator does not offer true thermal printing, all labels are provided as pdfs, thermal labels are simply a 4x6 pdf.

=cut

my %printer_type_map = (
  'pdf'        => 'Regular',
  'thermal'        => 'Thermal',
  'image'      => '',
);

=head2 default currency

The default currency is CAD

=cut

has '+currency' => (
  default => 'CAD',
);

=head1 Class Methods

=head2 _build_services

This calls GetServicesOptions from the Service Availability API

Each Service that is returned is added to services

The following service mapping is used:
  * ground => PurolatorGround (when shipping within the same city this gets mapped to PurolatorExpress)
  * express => PurolatorExpress
  * priority => PurolatorExpress9AM/10:30AM/12:00/Evening (exact service depends on what is available)

All of the available service options are placed in the service->options hashref

=cut

sub _build_services {
  my $self = shift;

  if ($self->from_address && $self->to_address) {

    use Shipment::Package;
    use Shipment::Service;
    use Shipment::Purolator::WSDLV2::Interfaces::ServiceAvailabilityService::ServiceAvailabilityServiceEndpoint;

    my $interface = Shipment::Purolator::WSDLV2::Interfaces::ServiceAvailabilityService::ServiceAvailabilityServiceEndpoint->new(
      {
        proxy_domain => $self->proxy_domain,
        key => $self->key,
        password => $self->password,
      }
    );
    my $response;
  
    my %services;

    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    $response = $interface->GetServicesOptions( {
        BillingAccountNumber => $self->account,
        SenderAddress => {
          City       => $self->from_address()->city,
          Province   => $self->from_address()->province_code,
          Country    => $self->from_address()->country_code,
          PostalCode => $self->from_address()->postal_code,
        }, 
        ReceiverAddress => {
          City       => $self->to_address()->city,
          Province   => $self->to_address()->province_code,
          Country    => $self->to_address()->country_code,
          PostalCode => $self->to_address()->postal_code,
        },
      },
      {
                  'Version'           =>  '2.0',
                  'Language'          =>  'en',
                  'GroupID'           =>  'xxx',
                  'RequestReference'  =>  'Shipment::Purolator::_build_services'
      },
    );
    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    try {
      foreach my $service (@{ $response->get_Services()->get_Service() }) {
        if ($service->get_PackageType()->get_value eq $package_type_map{$self->package_type}) {
          $services{$service->get_ID()->get_value} = Shipment::Service->new(
              id => $service->get_ID()->get_value,
              name => $service->get_Description()->get_value,
            );
          my %options;
          foreach my $option (@{ $service->get_Options()->get_Option() }) {
            $options{$option->get_ID()->get_value} = $option->get_ValueType()->get_value;
          }
          $services{$service->get_ID()->get_value}->options(\%options);
          $services{ground} = $services{$service->get_ID()->get_value} if ($service->get_ID()->get_value =~ /PurolatorGround/);
          $services{express} = $services{$service->get_ID()->get_value} if ($service->get_ID()->get_value =~ /PurolatorExpress/ && $service->get_ID()->get_value !~ /(9AM|10:30AM|12:00|Evening)$/);
          $services{priority} = $services{$service->get_ID()->get_value} if ($service->get_ID()->get_value =~ /PurolatorExpress/ && $service->get_ID()->get_value =~ /(9AM|10:30AM|12:00|Evening)$/);

        }
      }
      $services{ground} = $services{express} if (!$services{ground} && $services{express});
    } catch {
      warn $_ if $self->debug;
      try {
        warn $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description if $self->debug;
        $self->error( $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
    };
    \%services;
  }
  else {
    warn 'services not fetched. both from and to address required.' if $self->debug;
    $self->error( 'services not fetched. both from and to address required.' );

    {};
  }
}

=head2 rate

This method calls GetFullEstimate from the Estimating API

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

    my $total_weight;
    $total_weight += $_->weight for @{ $self->packages };

    my @options;
    my $signature_option;
    if ($self->signature_type =~ /^(required|default|adult)$/) {
      $signature_option = "ResidentialSignatureDomestic" if $self->services->{$service_id}->options->{ResidentialSignatureDomestic};
      $signature_option = "ResidentialSignatureIntl" if $self->services->{$service_id}->options->{ResidentialSignatureIntl};
    } elsif ($self->signature_type eq 'not_required') {
      $signature_option = "OriginSignatureNotRequired";
    }

    if ($signature_option) {
      push @options, 
                {
                  ID => $signature_option,
                  Value => 'true',
                };
    }

    my @pieces;
    foreach (@{ $self->packages }) {
      if ($self->package_type eq 'custom') {
        push @pieces,
          {
              Weight => {
                Value => sprintf("%.0f", $_->weight) || 1,
                WeightUnit => $self->weight_unit,
              },
              Length => {
                Value => $_->length,
                DimensionUnit => $self->dim_unit,
              },
              Width => {
                Value => $_->width,
                DimensionUnit => $self->dim_unit,
              },
              Height => {
                Value => $_->height,
                DimensionUnit => $self->dim_unit,
              },
          };
      }
      else {
        push @pieces,
          {
              Weight => {
                Value => sprintf("%.0f", $_->weight) || 1,
                WeightUnit => $self->weight_unit,
              },
          };
      }
    }

    use Shipment::Purolator::WSDLV2::Interfaces::EstimatingService::EstimatingServiceEndpoint;
    my $interface = Shipment::Purolator::WSDLV2::Interfaces::EstimatingService::EstimatingServiceEndpoint->new(
      {
        proxy_domain => $self->proxy_domain,
        key => $self->key,
        password => $self->password,
      }
    );

    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    my $response = $interface->GetFullEstimate(
      {
        Shipment => {
          SenderInformation => {
            Address => {
              Name            => $self->from_address->name,
              Company         => $self->from_address->company,
              StreetNumber    => $self->from_address->address_components->{number},
              StreetName      => $self->from_address->address_components->{street} . ' ' . $self->from_address->address_components->{direction},
              StreetAddress2  => $self->from_address->address2,
              City            => $self->from_address->city,
              Province        => $self->from_address->province_code,
              Country         => $self->from_address->country_code,
              PostalCode      => $self->from_address->postal_code,
              PhoneNumber => {
                CountryCode   => $self->from_address->phone_components->{country},
                AreaCode      => $self->from_address->phone_components->{area},
                Phone         => $self->from_address->phone_components->{phone},
              },
            },
          },
          ReceiverInformation => {
            Address => {
              Name            => $self->to_address->name,
              Company         => $self->to_address->company,
              StreetNumber    => $self->to_address->address_components->{number},
              StreetName      => $self->to_address->address_components->{street} . ' ' . $self->to_address->address_components->{direction},
              StreetAddress2  => $self->to_address->address2,
              City            => $self->to_address->city,
              Province        => $self->to_address->province_code,
              Country         => $self->to_address->country_code,
              PostalCode      => $self->to_address->postal_code,
              PhoneNumber => {
                CountryCode   => $self->to_address->phone_components->{country},
                AreaCode      => $self->to_address->phone_components->{area},
                Phone         => $self->to_address->phone_components->{phone},
              },
            },
          },
          PackageInformation  => {
            ServiceID => $service_id,
            TotalWeight => {
              Value => sprintf("%.0f", $total_weight) || 1,
              WeightUnit => $self->weight_unit,
            },
            TotalPieces => scalar @{ $self->packages },
            PiecesInformation => {
                Piece =>  \@pieces,
            },
            OptionsInformation => {
              Options => { 
                OptionIDValuePair => \@options, 
              },
            },
          },
          PaymentInformation => {
            PaymentType => 'Sender',
            RegisteredAccountNumber => $self->account,
            BillingAccountNumber => $self->account,
          },
          PickupInformation => {
            PickupType => $pickup_type_map{$self->pickup_type} || $self->pickup_type,
          },
          TrackingReferenceInformation =>  {
            Reference1 => $self->get_reference(0),
            Reference2 => $self->get_reference(1),
            Reference3 => $self->get_reference(2),
            Reference4 => $self->get_reference(3),
          },
        },
        ShowAlternativeServicesIndicator => "false",
      },
      {
                  'Version'           =>  '2.0',
                  'Language'          =>  'en',
                  'GroupID'           =>  'xxx',
                  'RequestReference'  =>  'Shipment::Purolator::rate'
      },
    );
    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    try {
      use Data::Currency;
      use Shipment::Service;
      my ($y, $m, $d) = split('-', $response->get_ShipmentEstimates()->[0]->get_ShipmentEstimate()->get_ShipmentDate()->get_value);
      my $ship_date = { year => $y, month => $m, day => $d };
      ($y, $m, $d) = split('-', $response->get_ShipmentEstimates()->[0]->get_ShipmentEstimate()->get_ExpectedDeliveryDate()->get_value);
      my $eta = { year => $y, month => $m, day => $d };
      $self->service( 
         Shipment::Service->new( 
          id        => $service_id,
          name      => $self->services->{$service_id}->name,
          etd       => $response->get_ShipmentEstimates()->[0]->get_ShipmentEstimate()->get_EstimatedTransitDays()->get_value,
          ship_date => $ship_date,
          eta       => $eta,
          cost      => Data::Currency->new($response->get_ShipmentEstimates()->[0]->get_ShipmentEstimate()->get_TotalPrice, 'CAD'),
        )
      );
    } catch {
      warn $_ if $self->debug;
      try {
        warn $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description if $self->debug;
        $self->error( $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
    };

}

=head2 ship

This calls CreateShipment from the Shipping API

It also calls fetch_documents which is a separate method since Purolator does not return the label along with the create shipment response.

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

    $self->rate( $service_id );

    my $total_weight;
    $total_weight += $_->weight for @{ $self->packages };

    my @options;
    my $signature_option;
    if ($self->signature_type =~ /^(required|default|adult)$/) {
      $signature_option = "ResidentialSignatureDomestic" if $self->services->{$service_id}->options->{ResidentialSignatureDomestic};
      $signature_option = "ResidentialSignatureIntl" if $self->services->{$service_id}->options->{ResidentialSignatureIntl};
    } elsif ($self->signature_type eq 'not_required') {
      $signature_option = "OriginSignatureNotRequired";
    }

    if ($signature_option) {
      push @options, 
                {
                  ID => $signature_option,
                  Value => 'true',
                };
    }

    my $notification_information;
    if ($self->to_address->email) {
      $notification_information->{AdvancedShippingNotificationEmailAddress1} = $self->to_address->email;
    }

    my @pieces;
    foreach (@{ $self->packages }) {
      if ($self->package_type eq 'custom') {
        push @pieces,
          {
              Weight => {
                Value => sprintf("%.0f", $_->weight) || 1,
                WeightUnit => $self->weight_unit,
              },
              Length => {
                Value => $_->length,
                DimensionUnit => $self->dim_unit,
              },
              Width => {
                Value => $_->width,
                DimensionUnit => $self->dim_unit,
              },
              Height => {
                Value => $_->height,
                DimensionUnit => $self->dim_unit,
              },
          };
      }
      else {
        push @pieces,
          {
              Weight => {
                Value => sprintf("%.0f", $_->weight) || 1,
                WeightUnit => $self->weight_unit,
              },
          };
      }
    }

    use Shipment::Purolator::WSDLV2::Interfaces::ShippingService::ShippingServiceEndpoint;
    my $interface = Shipment::Purolator::WSDLV2::Interfaces::ShippingService::ShippingServiceEndpoint->new(
      {
        proxy_domain => $self->proxy_domain,
        key => $self->key,
        password => $self->password,
      }
    );

    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    my $response = $interface->CreateShipment(
      {
        Shipment => {
          SenderInformation => {
            Address => {
              Name            => $self->from_address->name,
              Company         => $self->from_address->company,
              StreetNumber    => $self->from_address->address_components->{number},
              StreetName      => $self->from_address->address_components->{street} . ' ' . $self->from_address->address_components->{direction},
              StreetAddress2  => $self->from_address->address2,
              City            => $self->from_address->city,
              Province        => $self->from_address->province_code,
              Country         => $self->from_address->country_code,
              PostalCode      => $self->from_address->postal_code,
              PhoneNumber => {
                CountryCode   => $self->from_address->phone_components->{country},
                AreaCode      => $self->from_address->phone_components->{area},
                Phone         => $self->from_address->phone_components->{phone},
              },
            },
          },
          ReceiverInformation => {
            Address => {
              Name            => $self->to_address->name,
              Company         => $self->to_address->company,
              StreetNumber    => $self->to_address->address_components->{number},
              StreetName      => $self->to_address->address_components->{street} . ' ' . $self->to_address->address_components->{direction},
              StreetAddress2  => $self->to_address->address2,
              City            => $self->to_address->city,
              Province        => $self->to_address->province_code,
              Country         => $self->to_address->country_code,
              PostalCode      => $self->to_address->postal_code,
              PhoneNumber => {
                CountryCode   => $self->to_address->phone_components->{country},
                AreaCode      => $self->to_address->phone_components->{area},
                Phone         => $self->to_address->phone_components->{phone},
              },
            },
          },
          PackageInformation  => {
            ServiceID => $service_id,
            TotalWeight => {
              Value => sprintf("%.0f", $total_weight) || 1,
              WeightUnit => $self->weight_unit,
            },
            TotalPieces => scalar @{ $self->packages },
            PiecesInformation => {
                Piece =>  \@pieces,
            },
            OptionsInformation => {
              Options => { 
                OptionIDValuePair => \@options, 
              },
            },
          },
          PaymentInformation => {
            PaymentType => $bill_type_map{$self->bill_type} || $self->bill_type,
            RegisteredAccountNumber => $self->account,
            BillingAccountNumber => $self->bill_account,
          },
          PickupInformation => {
            PickupType => $pickup_type_map{$self->pickup_type} || $self->pickup_type,
          },
          TrackingReferenceInformation =>  {
            Reference1 => $self->get_reference(0),
            Reference2 => $self->get_reference(1),
            Reference3 => $self->get_reference(2),
            Reference4 => $self->get_reference(3),
          },
          NotificationInformation => $notification_information,
          OtherInformation => {
            SpecialInstructions => $self->special_instructions,
          },
        },
        PrinterType => $printer_type_map{$self->printer_type} || $self->printer_type,
      },
      {
                  'Version'           =>  '2.0',
                  'Language'          =>  'en',
                  'GroupID'           =>  'xxx',
                  'RequestReference'  =>  'Shipment::Purolator::ship'
      },
    );
    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    try {
      $self->tracking_id( $response->get_ShipmentPIN()->get_Value()->get_value );
      use Shipment::Label;
      my $package_index = 0;
      foreach (@{ $response->get_PiecePINs()->get_PIN() }) {
        $self->get_package($package_index)->tracking_id($_->get_Value()->get_value);
        $self->get_package($package_index)->label(
          Shipment::Label->new(
            {
              tracking_id => $_->get_Value()->get_value,
            },
          )
        );
        $package_index++
      }
    } catch {
      try {
        warn $_ if $self->debug;
        warn $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description if $self->debug;
        $self->error( $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
    };

    $self->fetch_documents();

}

=head2 return

This calls CreateReturnsManagementShipment from the ReturnsManagement API

It also calls fetch_documents which is a separate method since Purolator does not return the label along with the create shipment response.

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

    my $total_weight;
    $total_weight += $_->weight for @{ $self->packages };

    my @pieces;
    foreach (@{ $self->packages }) {
      if ($self->package_type eq 'custom') {
        push @pieces,
          {
              Weight => {
                Value => sprintf("%.0f", $_->weight) || 1,
                WeightUnit => $self->weight_unit,
              },
              Length => {
                Value => $_->length,
                DimensionUnit => $self->dim_unit,
              },
              Width => {
                Value => $_->width,
                DimensionUnit => $self->dim_unit,
              },
              Height => {
                Value => $_->height,
                DimensionUnit => $self->dim_unit,
              },
          };
      }
      else {
        push @pieces,
          {
              Weight => {
                Value => sprintf("%.0f", $_->weight) || 1,
                WeightUnit => $self->weight_unit,
              },
          };
      }
    }

    use Shipment::Purolator::WSDLV2::Interfaces::ReturnsManagement::ReturnsManagementServiceEndpoint;
    my $interface = Shipment::Purolator::WSDLV2::Interfaces::ReturnsManagement::ReturnsManagementServiceEndpoint->new(
      {
        proxy_domain => $self->proxy_domain,
        key => $self->key,
        password => $self->password,
      }
    );

    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    my $response = $interface->CreateReturnsManagementShipment(
      {
        ReturnsManagementShipment => {
          SenderInformation => {
            Address => {
              Name            => $self->from_address->name,
              Company         => $self->from_address->company,
              StreetNumber    => $self->from_address->address_components->{number},
              StreetName      => $self->from_address->address_components->{street} . ' ' . $self->from_address->address_components->{direction},
              StreetAddress2  => $self->from_address->address2,
              City            => $self->from_address->city,
              Province        => $self->from_address->province_code,
              Country         => $self->from_address->country_code,
              PostalCode      => $self->from_address->postal_code,
              PhoneNumber => {
                CountryCode   => $self->from_address->phone_components->{country},
                AreaCode      => $self->from_address->phone_components->{area},
                Phone         => $self->from_address->phone_components->{phone},
              },
            },
          },
          ReceiverInformation => {
            Address => {
              Name            => $self->to_address->name,
              Company         => $self->to_address->company,
              StreetNumber    => $self->to_address->address_components->{number},
              StreetName      => $self->to_address->address_components->{street} . ' ' . $self->to_address->address_components->{direction},
              StreetAddress2  => $self->to_address->address2,
              City            => $self->to_address->city,
              Province        => $self->to_address->province_code,
              Country         => $self->to_address->country_code,
              PostalCode      => $self->to_address->postal_code,
              PhoneNumber => {
                CountryCode   => $self->to_address->phone_components->{country},
                AreaCode      => $self->to_address->phone_components->{area},
                Phone         => $self->to_address->phone_components->{phone},
              },
            },
          },
          PackageInformation  => {
            ServiceID => $service_id,
            TotalWeight => {
              Value => sprintf("%.0f", $total_weight) || 1,
              WeightUnit => $self->weight_unit,
            },
            TotalPieces => scalar @{ $self->packages },
            PiecesInformation => {
                Piece =>  \@pieces,
            },
          },
          PaymentInformation => {
            PaymentType => $bill_type_map{$self->bill_type} || $self->bill_type,
            RegisteredAccountNumber => $self->account,
            BillingAccountNumber => $self->bill_account,
          },
          PickupInformation => {
            PickupType => $pickup_type_map{$self->pickup_type} || $self->pickup_type,
          },
          TrackingReferenceInformation =>  {
            Reference1 => $self->get_reference(0),
            Reference2 => $self->get_reference(1),
            Reference3 => $self->get_reference(2),
            Reference4 => $self->get_reference(3),
          },
          OtherInformation => {
            SpecialInstructions => $self->special_instructions,
          },
        },
        PrinterType => $printer_type_map{$self->printer_type} || $self->printer_type,
      },
      {
                  'Version'           =>  '2.0',
                  'Language'          =>  'en',
                  'GroupID'           =>  'xxx',
                  'RequestReference'  =>  'Shipment::Purolator::return'
      },
    );

    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    try {
      $self->tracking_id( $response->get_ShipmentPIN()->get_Value()->get_value );
      use Shipment::Label;
      my $package_index = 0;
      foreach (@{ $response->get_PiecePINs()->get_PIN() }) {
        $self->get_package($package_index)->tracking_id($_->get_Value()->get_value);
        $self->get_package($package_index)->label(
          Shipment::Label->new(
            {
              tracking_id => $_->get_Value()->get_value,
            },
          )
        );
        $package_index++
      }
    } catch {
      try {
        warn $_ if $self->debug;
        warn $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description if $self->debug;
        $self->error( $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
    };

    $self->fetch_documents();
}

=head2 fetch_documents

Calls GetDocuments from the Shipping Documents API

Purolator returns all of the labels and required documents in a single pdf. Because of this, for a multi-piece shipment, calling

  $shipment->get_package(0)->label-save;

will actually save a pdf file with all of the labels and documents. It is probably a better idea to make use of

  $shipment->documents->save

=cut

sub fetch_documents {
    my $self = shift;

    return unless $self->tracking_id;

    use Shipment::Purolator::WSDL::Interfaces::ShippingDocumentsService::ShippingDocumentsServiceEndpoint;
    my $interface = Shipment::Purolator::WSDL::Interfaces::ShippingDocumentsService::ShippingDocumentsServiceEndpoint->new(
      {
        proxy_domain => $self->proxy_domain,
        key => $self->key,
        password => $self->password,
      }
    );

    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    my $response = $interface->GetDocuments(
      {
        DocumentCriterium => {
          DocumentCriteria => {
            PIN => {
              Value => $self->tracking_id,
            },
          },
        },
      },
      {
                  'Version'           =>  '1.3',
                  'Language'          =>  'en',
                  'GroupID'           =>  'xxx',
                  'RequestReference'  =>  'Shipment::Purolator::fetch_documents'
      },
    );
    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    my $document_url;
    try {
      $document_url = $response->get_Documents()->get_Document()->get_DocumentDetails()->[0]->get_DocumentDetail()->get_URL()->get_value;
    } catch {
      warn $_ if $self->debug;
      try {
        warn $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description if $self->debug;
        $self->error( $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
    };

    use LWP::UserAgent;
    use Shipment::Label;
    my $ua = LWP::UserAgent->new('Shipping::Purolator');
    my $req = HTTP::Request->new(GET => $document_url);

    ## for multi-piece shipments, the labels are not always ready immediately after generating the shipment... try 10 times, sleeping for a second in between each try.
    my $label_success;
    my $res;
    for (1..10) {
      $res = $ua->request($req);
      sleep 1 && next unless $res->is_success && $res->content;

      $label_success = 1;
      $self->documents(
        Shipment::Label->new(
          tracking_id   => $self->tracking_id,
          content_type  => $res->header('Content-Type'),
          data          => $res->content,
          file_name     => $self->tracking_id . '-documents.pdf',
        )
      );

      foreach ($self->all_packages) {
        $_->label->content_type( $res->header('Content-Type') );
        $_->label->data( $res->content );
        $_->label->file_name( $_->tracking_id . '.pdf' );
      }
    }

    if (!$label_success) {
      if (!$res->is_success) {
        warn $res->status_line if $self->debug;
        $self->error( "Failed to retrieve label(s) from " . $document_url . ": " . $res->status_line );
      }
      else {
        warn "No content returned from label url: " . $document_url if $self->debug;
        $self->error( "Failed to retrieve label(s) from " . $document_url );
      }
      $self->cancel;
    }
}

=head2 cancel

Calls VoidShipment from the Shipping API

For multi-piece shipments, any 1 of the related tracking id's can be in $shipment->tracking_id. All related packages will be voided. There is no way to void a single package within a multi-piece shipment.

returns "true" if successful

=cut

sub cancel {
  my $self = shift;

  if (!$self->tracking_id) {
    $self->error('no tracking id provided');
    return;
  }

    use Shipment::Purolator::WSDLV2::Interfaces::ShippingService::ShippingServiceEndpoint;
    my $interface = Shipment::Purolator::WSDLV2::Interfaces::ShippingService::ShippingServiceEndpoint->new(
      {
        proxy_domain => $self->proxy_domain,
        key => $self->key,
        password => $self->password,
      }
    );

    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    my $response = $interface->VoidShipment(
      {
        PIN => {
          Value => $self->tracking_id,
        },
      },
      {
                  'Version'           =>  '2.0',
                  'Language'          =>  'en',
                  'GroupID'           =>  'xxx',
                  'RequestReference'  =>  'Shipment::Purolator::cancel'
      },
    );
    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    my $success;
    try {
      $success = $response->get_ShipmentVoided->get_value;
    } catch {
      try {
        warn $_ if $self->debug;
        warn $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description if $self->debug;
        $self->error( $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
    };
  
  return $success;
}

=head2 

This depends on calling Consolidate from the Shipping API which has not been implemented yet

Calls GetShipmentManifestDocument from the Shipping Documents API

=cut

sub end_of_day {
  my $self = shift;

    use DateTime;
    use Shipment::Purolator::WSDL::Interfaces::ShippingDocumentsService::ShippingDocumentsServiceEndpoint;
    my $interface = Shipment::Purolator::WSDL::Interfaces::ShippingDocumentsService::ShippingDocumentsServiceEndpoint->new(
      {
        proxy_domain => $self->proxy_domain,
        key => $self->key,
        password => $self->password,
      }
    );

    #TODO: call Consolidate before getting manifest document

    $Shipment::SOAP::WSDL::Debug = 1 if $self->debug > 1;
    my $response = $interface->GetShipmentManifestDocument(
      {
        ShipmentManifestDocumentCriterium => {
          ShipmentManifestDocumentCriteria => {
            ManifestDate => DateTime->now->ymd,
          }
        }
      },
      {
                  'Version'           =>  '1.3',
                  'Language'          =>  'en',
                  'GroupID'           =>  'xxx',
                  'RequestReference'  =>  'Shipment::Purolator::end_of_day'
      },
    );
    $Shipment::SOAP::WSDL::Debug = 0;
    warn "Response\n" . $response if $self->debug > 1;

    try {
      use LWP::UserAgent;
      my $ua = LWP::UserAgent->new('Shipping::Purolator');
      my $req = HTTP::Request->new(GET => $response->get_ManifestBatches()->[0]->get_ManifestBatch()->get_ManifestBatchDetails->get_ManifestBatchDetail->get_URL()->get_value);
      my $res = $ua->request($req);
      $self->manifest(
        Shipment::Label->new(
          content_type => $res->header('Content-Type'),
          data => $res->content,
          file_name => 'manifest_' . DateTime->now->ymd('_') . '.pdf',
        )
      );
    } catch {
      warn $_ if $self->debug;
      try {
        warn $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description if $self->debug;
        $self->error( $response->get_ResponseInformation()->get_Errors()->get_Error()->[0]->get_Description->get_value );
      } catch {
        warn $_ if $self->debug;
        warn $response->get_faultstring if $self->debug;
        $self->error( $response->get_faultstring->get_value );
      };
    };

}

=head1 AUTHOR

Andrew Baerg @ <andrew at pullingshots dot ca>

http://pullingshots.ca/

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
