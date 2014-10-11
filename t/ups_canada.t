#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 8;


my $username    = $ENV{'UPS_USERNAME'};
my $password = $ENV{'UPS_PASSWORD'};
my $key      = $ENV{'UPS_KEY'};
my $account  = $ENV{'UPS_ACCOUNT'};

SKIP: {
  skip "Tests can only be run with a valid UPS Developer Username/Password/Key and Account. The following environment variables are used: UPS_USERNAME UPS_PASSWORD UPS_KEY UPS_ACCOUNT. You can sign up for a UPS Web Services developer account at https://www.ups.com/upsdeveloperkit", 8 unless $username && $password && $key && $account;
}

if ($username && $password && $key && $account) {

use Shipment::UPS;
use Shipment::Address;
use Shipment::Package;

my $from = Shipment::Address->new( 
  name => 'Andrew Baerg',
  company => 'Edge Marketing Corp.',
  address1 => '#33, 5342 - 72 Ave SE',
  city => 'Calgary',
  state => 'AB',
  country => 'CA',
  zip => 'T2C4X5',
  phone => '14032040907',
);

my $to = Shipment::Address->new(
  name => 'Foo Bar',
  address1 => '300 - 145 West 15th St.',
  city => 'North Vancouver',
  state => 'BC',
  country => 'CA',
  zip => 'V7M1R9',
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
  references => [ 'foo', 'bar' ],
  residential_address => 1,
  currency => 'CAD',
);

ok( defined $shipment->services->{13}, 'got an express saver service');
is( $shipment->services->{13}->id, '13', 'express saver service_id') if defined $shipment->services->{13};
is( $shipment->services->{13}->name, 'UPS Express Saver', 'express saver service name') if defined $shipment->services->{13};

$shipment->rate( '13' );

ok( defined $shipment->service, 'got an express saver rate');
is( $shipment->service->cost->code, 'CAD', 'currency') if defined $shipment->service;

$shipment->ship( '13' );

ok( defined $shipment->get_package(0)->label, 'got label' );
is( $shipment->get_package(0)->label->content_type, 'text/ups-epl', 'label is epl') if defined $shipment->get_package(0)->label;

$to = Shipment::Address->new(
  name => 'Foo Bar',
  address1 => '608 Crescent Circle',
  city => 'Great Falls',
  state => 'MT',
  country => 'US',
  zip => '59404',
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
  currency => 'CAD',
  signature_type => 'not_required',
);

ok( defined $shipment->services->{ground}, 'got an international ground service');

}

