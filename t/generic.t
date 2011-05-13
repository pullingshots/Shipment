#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 24;

use Shipment::Generic;
use Shipment::Address;
use Shipment::Package;

my $from = Shipment::Address->new( 
  name => 'Andrew Baerg',
  company => 'Edge Marketing Sales Inc.',
  address1 => '608 Crescent Circle',
  city => 'Great Falls',
  state => 'MT',
  country => 'US',
  zip => '59404',
  phone => '14032040907',
);

my $to = Shipment::Address->new(
  name => 'Foo Bar',
  address1 => '2436 NW Sacagawea Ln',
  address2 => 'Apt #2',
  city => 'Bend',
  state => 'OR',
  country => 'US',
  zip => '97701',
  phone => '4032040907',
  email => 'baerg@yoursole.com',
);

my @packages = (
  Shipment::Package->new(
    weight => 10.1,
    length => 18,
    width => 18,
    height => 24,
  ),
);

my $shipment = Shipment::Generic->new(
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  references => [ qw( foo bar baz ) ],
);

ok( defined $shipment, 'got a shipment');

ok( defined $shipment->from_address, 'got a shipment->from_address address' );
if (defined $shipment->from_address) {
  is( $shipment->from_address->province_code, 'MT', 'province_code');
  is( $shipment->from_address->country_code, 'US', 'country_code');
  is( $shipment->from_address->address_components->{number}, '608', 'address_components->{number}');
  is( $shipment->from_address->address_components->{street}, 'CRESCENT CIRCLE', 'address_components->{street}');
  is( $shipment->from_address->phone_components->{country}, '1', 'phone_components->{country}');
  is( $shipment->from_address->phone_components->{area}, '403', 'phone_components->{area}');
  is( $shipment->from_address->phone_components->{phone}, '2040907', 'phone_components->{phone}');
}

ok( defined $shipment->to_address, 'got a shipment->to_address address' );
if (defined $shipment->from_address) {
  is( $shipment->to_address->province_code, 'OR', 'province_code');
  is( $shipment->to_address->country_code, 'US', 'country_code');
  is( $shipment->to_address->address_components->{direction}, 'NW', 'address_components->{direction}');
  is( $shipment->to_address->address_components->{number}, '2436', 'address_components->{number}');
  is( $shipment->to_address->address_components->{street}, 'SACAGAWEA LN', 'address_components->{street}');
  is( $shipment->to_address->phone_components->{country}, '1', 'phone_components->{country}');
  is( $shipment->to_address->phone_components->{area}, '403', 'phone_components->{area}');
  is( $shipment->to_address->phone_components->{phone}, '2040907', 'phone_components->{phone}');
}

is( $shipment->count_packages, 1, 'shipment has 1 packages');

ok( defined $shipment->services, 'got services');

$shipment->rate( 'ground', 12 );

ok( defined $shipment->service, 'got a ground rate');
is( $shipment->service->cost->value, 12, 'rate') if defined $shipment->service;

$shipment = Shipment::Generic->new(
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  references => [ qw( foo bar baz ) ],
);

$shipment->ship( 'ground', '12345', 12 );

ok( defined $shipment->service, 'got a shipment');
ok( defined $shipment->get_package(0)->label, 'got label' );

## TODO test saving file to disk
#$shipment->get_package(0)->label->save;


