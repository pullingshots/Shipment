#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 39;

my ($username, $password, $key, $account) = @ARGV;

$username    ||= $ENV{'UPS_USERNAME'};
$password ||= $ENV{'UPS_PASSWORD'};
$key      ||= $ENV{'UPS_KEY'};
$account  ||= $ENV{'UPS_ACCOUNT'};

SKIP: {
  skip "Tests can only be run with a valid UPS Developer Username/Password/Key and Account. The following environment variables are used: UPS_USERNAME UPS_PASSWORD UPS_KEY UPS_ACCOUNT. You can sign up for a UPS Web Services developer account at https://www.ups.com/upsdeveloperkit", 39 unless $username && $password && $key && $account;
}

if ($username && $password && $key && $account) {

use Shipment::UPS;
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

my $shipment = Shipment::UPS->new(
  username => $username,
  password => $password,
  key => $key,
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
  is( $shipment->from_address->province_code, 'MT', 'province_code');
  is( $shipment->from_address->country_code, 'US', 'country_code');
  is( $shipment->from_address->address_components->{number}, '608', 'address_components->{number}');
  is( $shipment->from_address->address_components->{street}, 'CRESCENT CIRCLE', 'address_components->{street}');
  is( $shipment->from_address->phone_components->{country}, '1', 'phone_components->{country}');
  is( $shipment->from_address->phone_components->{area}, '403', 'phone_components->{area}');
  is( $shipment->from_address->phone_components->{phone}, '2040907', 'phone_components->{phone}');
}

ok( defined $shipment->to_address, 'got a shipment->to_address address' );
if (defined $shipment->to_address) {
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
ok( defined $shipment->services->{ground}, 'got a ground service');
is( $shipment->services->{ground}->id, '03', 'ground service_id') if defined $shipment->services->{ground};
ok( defined $shipment->services->{express}, 'got an express service');
is( $shipment->services->{express}->id, '02', 'express service_id') if defined $shipment->services->{express};
ok( defined $shipment->services->{priority}, 'got a priority service');
is( $shipment->services->{priority}->id, '01', 'priority service_id') if defined $shipment->services->{priority};

$shipment->rate( 'ground' );

ok( defined $shipment->service, 'got a ground rate');
my $rate = $shipment->service->cost->value if defined $shipment->service;
is( $shipment->service->cost->code, 'USD', 'currency') if defined $shipment->service;

$shipment->ship( 'ground' );

#is( $shipment->service->cost->value, $rate, 'rate matches actual cost') if defined $shipment->service;
ok( defined $shipment->get_package(0)->label, 'got label' );
is( $shipment->get_package(0)->label->content_type, 'text/ups-epl', 'label is epl') if defined $shipment->get_package(0)->label;

## TODO test saving file to disk
#$shipment->get_package(0)->label->save;

  $shipment = Shipment::UPS->new(
    username => $username,
    password => $password,
    key => $key,
    account => $account,
    tracking_id => '1ZISDE016691676846',
  );

  is( $shipment->cancel, 'Voided', 'successfully cancelled shipment');

@packages = (
  Shipment::Package->new(
    weight => 10,
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

$shipment = Shipment::UPS->new(
  username => $username,
  password => $password,
  key => $key,
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
is( $shipment->service->cost->code, 'USD', 'currency') if defined $shipment->service;

$shipment->ship( 'express' );

#is( $shipment->service->cost->value, $rate, 'rate matches actual cost') if defined $shipment->service;
ok( defined $shipment->get_package(0)->label, 'got first label' );
ok( defined $shipment->get_package(1)->label, 'got second label' );
is( $shipment->get_package(0)->label->content_type, 'text/ups-epl', 'first label is epl') if defined $shipment->get_package(0)->label;
is( $shipment->get_package(1)->label->content_type, 'text/ups-epl', 'second label is epl') if defined $shipment->get_package(1)->label;

## TODO test saving file to disk
#$shipment->get_package(0)->label->save;
#$shipment->get_package(1)->label->save;

  $shipment = Shipment::UPS->new(
    username => $username,
    password => $password,
    key => $key,
    account => $account,
    tracking_id => '1ZISDE016691609089',
    packages => [ 
      Shipment::Package->new(
        tracking_id => '1ZISDE016694068891',
      ),
      Shipment::Package->new(
        tracking_id => '1ZISDE016690889305',
      ),
    ],
  );

  is( $shipment->cancel, 'Voided', 'successfully cancelled shipment');

}
