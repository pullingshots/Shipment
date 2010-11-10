#!/usr/bin/env perl

use Shipment::UPS;
use Shipment::Address;
use Shipment::Package;
use Data::Currency;

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
);

my @packages = (
  Shipment::Package->new(
    weight => 10,
    length => 18,
    width => 18,
    height => 24,
    insured_value => Data::Currency->new(1000),
  ),
);

my $shipment = Shipment::UPS->new(
  account => '79E10V',
  from_address => $from,
  to_address => $to,
  packages => \@packages,
  printer_type => 'thermal',
);

$shipment->ship( 'ground' );
$shipment->get_package(0)->label->save;
$shipment->control_log_receipt->save;
$shipment->return( 'ground' );


$shipment->to_address( 
  Shipment::Address->new(
    name => 'Foo Bar',
    address1 => '3885 Elmore Avenue',
    address2 => 'Suite 140',
    city => 'Davenport',
    state => 'IA',
    country => 'US',
    zip => '52807',
    phone => '4032040907',
  )
);

$shipment->packages( [
  Shipment::Package->new(
    weight => 10,
    length => 18,
    width => 18,
    height => 24,
  )
] );

$shipment->ship( 'ground' );
$shipment->get_package(0)->label->save;
$shipment->return( 'ground' );

$shipment->to_address( 
  Shipment::Address->new(
    name => 'Foo Bar',
    address1 => '103 NW 15th St.',
    city => 'Abilene',
    state => 'KS',
    country => 'US',
    zip => '67410',
    phone => '4032040907',
  )
);

$shipment->ship( 'express' );
$shipment->get_package(0)->label->save;
$shipment->return( 'express' );

$shipment->to_address( 
  Shipment::Address->new(
    name => 'Foo Bar',
    address1 => '12611 Montgomery Blvd. NE',
    city => 'Albuquerque',
    state => 'NM',
    country => 'US',
    zip => '87111',
    phone => '4032040907',
  )
);

$shipment->ship( 'priority' );
$shipment->get_package(0)->label->save;
$shipment->return( 'priority' );

$shipment->to_address( 
  Shipment::Address->new(
    name => 'Foo Bar',
    address1 => '805 Regal Dr. #2',
    city => 'Huntsville',
    state => 'AL',
    country => 'US',
    zip => '35801',
    phone => '4032040907',
  )
);

$shipment->ship( 'ground' );
$shipment->get_package(0)->label->save;
$shipment->return( 'ground' );

$shipment = Shipment::UPS->new(
  account => '79E10V',
  tracking_id => '1ZISDE016691676846',
);
warn $shipment->cancel;

$shipment = Shipment::UPS->new(
  account => '79E10V',
  tracking_id => '1Z2220060294314162',
  packages => [ Shipment::Package->new(
      tracking_id => '1Z2220060291994175',
    )
  ],
);
warn $shipment->cancel;

$shipment = Shipment::UPS->new(
  account => '79E10V',
  tracking_id => '1Z2220060292690189',
  packages => [ Shipment::Package->new(
      tracking_id => '1Z2220060292002190',
    )
  ],
);
warn $shipment->cancel;

$shipment = Shipment::UPS->new(
  account => '79E10V',
  tracking_id => '1Z2220060290530202',
  packages => [ Shipment::Package->new(
      tracking_id => '1Z2220060292634221',
    )
  ],
);
warn $shipment->cancel;
