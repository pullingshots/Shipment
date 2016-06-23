# ABSTRACT: Interface to Popular Shipping Services
package Shipment;

use Shipment::Address;
use Shipment::Package;

use Shipment::Generic;
use Shipment::FedEx;
use Shipment::Purolator;
use Shipment::UPS;
use Shipment::Temando;

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

=cut

=head1 DESCRIPTION

  This library provides an interface to popular shipping/courier services.

  See the relevant module for details on usage.

  For code examples, see https://github.com/pullingshots/Shipment/tree/master/eg

=cut

=over

=item generic

  The generic method returns a L<Shipment::Generic> object. See L<Shipment::Generic> for
  more details.

=cut

sub generic {
    shift; return Shipment::Generic->new(@_)
}


=item fedex

  The fedex method returns a L<Shipment::FedEx> object. See L<Shipment::FedEx> for
  more details.

=cut

sub fedex {
    shift; return Shipment::FedEx->new(@_)
}

=item purolator

  The purolator method returns a L<Shipment::Purolator> object. See
  L<Shipment::Purolator> for more details.

=cut

sub purolator {
    shift; return Shipment::Purolator->new(@_)
}

=item ups

  The ups method returns a L<Shipment::UPS> object. See L<Shipment::UPS> for
  more details.

=cut

sub ups {
    shift; return Shipment::UPS->new(@_)
}

=item temando

  The temando method returns a L<Shipment::Temando> object. See L<Shipment::Temando> for
  more details.

=cut

sub temando {
    shift; return Shipment::Temando->new(@_)
}

=item address

  The address method returns a L<Shipment::Address> object.
  See L<Shipment::Address> for more details.

=cut

sub address {
    shift; return Shipment::Address->new(@_)
}

=item package

  The package method returns a L<Shipment::Package> object.
  See L<Shipment::Package> for more details.

=cut

=back

sub package {
    shift; return Shipment::Package->new(@_)
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
