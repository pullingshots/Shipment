package Shipment::Package;
use strict;
use warnings;

=head1 NAME

Shipment::Package - a package to be shipped

=head1 SYNOPSIS

  use Shipment::Package;

  my $package = Shipment::Package->new(
    weight => 10,
    length => 18,
    width  => 18,
    height => 24,
  );

=head1 ABOUT

This class defines a package to be shipped. It also includes attributes which
are set after a shipment has been created (label, cost, tracking_id)

=cut

use Data::Currency;

use Moose 2.0000;

=head1 Class Attributes

=head2 id

The package type id as defined by a shipping service

type: String

=cut

has 'id' => (
  is => 'rw',
  isa => 'Str',
);

=head2 type

The package type as defined by a shipping service (i.e. "envelope")

type: String

=cut

has 'type' => (
  is => 'rw',
  isa => 'Str',
);

=head2 name

A descriptive name for the package (i.e. "12x12x12 box")

type: String

=cut

has 'name' => (
  is => 'rw',
  isa => 'Str',
);

=head2 notes

Notes (i.e. to describe the package contents)

type: String

=cut

has 'notes' => (
  is => 'rw',
  isa => 'Str',
);

=head2 fragile

Whether or not the items being sent are fragile

=cut

has 'fragile' => (
  is => 'rw',
  isa => 'Bool',
  default => 0,
);

=head2 weight

The weight of the package. Units are determined by the Shipment::Base class

type: Number

=cut

has 'weight' => (
  is => 'rw',
  isa => 'Num',
);

=head2 length, width, height

The dimensions of the package. Units are determined by the Shipment::Base class

type: Number

=cut

has 'length' => (
  is => 'rw',
  isa => 'Num',
);

has 'width' => (
  is => 'rw',
  isa => 'Num',
);

has 'height' => (
  is => 'rw',
  isa => 'Num',
);

=head2 insured_value

The value of the contents to be insured

type: Data::Currency

=cut

has 'insured_value' => (
  is => 'rw',
  isa => 'Data::Currency',
  default => sub { Data::Currency->new(0) }, 
);

=head2 goods_value

The value of the contents

type: Data::Currency

=cut

has 'goods_value' => (
  is => 'rw',
  isa => 'Data::Currency',
  lazy => 1,
  default => sub {
    my $self = shift;
    return $self->insured_value;
  },
);

=head2 label

The shipping label. Set by a Shipment::Base class

type: Shipment::Label

=cut

has 'label' => (
  is => 'rw',
  isa => 'Shipment::Label',
);

=head2 tracking_id

The tracking id. Set by a Shipment::Base class. 

Also can be used to define a tracking id to cancel or track.

type: String

=cut

has 'tracking_id' => (
  is => 'rw',
  isa => 'Str',
);

=head2 cost

The cost to ship this package. Set by a Shipment::Base class

type: Data::Currency

=cut

has 'cost' => (
  is => 'rw',
  isa => 'Data::Currency',
  default => sub { Data::Currency->new(0) },
);

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
