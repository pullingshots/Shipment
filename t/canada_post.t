#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

my $username      ||= $ENV{'CANADA_POST_USERNAME'};
my $password ||= $ENV{'CANADA_POST_PASSWORD'};
my $contract_id  ||= $ENV{'CANADA_POST_CONTRACT_ID'};
my $account  ||= $ENV{'CANADA_POST_ACCOUNT'};

SKIP: {
  skip "Tests can only be run with a valid Developer Username/Password and Contract ID. The following environment variables are used: CANADA_POST_USERNAME CANADA_POST_PASSWORD CANADA_POST_CONTRACT_ID CANADA_POST_ACCOUNT. You can sign up for a Canada Post Web Services developer account at https://www.canadapost-postescanada.ca/information/app/drc/home", 47 unless $username && $password && $contract_id && $account;
}

if ($username && $password && $contract_id && $account) {

use Shipment::CanadaPost;
use Shipment::Address;
use Shipment::Package;

my $from = Shipment::Address->new( 
  name => 'Andrew Baerg',
  company => 'Foo Bar',
  address1 => '67 Coventry View NE #14',
  city => 'Calgary',
  province => 'Alberta',
  country => 'Canada',
  postal_code => 'T2A6T8',
  phone => '14032261851',
);

my $to = Shipment::Address->new(
  name => 'Foo Bar',
  company => 'Company',
  address1 => '123 Any Street NW',
  address2 => '#2',
  city => 'Burnaby',
  province => 'BC',
  country => 'CA',
  postal_code => 'V5C5A9',
  phone => '(403)669-8017 ext. 123',
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

my $shipment = Shipment::CanadaPost->new(
  username => $username,
  password => $password,
  contract_id => $contract_id,
  account => $account,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
  references => [ 'foo', undef, 'bar' ],
);

ok( defined $shipment, 'got a shipment');

ok( defined $shipment->from_address, 'got a shipment->from_address address' );
if (defined $shipment->from_address) {
  is( $shipment->from_address->province_code, 'AB', 'province_code');
  is( $shipment->from_address->country_code, 'CA', 'country_code');
  is( $shipment->from_address->address_components->{direction}, 'NE', 'address_components->{direction}');
  is( $shipment->from_address->address_components->{number}, '67', 'address_components->{number}');
  is( $shipment->from_address->address_components->{street}, 'COVENTRY VIEW  #14', 'address_components->{street}');
  is( $shipment->from_address->phone_components->{country}, '1', 'phone_components->{country}');
  is( $shipment->from_address->phone_components->{area}, '403', 'phone_components->{area}');
  is( $shipment->from_address->phone_components->{phone}, '2261851', 'phone_components->{phone}');
}

ok( defined $shipment->to_address, 'got a shipment->to_address address' );
if (defined $shipment->to_address) {
  is( $shipment->to_address->province_code, 'BC', 'province_code');
  is( $shipment->to_address->country_code, 'CA', 'country_code');
  is( $shipment->to_address->address_components->{direction}, 'NW', 'address_components->{direction}');
  is( $shipment->to_address->address_components->{number}, '123', 'address_components->{number}');
  is( $shipment->to_address->address_components->{street}, 'ANY STREET', 'address_components->{street}');
  is( $shipment->to_address->phone_components->{country}, '1', 'phone_components->{country}');
  is( $shipment->to_address->phone_components->{area}, '403', 'phone_components->{area}');
  is( $shipment->to_address->phone_components->{phone}, '6698017', 'phone_components->{phone}');
}

is( $shipment->count_packages, 1, 'shipment has 1 packages');

ok( defined $shipment->services, 'got services');
ok( defined $shipment->services->{ground}, 'got a ground service');
is( $shipment->services->{ground}->id, 'DOM.RP', 'ground service_id') if defined $shipment->services->{ground};
ok( defined $shipment->services->{express}, 'got an express service');
is( $shipment->services->{express}->id, 'DOM.XP', 'express service_id') if defined $shipment->services->{express};
ok( defined $shipment->services->{priority}, 'got a priority service');
is( $shipment->services->{priority}->id, 'DOM.PC', 'priority service_id') if defined $shipment->services->{priority};

$shipment->rate( 'ground' );

ok( defined $shipment->service, 'got a ground rate');
my $rate = $shipment->service->cost->value if defined $shipment->service;
isnt( $rate, 0, 'ground rate greater than 0');
is( $shipment->service->etd, 5, 'estimated ground transit days') if defined $shipment->service;

$shipment = Shipment::CanadaPost->new(
  username => $username,
  password => $password,
  contract_id => $contract_id,
  account => $account,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
  references => [ qw( foo bar ) ],
  special_instructions => 'leave at back door',
);

$shipment->ship( 'ground' );

is( $shipment->service->cost->value, $rate, 'rate matches actual cost') if defined $shipment->service;

$to = Shipment::Address->new(
  name => 'Foo Bar',
  company => 'Company',
  address1 => '123 Any Street NW',
  address2 => '#2',
  city => 'Burnaby',
  province => 'BC',
  country => 'RS',
  postal_code => 'V5C5A9',
  phone => '(403)669-8017 ext. 123',
  email => 'baerg@yoursole.com',
);

@packages = (
  Shipment::Package->new(
    weight => 1.1,
    length => 12,
    width => 6,
    height => 24,
  ),
);

$shipment = Shipment::CanadaPost->new(
  username => $username,
  password => $password,
  contract_id => $contract_id,
  account => $account,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
  references => [ 'foo', undef, 'bar' ],
);

ok( defined $shipment->services, 'got services for Serbia');
ok( defined $shipment->services->{ground}, 'got a ground service for Serbia');
is( $shipment->services->{ground}->id, 'INT.XP', 'ground service_id for Serbia') if defined $shipment->services->{ground};

$shipment->rate( 'ground' );
ok( defined $shipment->service, 'got a ground rate');

}

done_testing;
