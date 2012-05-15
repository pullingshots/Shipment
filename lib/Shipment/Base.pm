package Shipment::Base;
use strict;
use warnings;

=head1 NAME

Shipment::Base - base class for a shipping module

=head1 SYNOPSIS

This module does not DO anything, but can be extended to create a real
interface for a shipping service.

  package Shipment::SomeShippingService;

  use Moose;

  extends 'Shipment::Base';

  sub ship {
    # routine to ship something somewhere via some shipping service
  }

  no Moose;

which can then be used to actually DO stuff:

  use Shipment::SomeShippingService;
  use Shipment::Address;
  use Shipment::Package;

  my $shipment = Shipment::SomeShippingService->new(
    from_address => Shipment::Address->new( ... ),
    to_address => Shipment::Address->new( ... ),
    packages => [ Shipment::Package->new( ... ), ],
  );

  $shipment->ship( 'ground' );

=head1 ABOUT

This is a base class for a shipping service such as UPS or FedEx.

=cut

use Data::Currency;
use Shipment::Service;
use Moose 2.0000;
use Moose::Util::TypeConstraints;
use MooseX::Types::DateTime::ButMaintained qw( DateTime );

=head1 Class Attributes

=head2 from_address, to_address

Where the shipment is being shipped from and to

type: L<Shipment::Address>

=cut

has 'from_address' => ( 
  is => 'rw',
  isa => 'Shipment::Address',
);

has 'to_address' => (
  is => 'rw',
  isa => 'Shipment::Address',
);

=head2 account

The shipper's account number

type: String

=cut

has 'account' => (
  is => 'rw',
  isa => 'Str',
);

=head2 bill_account

The billing account number

type: String

defaults to the account

=cut

has 'bill_account' => (
  is => 'rw',
  isa => 'Str', 
  default => sub { 
    my $self = shift;
    return $self->account;
  },
  lazy => 1,
);

=head2 bill_address

The billing address (typically not needed)

type:  L<Shipment::Address>

=cut

has 'bill_address' => (
  is => 'rw',
  isa => 'Shipment::Address',
);

=head2 bill_type

Who to bill for the shipment (sender, recipient, third_party)

type:  BillingOptions

default: sender

=cut

enum 'BillingOptions' => qw( sender recipient third_party );

has 'bill_type' => (
  is => 'rw',
  isa => 'BillingOptions',
  default => 'sender',
);

=head2 pickup_type

Whether the shipment will be picked up or dropped off (most shipping services have multiple pickup options)

type:  PickupOptions

default: pickup
 
=cut

enum 'PickupOptions' => qw( pickup dropoff );

has 'pickup_type' => (
  is => 'rw',
  isa => 'PickupOptions',
  default => 'pickup'
);

=head2 printer_type

Defines the kind of label that will be generated (pdf, thermal, image)

type:  PrinterOptions

default: pdf

=cut

enum 'PrinterOptions' => qw( pdf thermal image );

has 'printer_type' => (
  is => 'rw',
  isa => 'Str',
  default => 'pdf',
);

=head2 signature_type

Whether a signature confirmation is required, and what type (default, required, not_required, adult)

type:  SignatureOptions

default: default (the default setting for the chosen service)

=cut

enum 'SignatureOptions' => qw( default required not_required adult );

has 'signature_type' => (
  is => 'rw',
  isa => 'SignatureOptions',
  default => 'default',
);

=head2 package_type

The type of packaging used (custom, envelope, tube, box, pack)

type: PackageOptions

default: custom

=cut

enum 'PackageOptions' => qw( custom envelope tube box pack );

has 'package_type' => (
  is => 'rw',
  isa => 'PackageOptions',
  default => 'custom',
);

=head2 packages

The list of individual packages being shipped

type: ArrayRef[L<Shipment::Package>]

methods handled: 
  all_packages  # returns a list of Shipment::Package
  get_package(index)  # returns a Shipment::Package
  add_package(Shipment::Package)
  count_packages # returns the number of packages

=cut

has 'packages' => (
  traits => ['Array'],
  is => 'rw',
  isa => 'ArrayRef[Shipment::Package]',
  default => sub { [] },
  handles => {
    all_packages => 'elements',
    get_package  => 'get',
    add_package  => 'push',
    count_packages => 'count',
  },
);

=head2 weight_unit, dim_unit

What units we're dealing with for weight and dimensions (lb, kg and in, cm)

default: lb, in (pounds and inches)

=cut

has 'weight_unit' => (
  is => 'rw',
  isa => enum( [ qw( lb kg ) ] ),
  default => 'lb',
);

has 'dim_unit' => (
  is => 'rw',
  isa => enum( [ qw( in cm ) ] ),
  default => 'in',
);

=head2 currency

What currency we're dealing with (USD,CAD, etc)

default: USD

=cut

has 'currency' => (
  is => 'rw',
  isa => 'Str',
  default => 'USD',
);

=head2 pickup_date

When the shipment will be ready for pickup

type: DateTime

=cut

has 'pickup_date' => (
  is => 'rw',
  isa => DateTime,
  coerce => 1,
);

=head2 services

The available services

type: HashRef[L<Shipment::Service>]

methods handled: 
  all_services # returns a list of Shipment::Service

