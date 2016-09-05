package Shipment::Activity;
use strict;
use warnings;

=head1 NAME

Shipment::Activity - a tracking activity

=head1 SYNOPSIS

  use Shipment::Activity;

  my $activity = Shipment::Activity->new(
    status => 'Delivered',
    status_date => '2016-09-04 22:14:53'
  );

=head1 ABOUT

This class defines a shipment tracking activity. It is used in a Shipment::Base class
for storing tracking activities.

=cut

use Shipment::Address;
use Scalar::Util qw/blessed/;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use MooX::Types::MooseLike::DateTime qw( DateAndTime );
use Shipment::Base qw/coerce_datetime/;
use namespace::clean;

=head1 Class Attributes

=head2 description

The description of the activity.

type: String

=cut

has 'description' => (
  is => 'rw',
  isa => Str,
);

=head2 date

The date of the activity

type: DateAndTime

=cut

has 'date' => (
    is     => 'rw',
    isa    => DateAndTime,
    coerce => \&Shipment::Base::coerce_datetime,
);

=head2 location

The location of the activity

type: Shipment::Address

=cut

has 'location' => (
  is => 'rw',
  isa => InstanceOf['Shipment::Address'],
);

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
