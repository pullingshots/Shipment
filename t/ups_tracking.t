#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

my ($username, $password, $key, $account, $account_third_party) = @ARGV;

$username    ||= $ENV{'UPS_USERNAME'};
$password ||= $ENV{'UPS_PASSWORD'};
$key      ||= $ENV{'UPS_KEY'};
$account  ||= $ENV{'UPS_ACCOUNT'};
$account_third_party ||= $ENV{'UPS_ACCOUNT_THIRD_PARTY'};

SKIP: {
  skip "Tests can only be run with a valid UPS Developer Username/Password/Key and Account. The following environment variables are used: UPS_USERNAME UPS_PASSWORD UPS_KEY UPS_ACCOUNT UPS_ACCOUNT_THIRD_PARTY. You can sign up for a UPS Web Services developer account at https://www.ups.com/upsdeveloperkit" unless $username && $password && $key && $account;
}

if ($username && $password && $key && $account) {

use Shipment::UPS;

my $shipment = Shipment::UPS->new(
  username => $username,
  password => $password,
  key => $key,
  account => $account,
);

ok( defined $shipment, 'got a shipment');

$shipment->track();

is( $shipment->error, 'no tracking id provided', 'error when no tracking id set' );

$shipment = Shipment::UPS->new(
  username => $username,
  password => $password,
  key => $key,
  account => $account,
  tracking_id => '1Z12345E0205271689',
);

$shipment->track();

is( $shipment->error, '151018 - Invalid tracking number', 'error when invalid tracking id set' );

$shipment = Shipment::UPS->new(
  username => $username,
  password => $password,
  key => $key,
  account => $account,
  tracking_id => '1Z12345E0205271688',
);

$shipment->track();

ok( defined $shipment->status, 'Got a status' );

if (defined $shipment->status) {
  is( $shipment->status->description, 'DELIVERED', 'status description' );
  is( $shipment->status->date, '1999-06-10T12:00:00', 'status date' );
  is( $shipment->status->location->city, 'ANYTOWN', 'status location city' );
  is( $shipment->status->location->state, 'GA', 'status location state' );
  is( $shipment->status->location->country, 'US', 'status location country' );
}

is( $shipment->ship_date, '1999-06-08T00:00:00', 'creation date' );

is( $shipment->count_activities, 2, '2 tracking activities');
is( $shipment->activities->[1]->description, 'BILLING INFORMATION RECEIVED. SHIPMENT DATE PENDING.', 'oldest tracking activity');

}

done_testing;
