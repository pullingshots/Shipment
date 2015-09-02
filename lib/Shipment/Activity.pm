package Shipment::Activity;
use strict;
use warnings;

=head1 NAME

Shipment::Activity - Used for Tracking

=cut

use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use namespace::clean;

=head1 Class Attributes

=cut

has 'status' => (
  is => 'rw',
  isa => Str,
);

has 'date' => (
  is => 'rw',
  isa => Str,
);

has 'time' => (
  is => 'rw',
  isa => Str,
);

sub set_attr {
    my ($self, $shipment, $attr, @rest) = @_;
    push @rest, 'value';
    my $set_method = lcfirst($attr);
    my $get_method = "get_$attr";
    my $val = $shipment->$get_method();

    for my $meth (@rest) {
        return unless defined $val;
        $meth = "get_$meth";
        $val = $val->$meth;
    }

    $self->$set_method($val);
}

=head1 AUTHOR

William Taylor @ <williamt@corp.sonic.net>

=head1 BUGS

Maybe?

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
