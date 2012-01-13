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

=head1 Class Methods

=head2 _build_services

This calls getQuotesByRequest from the Temando API

Each Quote that is returned is added to services

The following service mapping is used:
  * ground => ??
  * express => ??
  * priority => ??

This method only uses the first package from $self->packages.

The idea is to list what services are available, but for accurate rate comparisons of multi-piece shipments, the rate method should be used.

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
            class => 'Freight',
            mode => 'Less than load',
            packaging => 'Carton',
            qualifierFreightGeneralFragile => 'N',
            distanceMeasurementType => 'Centimetres',
            weightMeasurementType => 'Kilograms',
            length => $_->length,
            width => $_->width,
            height => $_->height,
            weight => $_->weight,
            quantity => 1,
            description => 'Contains bottle lids.',
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

    warn $response;

  } catch {
    warn $_;
    warn $response->get_faultcode;
    warn $response->get_faultstring;
  };

  \%services
}

1;