=cut

has 'services' => (
  traits => ['Hash'],
  is => 'ro',
  isa => 'HashRef[Shipment::Service]',
  lazy => 1,
  builder => '_build_services',
  handles => {
    all_services => 'values',
  },
);

=head2 service

Details of what was returned from a call to rate

type: L<Shipment::Service>

=cut

has 'service' => (
  is => 'rw',
  isa => 'Shipment::Service',
);

=head2 tracking

Details of what was returned from a call to track

type: L<Shipment::Tracking>

=cut

has 'tracking' => (
  is => 'rw',
  isa => 'Shipment::Tracking',
);

=head2 tracking_id

The tracking_id returned from a call to ship
OR the tracking_id to be used in a call to track

type: String

=cut

has 'tracking_id' => (
  is => 'rw',
  isa => 'Str',
);

=head2 documents

All documents for a shipment including all labels

type: L<Shipment::Label>

=cut

has 'documents' => (
  is => 'rw',
  isa => 'Shipment::Label',
);

=head2 manifest

The manifest document (usually generated by an end of day close, but may also be generated on a per shipment basis)

type: L<Shipment::Label>

=cut

has 'manifest' => (
  is => 'rw',
  isa => 'Shipment::Label',
);

=head2 error

The last error generated by a method. Should only be non-empty if a method was unsuccessful.

type: String

=cut

has 'error' => (
  is => 'rw',
  isa => 'Str',
);

=head2 notice

The last warning/alert/notice generated by a method.

type: String

=cut

has 'notice' => (
  traits  => ['String'],
  is => 'rw',
  isa => 'Str',
  default => q{},
  handles => {
    add_notice  => 'append',
  },
);

=head2 references

The references for the shipment

type: ArrayRef[String]

methods handled: 
  all_references  
  get_reference(index)  
  add_reference($reference)
  count_references # returns the number of reference strings

=cut

has 'references' => (
  traits => ['Array'],
  is => 'rw',
  isa => 'ArrayRef[Str]',
  default => sub { [] },
  handles => {
    all_references => 'elements',
    get_reference  => 'get',
    add_reference  => 'push',
    count_references => 'count',
  },
);

=head2 special_instructions

Special Delivery Instructions

type: String

=cut

has 'special_instructions' => (
  is => 'rw',
  isa => 'Str',
);

=head2 carbon_offset

If available, add a carbon offset charge for the shipment

type: Bool

=cut

has 'carbon_offset' => (
  is => 'rw',
  isa => 'Bool',
  default => 0,
);

=head2 customer_ref

Something to reference your customer by ( customer id, order id, name, etc )
Used in tracking

type: String

=cut

has 'customer_ref' => (
  is => 'rw',
  isa => 'Str',
  default => '',
);

=head1 Class Methods

=head2 _build_services

The routine which compiles a list of available shipping services for from and to addresses.

  foreach my $service ( $shipment->all_services ) {
    print $service->name . "\n";
  }

Standard services - ground, express, priority - can be mapped to actual service id's

  print $shipment->services->{ground}->id . "\n";

=cut

sub _build_services {
  warn "routine '_build_services' has not been implemented";
  { 
    ground => 
      Shipment::Service->new(
        id => 'ground',
        name => 'Example Ground Service',
        etd => 4, ## Estimated Transit Days
        cost => Data::Currency->new(1),
      ),
    express => 
      Shipment::Service->new(
        id => 'express',
        name => 'Example Express Service',
        etd => 2, ## Estimated Transit Days
        cost => Data::Currency->new(10),
      ),
    priority => 
      Shipment::Service->new(
        id => 'priority',
        name => 'Example Priority Service',
        etd => 1, ## Estimated Transit Days
        cost => Data::Currency->new(100),
      ),
  }
}

=head2 rate

The routine that fetches a detailed rate for a given service type

  $shipment->rate( 'ground' );
  print $shipment->service->cost . "\n";
  print $shipment->service->etd . "\n";

=cut

sub rate {
  my ( $self, $service_id ) = @_;

  warn "routine 'rate' is not implemented for $self";
}

=head2 ship

The routine that creates a shipment/label

  $shipment->ship( 'ground' );
  $shipment->get_package(0)->label->save;

=cut

sub ship {
  my ( $self, $service_id ) = @_;

  warn "routine 'ship' is not implemented for $self";
}

=head2 return

The routine that creates a return shipment

  $shipment->return( 'ground' );

=cut

sub return {
  my ( $self, $service_id ) = @_;

  warn "routine 'return' is not implemented for $self";
}

=head2 cancel

The routine that cancels a shipment

  $shipment->tracking_id( '12345' );
  $shipment->cancel;

=cut

sub cancel {
  my ( $self, $service_id ) = @_;

  warn "routine 'cancel' is not implemented for $self";
}

=head2 end_of_day

The routine that runs end of day close

  $shipment->end_of_day;

=cut

sub end_of_day {
  my ( $self, $service_id ) = @_;

  warn "routine 'end_of_day' is not implemented for $self";
}

=head2 track

The routine that fetches tracking information

  $shipment->tracking_id( '12345' );
  $shipment->track;

=cut

sub track {
  my $self = shift;

  warn "routine 'track' is not implemented for $self";
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
