#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 7;


my $username    = $ENV{'UPS_USERNAME'};
my $password = $ENV{'UPS_PASSWORD'};
my $key      = $ENV{'UPS_KEY'};
my $account  = $ENV{'UPS_ACCOUNT'};

SKIP: {
  skip "Tests can only be run with a valid UPS Developer Username/Password/Key and Account. The following environment variables are used: UPS_USERNAME UPS_PASSWORD UPS_KEY UPS_ACCOUNT. You can sign up for a UPS Web Services developer account at https://www.ups.com/upsdeveloperkit", 7 unless $username && $password && $key && $account;
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
  address1 => '1604 Bay Oaks Dr',
  city => 'Albert Lea',
  state => 'MN',
  country => 'US',
  zip => '56007',
  phone => '4032040907',
  email => 'baerg@yoursole.com',
);

my @packages = (
  Shipment::Package->new(
    weight => 2.8,
    length => 12,
    width => 10,
    height => 17,
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
  references => [ 'foo', 'bar' ],
  residential_address => 1,
  surepost => 1,
);


ok( defined $shipment->services->{surepost}, 'got a surepost service');
is( $shipment->services->{surepost}->id, '93', 'surepost service_id') if defined $shipment->services->{surepost};

$shipment->rate( 'surepost' );

ok( defined $shipment->service, 'got a surepost rate');
is( $shipment->service->cost->code, 'USD', 'currency') if defined $shipment->service;
#warn $shipment->service->cost->value;

$shipment->ship( 'surepost' );

ok( defined $shipment->get_package(0)->label, 'got label' );
is( $shipment->get_package(0)->label->content_type, 'text/ups-epl', 'label is epl') if defined $shipment->get_package(0)->label;

$to = Shipment::Address->new(
  name => 'Foo Bar',
  address1 => 'PSC 42 Box 107',
  city => 'APO',
  state => 'AA',
  country => 'US',
  zip => '34042',
  phone => '4032040907',
  email => 'baerg@yoursole.com',
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
  references => [ 'foo', 'bar' ],
  residential_address => 1,
  surepost => 1,
);

$shipment->rate( 'surepost' );
is( $shipment->error, '', 'no errors getting surepost rate for military');

}
