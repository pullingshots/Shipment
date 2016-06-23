package Shipment::Generic;
use strict;
use warnings;

=head1 NAME

Shipment::Generic - a very Generic shipping interface

=head1 SYNOPSIS

This module does not DO a whole lot,

  use Shipment::Generic;
  use Shipment::Address;
  use Shipment::Package;

  my $shipment = Shipment::Generic->new(
    from_address => Shipment::Address->new( ... ),
    to_address => Shipment::Address->new( ... ),
    packages => [ Shipment::Package->new( ... ), ],
  );

  $shipment->rate( 'ground' );

  $shipment->ship( 'ground' );

=head1 ABOUT

This class provides a Generic interface for a shipping service.

=cut

use Moo;
extends 'Shipment::Base';

=head1 Class Attributes

This class does not override or provide any additional attributes.

=head1 Class Methods

=head2 _build_services

This routine simply adds a single "generic" service

=cut

sub _build_services {
  { 
    generic => 
      Shipment::Service->new(
        id => 'generic',
        name => 'Generic Service',
      ),
  }
}

=head2 rate

This routine populates $self->service

It optionally accepts the cost passed as the second argument

  $shipment->rate( 'ground', '12.34 );
  print $shipment->service->cost . "\n";

=cut

sub rate {
  my ( $self, $service_id, $rate ) = @_;

  $service_id ||= 'generic';
  $rate ||= 0;

      use Data::Currency;
      use Shipment::Service;
      $self->service( 
        new Shipment::Service( 
          id        => $service_id,
          name      => $service_id,
          cost      => Data::Currency->new($rate, $self->currency),
        )
      );

}

=head2 ship

This routine sets $self->tracking_id and calls $self->rate
Also sets a label for each package

  $shipment->ship( 'ground', '123456789', '12.32' );

TODO: create generic thermal, pdf, and png labels so that we can do:
  $shipment->get_package(0)->label->save;

=cut

sub ship {
  my ( $self, $service_id, $tracking_id, $rate ) = @_;

  $self->rate($service_id, $rate);

  if (!$tracking_id) {
    foreach (@{ $self->packages }) {
      $tracking_id = $_->tracking_id if $_->tracking_id;
      last if $_->tracking_id;
    }
  }

  $tracking_id ||= 'n/a';

  $self->tracking_id( $tracking_id );

  use Shipment::Label;

  foreach (@{ $self->packages }) { 
    $_->tracking_id( $tracking_id ) if !$_->tracking_id;
    $_->label(
      Shipment::Label->new(
        {
          tracking_id => $_->tracking_id,
          content_type => 'text/plain',
          data => qq|
FROM:
| . $self->from_address->name . qq|
| . $self->from_address->company . qq|
| . $self->from_address->address1 . qq|
| . $self->from_address->address2 . qq|
| . $self->from_address->city . qq|, | . $self->from_address->province_code . qq| | . $self->from_address->postal_code . qq|
| . $self->from_address->country_code . qq|
| . $self->from_address->phone . qq|

TO:
| . $self->to_address->name . qq|
| . $self->to_address->company . qq|
| . $self->to_address->address1 . qq|
| . $self->to_address->address2 . qq|
| . $self->to_address->city . qq|, | . $self->to_address->province_code . qq| | . $self->to_address->postal_code . qq|
| . $self->to_address->country_code . qq|
| . $self->to_address->phone . qq|
|,
          file_name => $_->tracking_id . '.txt',
        },
      )
    );
  }

}

=head2 cancel

This routine really does nothing but return 'success'

  $shipment->tracking_id( '12345' );
  $shipment->cancel;

=cut

sub cancel {
  my $self = shift;

  return 'success';
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
