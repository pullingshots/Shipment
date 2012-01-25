package Shipment::Temando;
use strict;
use warnings;

=head1 NAME

Shipment::Temando - Interface to Temando Shipping Web Services

=head1 SYNOPSIS

  use Shipment::Temando;
  use Shipment::Address;
  use Shipment::Package;

  my $shipment = Shipment::Temando->new(
    from_address => Shipment::Address->new( ... ),
    to_address => Shipment::Address->new( ... ),
    packages => [ Shipment::Pacjage->new( ... ), ],
  );

  foreach my $service ( $shipment->all_services ) {
    print $service->id . " (" . $service->cost . ")\n";
  }

  $shipment->rate( 'Service Name' );
  print $service->cost . "\n";

  $shipment->ship( $service->id );
  $shipment->get_package(0)->label->save;

=head1 ABOUT

This class provides an interface to the Temando Web Services API. You must sign up for an API account with Temando in order to make use of ths module.

http://www.temando.com/affiliateRegistration2.html

It is an extension of Shipment::Base

It makes extensive use of SOAP::WSDL in order to create/decode xml requests and responses. The Shipment::Temando::WSDL interface was created primarily using the wsdl2perl.pl script from SOAP::WSDL.

=cut

use Try::Tiny;
use Moose 2.0000;
use Moose::Util::TypeConstraints;
use Shipment::SOAP::WSDL;

#$Shipment::SOAP::WSDL::Debug = 1;

extends 'Shipment::Base';

=head1 Class Attributes

=head2 user, password

Credentials required to access the Temando API.

=cut

has 'username' => (
  is => 'rw',
  isa => 'Str',
);

has 'password' => (
  is => 'rw',
  isa => 'Str',
);

=head2 live

This determines whether you will use the Temando training web service (for development) or the production web service (live)

=cut

has 'live' => (
  is => 'rw',
  isa => 'Bool',
  default => 0,
);

=head2 class, subclass

These define the type of shipment.

Currently the default (and only supported) options are class="General Goods" and subclass="Household Goods". This should be sane defaults for most shipments.

Temando supports many other options here including Freight (pallets, containers, etc) and Vehicles.

=cut

has 'class' => (
  is => 'rw',
  default => 'General Goods',
);

has 'subclass' => (
  is => 'rw',
  default => 'Household Goods',
);

=head2 Shipment::Base type maps

Shipment::Base provides abstract types which need to be mapped to Temando (i.e. package_type of "envelope" maps to Temando "Document Envelope")

=cut

my %bill_type_map = (
  'sender'      => '',
  'recipient'   => '',
  'third_party' => '',
);

my %signature_type_map = (
  'default'      => '',
  'required'     => '',
  'not_required' => undef,
  'adult'        => '',
);

my %package_type_map = (
  'custom'              => 'Carton',
  'carton'              => 'Carton',
  'envelope'            => 'Document Envelope',
  'tube'                => 'Tube',
  'box'                 => 'Box',
  'pack'                => 'Flat Pack',
  'pallet'              => 'Pallet',
  'cylinder'            => 'Cylinder',
  'letter'              => 'Letter',
  'parcel'              => 'Parcel',
  'bag'                 => 'Satchel/Bag',
  'skid'                => 'Skid',
  'unpacked'            => 'Unpackaged or N/A',
  'wheel'               => 'Wheel/Tyre',
);

my %units_type_map = (
  'lb'          => 'Pounds',
  'oz'          => 'Ounces',
  'kg'          => 'Kilograms',
  'g'          => 'Grams',
  'in'          => 'Inches',
  'ft'          => 'Feet',
  'cm'          => 'Centimetres',
  'm'           => 'Metres',
);

=head2 custom package types

Temando provides package types in addition to the defaults in Shipment::Base

=cut

enum 'PackageOptions' => keys %package_type_map;

has '+package_type' => (
  isa => 'PackageOptions',
  default => 'custom',
);

my %printer_type_map = (
  'pdf'     => '',
  'thermal' => '',
  'image'   => '',
);

my %label_content_type_map = (
  'pdf'     => 'application/pdf',
  'thermal' => 'text/ups-epl',
  'image'   => 'image/gif',
);

=head2 default currency

The default currency is AUD

=cut

has '+currency' => (
  default => 'AUD',
);


=head1 Class Methods

=head2 _build_services

This calls getQuotesByRequest from the Temando API

Each Quote that is returned is added to services

The following service mapping is used:
  * ground => cheapest where <usingGeneralRoad>
  * express => cheapest where <usingExpressRoad>
  * priority => cheapest where <usingExpressAir>

=cut

sub _build_services {
  my $self = shift;

  use Shipment::Package;
  use Shipment::Service;
  use Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port;
  
  my $interface = Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port->new(
    {
      live => $self->live,
    }
  );

  my @pieces;
  foreach (@{ $self->packages }) {
    push @pieces,
      {
          class => $self->class,
          subclass => $self->subclass,
          packaging => ($_->type) ? $package_type_map{$_->type} : $package_type_map{$self->package_type},
          qualifierFreightGeneralFragile => ($_->fragile) ? 'Y' : 'N',
          distanceMeasurementType => $units_type_map{$self->dim_unit},
          weightMeasurementType => $units_type_map{$self->weight_unit},
          length => $_->length,
          width => $_->width,
          height => $_->height,
          weight => $_->weight,
          quantity => 1,
          description => $_->notes,
      };
  }

  my $response;
  my %services;

  try {

    $response = $interface->getQuotesByRequest(
      {
        anythings => {
          anything => \@pieces,
        },
        anywhere => {
          itemNature => 'Domestic',
          itemMethod => 'Door to Door',
          originCountry => $self->from_address->country_code,
          originCode => $self->from_address->postal_code,
          originSuburb => $self->from_address->city,
          destinationCountry => $self->to_address->country_code,
          destinationCode => $self->to_address->postal_code,
          destinationSuburb => $self->to_address->city,
          destinationIs => 'Residence',
          originIs => 'Business',
        },
        anytime => {
          readyDate => '2012-12-12',
          readyTime => 'PM',
        },
        general => {
          goodsValue => '2000.00',
        }
      },
      {
        UsernameToken => {
          Username => $self->username,
          Password => $self->password,
        },
      },
    );

    #warn $response;

    foreach my $quote (@{ $response->get_quote }) {
      my $id = $quote->get_carrier->get_id->get_value . $quote->get_deliveryMethod->get_value;
      $services{$id} = Shipment::Service->new(
          id        => $quote->get_carrier->get_id->get_value,
          name      => $quote->get_carrier->get_companyName->get_value . " - " . $quote->get_deliveryMethod->get_value,
          etd       => $quote->get_etaTo->get_value,
          cost      => Data::Currency->new($quote->get_totalPrice->get_value, $quote->get_currency->get_value),
        );

      my $type; 
      $type = 'ground' if $quote->get_usingGeneralRoad->get_value eq 'Y';
      $type = 'express' if $quote->get_usingExpressRoad->get_value eq 'Y';
      $type = 'priority' if $quote->get_usingExpressAir->get_value eq 'Y';

      if ($services{$type}) {
        $services{$type} = $services{$id} if $services{$type}->cost > $services{$id}->cost;
      }
      else {
        $services{$type} = $services{$id};
      }
    }

  } catch {
    warn $_;
    warn $response->get_faultcode;
    warn $response->get_faultstring;
  };

  \%services
}

1;
