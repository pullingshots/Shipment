package Shipment::Service;
use strict;
use warnings;

=head1 NAME

Shipment::Service - a shipping service

=head1 SYNOPSIS

  use Shipment::Service;
  use Data::Currency;

  my $service = Shipment::Service->new(
    id => '02',
    name => 'Domestic Ground',
    cost => Data::Currency->new(10, 'USD'),
  );

=head1 ABOUT

This class defines a shipping service. It is used in a Shipment::Base class
for listing available services or storing details about a rate.

=cut

use Data::Currency;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use MooX::Types::MooseLike::DateTime qw( DateTime );
use namespace::clean;

=head1 Class Attributes

=head2 id, carrier_id

The service id and carrier id as defined by a shipping service

type: String

=cut

has 'id' => (
  is => 'rw',
  isa => Str,
);

has 'carrier_id' => (
  is => 'rw',
  isa => Str,
);

=head2 name, carrier_name, service_name

A descriptive name for the service

type: String

=cut

has 'name' => (
  is => 'rw',
  isa => Str,
);

has 'carrier_name' => (
  is => 'rw',
  isa => Str,
);

has 'service_name' => (
  is => 'rw',
  isa => Str,
);

=head2 package

The package type accepted by this service

type: Shipment::Package

=cut

has 'package' => (
  is => 'rw',
  isa => InstanceOf['Shipment::Package'],
);

=head2 etd, pickup_etd

The estimated transit days for the service

type: Number

=cut

has 'etd' => (
  is => 'rw',
  isa => Num,
);

has 'pickup_etd' => (
  is => 'rw',
  isa => Num,
);

=head2 ship_date

The shipment date

type: DateTime

=cut

has 'ship_date' => (
    is     => 'rw',
    isa    => DateTime,
    coerce => sub {
        ( blessed( $_[0] ) and ( blessed( $_[0] ) eq 'DateTime' ) )
          ? $_[0]
          : DateTime::Format::Strptime->new( pattern => '%F %T' )
          ->parse_datetime( $_[0] );
    }
);

=head2 eta

The estimated time of arrival

type: DateTime

=cut

has 'eta' => (
    is     => 'rw',
    isa    => DateTime,
    coerce => sub {
        ( blessed( $_[0] ) and ( blessed( $_[0] ) eq 'DateTime' ) )
          ? $_[0]
          : DateTime::Format::Strptime->new( pattern => '%F %T' )
          ->parse_datetime( $_[0] );
    }
);

=head2 guaranteed

Whether or not the eta is guaranteed by the carrier

type: Bool

=cut

has 'guaranteed' => (
  is => 'rw',
  isa => Bool,
  default => 0,
);

=head2 cost, base_cost, tax

The cost of the service

type: Data::Currency

=cut

has 'cost' => (
  is => 'rw',
  isa => InstanceOf['Data::Currency'],
  default => sub { Data::Currency->new(0) },
);

has 'base_cost' => (
  is => 'rw',
  isa => InstanceOf['Data::Currency'],
  default => sub { Data::Currency->new(0) },
);

has 'tax' => (
  is => 'rw',
  isa => InstanceOf['Data::Currency'],
  default => sub { Data::Currency->new(0) },
);

=head2 extra_charges, adjustments

Any extra charges and adjustments that will be applied, but are not included in the cost

type: Data::Currency

=cut

has 'extra_charges' => (
  is => 'rw',
  isa => InstanceOf['Data::Currency'],
  default => sub { Data::Currency->new(0) },
);

has 'adjustments' => (
  is => 'rw',
  isa => InstanceOf['Data::Currency'],
  default => sub { Data::Currency->new(0) },
);

=head2 options

Available options for the service (this attribute was added for Purolator)

type: HashRef[Str]

=cut

has 'options' => (
  is => 'rw',
  isa => HashRef[Str],
);

=head2 extras

Extra service charges (Insurance, Carbon Offset, etc) - this attribute was added for Temando

type: HashRef[L<Shipment::Service>]
=cut

has 'extras' => (
  is => 'rw',
  isa => HashRef[InstanceOf['Shipment::Service']],
  default => sub { {} },
);

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
