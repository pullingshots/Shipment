#!/usr/bin/env perl
use strict;
use warnings;

use Shipment::FedEx;
use Shipment::Address;
use Shipment::Package;

my ($key, $password, $account, $meter ) = @ARGV;

if (!$key || !$password || !$account || !$meter) {
  die "ERROR: script can only be run with a valid FedEx Developer Key/Password and Account/Meter.\n";
}

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
    weight => 10,
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
);

  foreach my $service ( $shipment->all_services ) {
    print $service->id . "\n";
  }

$shipment->ship( 'ground' );
$shipment->get_package(0)->label->save;
$shipment->cancel;

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

$shipment->ship( 'ground' );
$shipment->get_package(0)->label->save;
$shipment->get_package(1)->label->save;
$shipment->cancel;
