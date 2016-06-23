package Shipment::Label;
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

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

=head1 Class Attributes

=head2 tracking_id

The tracking id of the label

type: String

=cut

has 'tracking_id' => (
  is => 'rw',
  isa => Str,
);

=head2 data

The actual file content (must not be base64 encoded which is usually how it comes through the intertubes)

type: String

=cut

has 'data' => (
  is => 'rw',
  isa => Str,
);

=head2 content_type

The content type of the file (application/pdf, text/epl, image/gif, etc). 
Currently not used for anything in particular.

type: String

=cut

has 'content_type' => (
  is => 'rw',
  isa => Str,
);

=head2 file_name

The file name to be used when saving the file to disk

type: String

=cut

has 'file_name' => (
  is => 'rw',
  isa => Str,
);

=head1 Class Methods

=head2 data_base64

returns BASE64 encoded file content

type: String

=cut

sub data_base64 {
  my ($self) = @_;

  use MIME::Base64;

  return encode_base64($self->data) if $self->data;

  return;
}

=head2 save

  $label->save('/tmp/');

Saves the file to disk. Will save to the cwd if nothing is specified

=cut

sub save {
  my ($self, $path) = @_;

  $path ||= './';

  use File::Util;

  my $f = File::Util->new();
  $f->write_file(
    file => $path . $self->file_name,
    bitmask => 0644,
    content => $self->data,
  );
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
