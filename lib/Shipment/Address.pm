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

use Moo;
use MooX::Aliases;
use MooX::Types::MooseLike::Base qw(:all);
use namespace::clean;

=head1 Class Attributes

=head2 name

The contact name

type: String

alias: contact

=cut

has 'name' => (
  is => 'rw',
  isa => Str,
  alias => 'contact',
  default => '',
);

=head2 company

The company name

type: String

default: n/a

=cut

has 'company' => (
  is => 'rw',
  isa => Str,
  default => 'n/a',
);

=head2 address_type

Whether the address is residential or business

=cut

has 'address_type' => (
  is => 'rw',
  isa => Enum[ qw/residential business/ ],
  default => 'business',
);

=head2 address1, address2, address3

The street address lines

type: String

=cut

has 'address1' => (
  is => 'rw',
  isa => Str,
  default => '',
);

has 'address2' => (
  is => 'rw',
  isa => Str,
  default => '',
);

has 'address3' => (
  is => 'rw',
  isa => Str,
  default => '',
);

=head2 city

The city name

type: String

alias: town

=cut

has 'city' => (
  is => 'rw',
  isa => Str,
  alias => 'town',
  default => '',
);

=head2 province

The state/province name or code. Whether a name or code is given, 
the province_code attribute can be used to obtain the code.

type: String

alias: state

=cut

has 'province' => (
  is => 'rw',
  isa => Str,
  alias => 'state',
  default => '',
);

=head2 province_code

READONLY access to the province code based on the province attribute.

=cut

has 'province_code' => (
  is => 'lazy',
  isa => Str,
  alias => 'state_code',
);

sub _build_province_code {
    my $self = shift;

    return '' unless ($self->province && $self->country);

    use Locale::SubCountry;
    my $country = Locale::SubCountry->new($self->country_code);

    return ($country->code($self->province) eq 'unknown') ? $self->province : $country->code($self->province) if $country;
    return $self->province;
}

=head2 postal_code

The postal code/zip

type: String

alias: zip

=cut

has 'postal_code' => (
  is => 'rw',
  isa => Str,
  alias => 'zip',
  default => '',
);

=head2 country

The country name/code. Whether a name or code is given,
the country_code attribute can be used to obtain the code

type: String

=cut

has 'country' => (
  is => 'rw',
  isa => Str,
  default => '',
);

=head2 country_code

READONLY access to the country code based on the country attribute

=cut

has 'country_code' => (
  is => 'lazy',
);

sub _build_country_code {
    my $self = shift;

    return '' unless $self->country;

    use Locale::SubCountry;
    my $country = Locale::SubCountry->new($self->country);

    return $country->country_code if $country;
    return $self->country;
}

=head2 address_components

READONLY access to the address components (street, direction, number)

=cut

has 'address_components' => (
  is => 'lazy',
  isa => HashRef[Str],
);

sub _build_address_components { 
    my $self = shift;

    my %components;
    $components{street} = uc($self->address1);

    $components{direction} = ($components{street} =~ s/\b(N|E|S|W|NE|NW|SE|SW|SO|NO|O)\b//) ? $1 : '';
    $components{number} = ($components{street} =~ s/^(\d+)//) ? $1 : '';
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
  isa => Str,
  default => "",
);

=head2 phone_components

READONLY access to the phone components (country, area, phone)

=cut

has 'phone_components' => (
  is => 'lazy',
  isa => HashRef[Str],
);

sub _build_phone_components {
  my $self = shift;

  my %components;

  my $phone = $self->phone;
  $phone =~ s/[\sa-zA-Z]+.+$//;
  $phone =~ s/\s//g;

  my @parts = ($phone =~ /^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$/);

  $components{country} = $parts[0] || "1";
  $components{area} = $parts[2] || "";
  $components{area} =~ s/\D//g;
  $components{phone} = $parts[4] || $phone || "";
  $components{phone} =~ s/\D//g;
  
  \%components;
}

=head2 email

The email address

type: String

=cut

has 'email' => (
  is => 'rw',
  isa => Str,
  default => "",
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
