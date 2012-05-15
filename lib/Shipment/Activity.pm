package Shipment::Activity;
use strict;
use warnings;

=head1 NAME

Shipment::Label - a shipping label/document

=head1 SYNOPSIS

  use Shipment::Label;

  my $label = Shipment::Label->new(
    data => $file_contents,
    file_name => 'label.pdf',
  );

  $label->save('/tmp/') ## writes label to disk at /tmp/label.pdf

=head1 ABOUT

This class defines a shipping label and provides a method for saving to disk.
It can also be used to store other shipping documents.

=cut

use Moose 2.0000;

=head1 Class Attributes

=cut

has 'status' => (
  is => 'rw',
  isa => 'Str',
);

has 'date' => (
  is => 'rw',
  isa => 'Str',
);

has 'time' => (
  is => 'rw',
  isa => 'Str',
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
