package Shipment::Address;
use strict;
use warnings;

=head1 NAME

Shipment::Address - a shipping address

=head1 SYNOPSIS

  use Shipment::Address;

  my $address = Shipment::Address->new(
    name        => 'Foo Bar',
    address1    => '123 Any Street NW',
    city        => 'Calgary',
    province    => 'Alberta',
    postal_code => 'T1A1A1',
    country     => 'Canada',
    phone       => '12345678',
  );

  print $address->province_code . "\n"; ## AB
  print $address->country_code . "\n"; ## CA
  print $address->address_components->{direction} . "\n"; ## NW
  print $address->phone_components->{area} . "\n"; ## 234
  
=head1 ABOUT

This class defines a shipping address and provides some methods for parsing the address

=cut

use Moose;
use MooseX::Aliases;

=head1 Class Attributes

=head2 name

The contact name

type: String

alias: contact

=cut

has 'name' => (
  is => 'rw',
  isa => 'Str',
  alias => 'contact',
);

=head2 company

The company name

type: String

default: n/a

=cut

has 'company' => (
  is => 'rw',
  isa => 'Str',
  default => 'n/a',
);

=head2 address1, address2, address3

The street address lines

type: String

=cut

has 'address1' => (
  is => 'rw',
  isa => 'Str',
);

has 'address2' => (
  is => 'rw',
  isa => 'Str',
);

has 'address3' => (
  is => 'rw',
  isa => 'Str',
);

=head2 city

The city name

type: String

alias: town

=cut

has 'city' => (
  is => 'rw',
  isa => 'Str',
  alias => 'town',
);

=head2 province

The state/province name or code. Whether a name or code is given, 
the province_code attribute can be used to obtain the code.

type: String

alias: state

=cut

has 'province' => (
  is => 'rw',
  isa => 'Str',
  alias => 'state',
);

=head2 province_code

READONLY access to the province code based on the province attribute.

=cut

has 'province_code' => (
  is => 'ro',
  isa => 'Str',
  alias => 'state_code',
  lazy => 1,
  default => sub {
    my $self = shift;

    use Locale::SubCountry;
    my $country = new Locale::SubCountry($self->country_code);

    return ($country->code($self->province) eq 'unknown') ? $self->province : $country->code($self->province);
  },
);

=head2 postal_code

The postal code/zip

type: String

alias: zip

=cut

has 'postal_code' => (
  is => 'rw',
  isa => 'Str',
  alias => 'zip',
);

=head2 country

The country name/code. Whether a name or code is given,
the country_code attribute can be used to obtain the code

type: String

=cut

has 'country' => (
  is => 'rw',
  isa => 'Str',
);

=head2 country_code

READONLY access to the country code based on the country attribute

=cut

has 'country_code' => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my $self = shift;
    use Locale::SubCountry;
    my $country = new Locale::SubCountry($self->country);

    return $country->country_code;
  },
);

=head2 address_components

READONLY access to the address components (street, direction, number)

=cut

has 'address_components' => (
  is => 'ro',
  isa => 'HashRef[Str]',
  lazy => 1,
  builder => '_build_address_components',
);

sub _build_address_components { 
    my $self = shift;

    my %components;
    $components{street} = uc($self->address1);

    $components{street} =~ s/\b(N|E|S|W|NE|NW|SE|SW|SO|NO|O)\b//;
    $components{direction} = $1 if $1;
    $components{street} =~ s/^(\d+)//;
    $components{number} = $1 if $1;
    $components{street} =~ s/(^\s+|\s+$)//g;

    \%components;
}

=head2 phone

The phone number. The following regex is used to parse out 
the country code, area code, and phone part:

  ($country, $junk, $area, $junk, $phone) = ($self->phone =~/^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$/);

type: String

=cut

has 'phone' => (
  is => 'rw',
  isa => 'Str',
  default => "",
);

=head2 phone_components

READONLY access to the phone components (country, area, phone)

=cut

has 'phone_components' => (
  is => 'ro',
  isa => 'HashRef[Str]',
  lazy => 1,
  builder => '_build_phone_components',
);

sub _build_phone_components {
  my $self = shift;

  my %components;

  my @parts = ($self->phone =~ /^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$/);

  $components{country} = $parts[0] || "1";
  $components{area} = $parts[2];
  $components{phone} = $parts[4] || $self->phone;
  
  \%components;
}

=head2 email

The email address

type: String

=cut

has 'email' => (
  is => 'rw',
  isa => 'Str',
  default => "",
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
