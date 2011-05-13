#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 47;

my ($key, $password, $account) = @ARGV;

$key      ||= $ENV{'PUROLATOR_KEY'};
$password ||= $ENV{'PUROLATOR_PASSWORD'};
$account  ||= $ENV{'PUROLATOR_ACCOUNT'};

SKIP: {
  skip "Tests can only be run with a valid Purolator Developer Key/Password and Account. The following environment variables are used: PUROLATOR_KEY PUROLATOR_PASSWORD PUROLATOR_ACCOUNT. You can sign up for a Purolator Web Services developer account at https://eship.purolator.com", 47 unless $key && $password && $account;
}

if ($key && $password && $account) {

use Shipment::Purolator;
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

my $shipment = Shipment::Purolator->new(
  key => $key,
  password => $password,
  account => $account,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
  references => [ qw( foo bar ) ],
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
is( $shipment->services->{ground}->id, 'PurolatorGround', 'ground service_id') if defined $shipment->services->{ground};
ok( defined $shipment->services->{express}, 'got an express service');
is( $shipment->services->{express}->id, 'PurolatorExpress', 'express service_id') if defined $shipment->services->{express};
ok( defined $shipment->services->{priority}, 'got a priority service');
is( $shipment->services->{priority}->id, 'PurolatorExpress10:30AM', 'priority service_id') if defined $shipment->services->{priority};

$shipment->rate( 'ground' );

ok( defined $shipment->service, 'got a ground rate');
my $rate = $shipment->service->cost->value if defined $shipment->service;
is( $shipment->service->etd, 2, 'estimated transit days') if defined $shipment->service;

$shipment = Shipment::Purolator->new(
  key => $key,
  password => $password,
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
ok( defined $shipment->documents, 'got documents' );
is( $shipment->documents->content_type, 'application/pdf', 'documents are pdf') if defined $shipment->documents;
ok( defined $shipment->get_package(0)->cost->value, 'got cost' );
ok( defined $shipment->get_package(0)->label, 'got label' );
is( $shipment->get_package(0)->label->content_type, 'application/pdf', 'label is a pdf') if defined $shipment->get_package(0)->label;
## TODO test saving file to disk
#$shipment->documents->save;
#$shipment->get_package(0)->label->save;

is( $shipment->cancel, 'true', 'successfully cancelled shipment');

## not fully implemented yet
#$shipment->end_of_day;
#ok( defined $shipment->manifest, 'got end of day manifest' );
## TODO test saving file to disk
#$shipment->manifest->save;


@packages = (
  Shipment::Package->new(
    weight => 0.1,
    length => 18,
    width => 18,
    height => 24,
  ),
  Shipment::Package->new(
    weight => 12,
    length => 20,
    width => 20,
    height => 24,
  ),
);

##  account => '0815918',

$shipment = Shipment::Purolator->new(
  key => $key,
  password => $password,
  account => $account,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
);

is( $shipment->count_packages, 2, 'shipment has 2 packages');

$shipment->rate( 'express' );

ok( defined $shipment->service, 'got an express rate');
$rate = $shipment->service->cost->value if defined $shipment->service;
is( $shipment->service->etd, 1, 'estimated transit days') if defined $shipment->service;


$shipment = Shipment::Purolator->new(
  key => $key,
  password => $password,
  account => $account,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
);

$shipment->ship( 'express' );

is( $shipment->service->cost->value, $rate, 'rate matches actual cost') if defined $shipment->service;
ok( defined $shipment->documents, 'got documents' );
is( $shipment->documents->content_type, 'application/pdf', 'documents are pdf') if defined $shipment->documents;
ok( defined $shipment->get_package(0)->label, 'got first label' );
ok( defined $shipment->get_package(1)->label, 'got second label' );
is( $shipment->get_package(0)->label->content_type, 'application/pdf', 'first label is a pdf') if defined $shipment->get_package(0)->label;
is( $shipment->get_package(1)->label->content_type, 'application/pdf', 'second label is a pdf') if defined $shipment->get_package(1)->label;

is( $shipment->cancel, 'true', 'successfully cancelled shipment');

## TODO test saving file to disk
#$shipment->documents->save;
#$shipment->get_package(0)->label->save;
#$shipment->get_package(1)->label->save;

}
