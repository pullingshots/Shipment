package Shipment::Tracking;
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

use Moo;
use MooX::Aliases;
use MooX::HandlesVia;
use MooX::Types::MooseLike::Base qw(:all);
use namespace::clean;

=head1 Class Attributes

=head2 id

The package type id as defined by a shipping service

type: String

=cut

has 'inquiryNumber' => (
  is => 'rw',
  isa => Str,
);

=head2 type

The package type as defined by a shipping service (i.e. "envelope")

type: String

=cut

has 'shipmentType' => (
  is => 'rw',
  isa => Str,
);

has 'service' => (
  is => 'rw',
  isa => Str,
);

=head2 name

A descriptive name for the package (i.e. "12x12x12 box")

type: String

=cut

has 'shipperNumber' => (
  is => 'rw',
  isa => Str,
);

=head2 notes

Notes (i.e. to describe the package contents)

type: String

=cut

has 'description' => (
  is => 'rw',
  isa => Str,
);

=head2 fragile

Whether or not the items being sent are fragile

=cut

has 'referenceNumber' => (
    handles_via => 'Array',
    is  => 'rw',
    isa => ArrayRef[],
    default => sub { [] },
    handles => {
        all_referenceNumber    => 'elements',
        get_referenceNumber    => 'get',
        add_referenceNumber    => 'push',
        count_referenceNumber  => 'count',
        sorted_referenceNumber => 'sort',
    },
);

=head2 weight

The weight of the package. Units are determined by the Shipment::Base class

type: Number

=cut

#TODO why is this here?
#has 'referenceNumberCode' => (
#  is => 'rw',
#  isa => 'Str',
#);

=head2 length, width, height

The dimensions of the package. Units are determined by the Shipment::Base class

type: Number

=cut

has 'pickupDate' => (
  is => 'rw',
  isa => Str,
);

=head2 activity 

The activity. Set by a Shipment::Base class

type: Shipment::Activity

=cut

has 'activity' => (
  handles_via => 'Array',
  is => 'rw',
  isa => ArrayRef[InstanceOf['Shipment::Activity']],
  default => sub { [] },
  handles => {
    all_activity => 'elements',
    get_activity  => 'get',
    add_activity  => 'push',
    count_activity => 'count',
    sorted_activity => 'sort',
  },

);

#TODO isa => ??
# UPS activity doesn't seem to be in order so we sort by time and date
has 'status' => (
  is => 'lazy',
);

sub _build_status {
	my $self = shift;

        my @sort = sort { $$a{time} <=> $$b{time} }  $self->all_activity;
        my @sorted = reverse sort { $$a{date} <=> $$b{date} } @sort;
	return  $sorted[0]->status;
} 
  
=head2 tracking_id

The tracking id. Set by a Shipment::Base class. 

Also can be used to define a tracking id to cancel or track.

type: String

=cut

has 'tracking_id' => (
  is => 'rw',
  isa => Str,
);


sub set_attr {
    my ($self, $shipment, $attr, @rest) = @_;
    push @rest, 'value';
    my $set_method = lcfirst($attr);
    my $get_method = "get_$attr";
    my $val = $shipment->$get_method();

    if ( $attr eq "ReferenceNumber")
    {
       return unless defined $val;

       for (@$val)
       {
           $self->add_referenceNumber( $_->get_Value->get_value ); 
       }
         
       return;
    }

    for my $meth (@rest) {
        return unless defined $val;
	$meth = "get_$meth";
        $val = $val->$meth;
    }

    $self->$set_method($val);
}

sub add_act {
    my ($self, $act) = @_;

    use Shipment::Activity;
    my $activity = Shipment::Activity->new;
       $activity->set_attr($act, "Status", "Description");
       $activity->set_attr($act, "Date");
       $activity->set_attr($act, "Time");
       $self->add_activity($activity);
}

no Moose;

=head1 AUTHOR

William Taylor @ <williamt at corp dot sonic dot net>

http://sonic.net/

=head1 BUGS

Please contact me directly.

=head1 COPYRIGHT

Copyright (C) 2012 William Taylor, All Rights Reserved

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
