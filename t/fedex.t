#!/usr/bin/env perl
use strict;
use warnings;

my ($key, $password, $account, $meter) = @ARGV;

$key      ||= $ENV{'FEDEX_KEY'};
$password ||= $ENV{'FEDEX_PASSWORD'};
$account  ||= $ENV{'FEDEX_ACCOUNT'};
$meter    ||= $ENV{'FEDEX_METER'};

use Test::More tests => 43;

SKIP: {
  skip "Tests can only be run with a valid FedEx Developer Key/Password and Account/Meter. The following environment variables are used: FEDEX_KEY FEDEX_PASSWORD FEDEX_ACCOUNT FEDEX_METER You can sign up for a FedEx Web Services developer account at https://www.fedex.com/wpor/web/jsp/drclinks.jsp?links=techresources/index.html", 43 unless $key && $password && $account && $meter;
}

if ($key && $password && $account && $meter) {

use Shipment::FedEx;
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

my $shipment = Shipment::FedEx->new(
  key => $key,
  password => $password,
  account => $account,
  meter => $meter,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
  references => [ qw( foo bar baz ) ],
  bill_type => 'collect',
  residential_address => 1,
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
ok( defined $shipment->services->{ground}, 'got a ground service');
is( $shipment->services->{ground}->id, 'GROUND_HOME_DELIVERY', 'ground service_id') if defined $shipment->services->{ground};
ok( defined $shipment->services->{express}, 'got an express service');
is( $shipment->services->{express}->id, 'FEDEX_2_DAY', 'express service_id') if defined $shipment->services->{express};
ok( defined $shipment->services->{priority}, 'got a priority service');
is( $shipment->services->{priority}->id, 'PRIORITY_OVERNIGHT', 'priority service_id') if defined $shipment->services->{priority};

$shipment->rate( 'ground' );

ok( defined $shipment->service, 'got a ground rate');
my $rate = $shipment->service->cost->value if defined $shipment->service;
is( $shipment->service->cost->code, 'USD', 'currency') if defined $shipment->service;

$shipment = Shipment::FedEx->new(
  key => $key,
  password => $password,
  account => $account,
  meter => $meter,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
  references => [ qw( foo bar baz ) ],
  bill_type => 'collect',
);

$shipment->ship( 'ground' );

ok( defined $shipment->service, 'got a shipment');
is( $shipment->service->cost->value, '0', 'zero rating for collect') if defined $shipment->service;
ok( defined $shipment->get_package(0)->label, 'got label' );
is( $shipment->get_package(0)->label->content_type, 'text/fedex-epl', 'label is thermal') if defined $shipment->get_package(0)->label;

## TODO test saving file to disk
#$shipment->get_package(0)->label->save;

$shipment->end_of_day;
ok( defined $shipment->manifest, 'got end of day manifest' );
## TODO test saving file to disk
#$shipment->manifest->save;

is( $shipment->cancel, 'SUCCESS', 'successfully cancelled shipment');

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

$shipment = Shipment::FedEx->new(
  key => $key,
  password => $password,
  account => $account,
  meter => $meter,
  from_address => $from,
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

$shipment = Shipment::FedEx->new(
  key => $key,
  password => $password,
  account => $account,
  meter => $meter,
  from_address => $from,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
);

$shipment->ship( 'express' );

ok( defined $shipment->service, 'got a shipment');
ok( defined $shipment->get_package(0)->label, 'got first label' );
ok( defined $shipment->get_package(1)->label, 'got second label' );
is( $shipment->get_package(0)->label->content_type, 'text/fedex-epl', 'first label is thermal') if defined $shipment->get_package(0)->label;
is( $shipment->get_package(1)->label->content_type, 'text/fedex-epl', 'second label is thermal') if defined $shipment->get_package(1)->label;

is( $shipment->cancel, 'SUCCESS', 'successfully cancelled shipment');

## TODO test saving file to disk
#$shipment->get_package(0)->label->save;
#$shipment->get_package(1)->label->save;

}
