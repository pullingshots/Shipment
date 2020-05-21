#!/usr/bin/env perl
use strict;
use warnings;

my ($key, $password, $account, $meter) = @ARGV;

$key      ||= $ENV{'FEDEX_KEY'};
$password ||= $ENV{'FEDEX_PASSWORD'};
$account  ||= $ENV{'FEDEX_ACCOUNT'};
$meter    ||= $ENV{'FEDEX_METER'};

use Test::More;

SKIP: {
  skip "Tests can only be run with a valid FedEx Developer Key/Password and Account/Meter. The following environment variables are used: FEDEX_KEY FEDEX_PASSWORD FEDEX_ACCOUNT FEDEX_METER You can sign up for a FedEx Web Services developer account at https://www.fedex.com/wpor/web/jsp/drclinks.jsp?links=techresources/index.html" unless $key && $password && $account && $meter;
}

if ($key && $password && $account && $meter) {

use Shipment::FedEx;

my $shipment = Shipment::FedEx->new(
  key => $key,
  password => $password,
  account => $account,
  meter => $meter,
);

$shipment->track();

is( $shipment->error, 'no tracking id provided', 'error when no tracking id set' );

$shipment = Shipment::FedEx->new(
  key => $key,
  password => $password,
  account => $account,
  meter => $meter,
  tracking_id => '122816215025811',
);

$shipment->track();

is( $shipment->error, 'This tracking number cannot be found. Please check the number or contact the sender.', 'error when tracking id not found' );

$shipment = Shipment::FedEx->new(
  key => $key,
  password => $password,
  account => $account,
  meter => $meter,
  tracking_id => '122816215025810',
);

$shipment->track();

ok( defined $shipment->status, 'Got a status' );

if (defined $shipment->status) {
  is( $shipment->status->description, 'Delivered', 'status description' );
  is( $shipment->status->date, '2014-01-09T13:31:00', 'status date' );
  is( $shipment->status->location->city, 'Norton', 'status location city' );
  is( $shipment->status->location->state, 'VA', 'status location state' );
  is( $shipment->status->location->country, 'US', 'status location country' );
}

is( $shipment->ship_date, '2018-08-15T00:00:00', 'creation date' );

is( $shipment->count_activities, 11, '11 tracking activities');
is( $shipment->activities->[10]->description, 'Shipment information sent to FedEx', 'oldest tracking activity');

}

done_testing;

