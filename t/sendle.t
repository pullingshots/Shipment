#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

my $user      ||= $ENV{'SENDLE_USER'};
my $api_key ||= $ENV{'SENDLE_API_KEY'};

SKIP: {
  skip "Tests can only be run with a valid Developer User and API Key. The following environment variables are used: SENDLE_USER, SENDLE_API_KEY. You can sign up for a Sendle developer account at https://sandbox.sendle.com", 8 unless $user && $api_key;
}

if ($user && $api_key) {

use Shipment::Sendle;
use Shipment::Address;
use Shipment::Package;

my $from = Shipment::Address->new( 
  name => 'Andrew Baerg',
  company => 'Foo Bar',
  address1 => '67 Coventry View NE #14',
  city => 'Salt Lake City',
  state => 'Utah',
  country => 'United States',
  zip => '84114',
  phone => '14032261851',
);

my $to = Shipment::Address->new(
  name => 'Foo Bar',
  company => 'Company',
  address1 => '123 Any Street NW',
  address2 => '#2',
  city => 'Beverly Hills',
  state => 'CA',
  country => 'US',
  zip => '90210',
  phone => '(403)669-8017 ext. 123',
  email => 'baerg@yoursole.com',
);

my @packages = (
  Shipment::Package->new(
    notes => 'stuff',
    weight => 1,
    length => 9,
    width => 12,
    height => 2,
  ),
);

my $shipment = Shipment::Sendle->new(
  user => $user,
  api_key => $api_key,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'cropped',
  references => [ 'foo', undef, 'bar' ],
);

ok( defined $shipment, 'got a shipment');

is( $shipment->count_packages, 1, 'shipment has 1 packages');

ok( defined $shipment->services, 'got services');
ok( defined $shipment->services->{ground}, 'got a ground service');

$shipment->rate( 'ground' );

ok( defined $shipment->service, 'got a ground rate');
my $rate = $shipment->service->cost->value if defined $shipment->service;
isnt( $rate, 0, 'ground rate greater than 0');

$shipment = Shipment::Sendle->new(
  user => $user,
  api_key => $api_key,
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'cropped',
  references => [ qw( foo bar ) ],
  special_instructions => 'leave at back door',
);

$shipment->ship( 'ground' );

ok( defined $shipment->service, 'got a ground shipment' );
is( $shipment->service->cost->value, $rate, 'rate matches actual cost') if defined $shipment->service;

is( $shipment->track(), 'Drop Off', 'tracking status' );


}

done_testing;
