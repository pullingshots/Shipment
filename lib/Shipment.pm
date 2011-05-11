# ABSTRACT: Interface to Popular Shipping Services
package Shipment;

use Moose;

use Shipment::Address;
use Shipment::Package;

use Shipment::FedEx;
use Shipment::Purolator;
use Shipment::UPS;

=head1 SYNOPSIS

  use Shipment;

  my $shipment = Shipment->new;
     
     $shipment->ups(
        from_address => $shipment->address(...),
        to_address => $shipment->address(...),
        packages => [$shipment->package(...)]
     );

  foreach my $service ( $shipment->all_services ) {
    print $service->id . "\n";
  }

  $shipment->rate( 'express' );
  print $service->cost . "\n";

  $shipment->ship( 'ground' );
  $shipment->get_package(0)->label->save;

=head1 DESCRIPTION

This library provides an interface to popular shipping/courier services. See the
eg (examples) directory for clues about getting up-and-running. Better
documentation coming soon...

=cut

=method fedex

The fedex method returns a L<Shipment::FedEx> object. See L<Shipment::FedEx> for
more details.

=cut

sub fedex {
    shift; return Shipment::FedEx->new(@_)
}

=method purolator

The purolator method returns a L<Shipment::Purolator> object. See
L<Shipment::Purolator> for more details.

=cut

sub purolator {
    shift; return Shipment::Purolator->new(@_)
}

=method ups

The ups method returns a L<Shipment::UPS> object. See L<Shipment::UPS> for
more details.

=cut

sub ups {
    shift; return Shipment::UPS->new(@_)
}

=method address

The address method returns a L<Shipment::Address> object.
See L<Shipment::Address> for more details.

=cut

sub address {
    shift; return Shipment::Address->new(@_)
}

=method package

The package method returns a L<Shipment::Package> object.
See L<Shipment::Package> for more details.

=cut

sub package {
    shift; return Shipment::Package->new(@_)
}

1;
