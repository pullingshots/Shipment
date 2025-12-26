package Shipment::Sendle;
use strict;
use warnings;

use Shipment::Sendle::API;
use Shipment::Label;

=head1 NAME

  Shipment::Sendle - Interface to Sendle shipping API

=head1 SYNOPSIS

  use Shipment::Sendle;
  use Shipment::Address;
  use Shipment::Package;

  my $shipment = Shipment::Sendle->new(
    from_address => Shipment::Address->new( ... ),
    to_address => Shipment::Address->new( ... ),
    packages => [ Shipment::Package->new( ... ), ],
  );

  foreach my $service ( $shipment->all_services ) {
    print $service->id . " (" . $service->cost . ")\n";
  }

  $shipment->rate( 'ground' );
  print $shipment->service->cost . "\n";

  $shipment->ship( 'ground' );
  $shipment->get_package(0)->label->save;

=head1 ABOUT

  This class provides an interface to the Sendle shipping API. You must sign up for an API key in order to make use of this module.

  https://sandbox.sendle.com/users/sign_up

  It is an extension of L<Shipment::Base>.

=cut

use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use namespace::clean;
use Try::Tiny;

extends 'Shipment::Base';

=head1 Class Attributes

=head2 user, api_key

  Credentials required to access Sendle API

=cut

has 'user' => (
  is => 'rw',
  isa => Str,
);

has 'api_key' => (
  is => 'rw',
  isa => Str,
);

=head2 mode

This determines whether you will use the sandbox or live environment
  * sandbox.sendle.com (sandbox)
  * api.sendle.com (live)

=cut

has 'mode' => (
  is => 'rw',
  isa => Enum[ qw(
    sandbox
    live
  ) ],
  default => 'sandbox',
);

=head2 api

  The Shipment::Sendle::API object

=cut

has 'api' => (
  is => 'rw',
  isa => InstanceOf['Shipment::Sendle::API'],
  lazy => 1,
  default => sub {
    my $self = shift;

    my $api = Shipment::Sendle::API->new( user => $self->user, api_key => $self->api_key, mode => $self->mode );
    $api->debug(1) if $self->debug;

    $api;
  },
);

sub _api_response_error {
  my ($self, $response) = @_;

  $self->error('');

  if ($response->{error}) {
    $self->error( $response->{error} );
  }
 
  if (ref $response->{content} eq 'HASH' && $response->{content}->{error}) {
    my $error = '';
    foreach my $key (keys %{$response->{content}->{messages}}) {
      $error .= $key . ': ' . join(',', @{$response->{content}->{messages}->{$key}}) . "\n";
    }
    $self->error( $error );
  }

  return 1 if $self->error;

  return;
}

has '+printer_type' => (
  isa => Enum[qw( letter cropped )],
  default => 'letter',
);

=head2 _build_services

  This calls the quoting API and always returns a single service for the current plan assigned to the account

  This method ignores what is in $self->packages and uses a single package weighing 1 pound. The idea is to validate the from/to address and compare rates across service providers, but for accurate rating, and for multiple packages, the rate method should be used.

=cut

sub _build_services {
  my $self = shift;

  my %services;

  if ( $self->from_address() && $self->to_address() ) {

    my $response = $self->api->quote(
      pickup_postcode => $self->from_address()->postal_code,
      pickup_suburb => $self->from_address()->city,
      pickup_country => $self->from_address()->country_code,
      delivery_postcode => $self->to_address()->postal_code,
      delivery_suburb => $self->to_address()->city,
      delivery_country => $self->to_address()->country_code,
      weight_units => 'lb',
      weight_value => 1,
    );

    if ($self->_api_response_error($response)) {
      return {};
    }

    my $quote = $response->{content}->[0];
    my ($y, $m, $d) = split('-', $quote->{eta}->{date_range}->[1]);
    my $eta;
    if ($y && $m && $d) {
      $eta = { year => $y, month => $m, day => $d };
    }
    $services{ground} = $services{$quote->{plan_name}} = Shipment::Service->new(
      id => $quote->{plan_name},
      name => $quote->{route}->{description},
      cost => Data::Currency->new($quote->{quote}->{gross}->{amount}, $quote->{quote}->{gross}->{currency}),
      base_cost => Data::Currency->new($quote->{quote}->{net}->{amount}, $quote->{quote}->{net}->{currency}),
      tax => Data::Currency->new($quote->{quote}->{tax}->{amount}, $quote->{quote}->{tax}->{currency}),
      etd => $quote->{eta}->{days_range}->[1],
      eta => $eta,
    );

  }
  else {
    # from and to address required
    $self->error( "Both from and to address are required." );
    return {};
  }

  \%services;
}

=head2 rate

  This calls the quoting API and defaults to ground service which always points at the current plan set up for the account

  If there is more than 1 package, multiple quotes are fetched

=cut

sub rate {
  my ( $self, $service_id ) = @_;

  $service_id ||= 'ground';

  try { 
    $service_id = $self->services->{$service_id}->id;
  } catch {
    $self->error( "service ($service_id) not available" );
    $service_id = '';
  };
  return unless $service_id;

  if ( $self->from_address() && $self->to_address() && $self->count_packages > 0 ) {

    my ($cost, $base_cost, $tax) = (0,0,0);
    my $etd = 0;
    my $eta;
    my $currency = $self->currency;

    foreach my $package (@{ $self->packages }) {
      
      my $volume = ($package->length * $package->width * $package->height);
      my $volume_unit = 'in3';
      if ($self->dim_unit eq 'cm') {
        $volume *= 0.000001;
        $volume_unit = 'm3';
      }

      my $response = $self->api->quote(
        pickup_address_line1 => $self->from_address()->address1,
        pickup_address_line2 => $self->from_address()->address2,
        pickup_postcode => $self->from_address()->postal_code,
        pickup_suburb => $self->from_address()->city,
        pickup_country => $self->from_address()->country_code,
        delivery_address_line1 => $self->to_address()->address1,
        delivery_address_line2 => $self->to_address()->address2,
        delivery_postcode => $self->to_address()->postal_code,
        delivery_suburb => $self->to_address()->city,
        delivery_country => $self->to_address()->country_code,
        weight_units => $self->weight_unit,
        weight_value => $package->weight,
        volume_units => $volume_unit,
        volume_value => $volume,
      );

      if ($self->_api_response_error($response)) {
        return;
      }

      my $quote = $response->{content}->[0];

      $cost += $quote->{quote}->{gross}->{amount};
      $base_cost += $quote->{quote}->{net}->{amount};
      $tax += $quote->{quote}->{tax}->{amount};
      $currency = $quote->{quote}->{gross}->{currency};
      $etd = $quote->{eta}->{days_range}->[1];
      my ($y, $m, $d) = split('-', $quote->{eta}->{date_range}->[1]);
      if ($y && $m && $d) {
        $eta = { year => $y, month => $m, day => $d };
      }
    }

    $self->service( Shipment::Service->new(
        id => $service_id,
        name => $self->services->{$service_id}->name,
        cost => Data::Currency->new($cost, $currency),
        base_cost => Data::Currency->new($base_cost, $currency),
        tax => Data::Currency->new($tax, $currency),
        etd => $etd,
        eta => $eta,
      )
    );
  }
  else {
    # from and to address, packages required
    $self->error( "Both from and to address and at least 1 package are required for rating." );
  }

  return;
}

=head2 ship

  This calls the create orders API and defaults to ground service which always points at the current plan set up for the account

  If there is more than 1 package, separate orders are created for each package

=cut

sub ship {
  my ( $self, $service_id ) = @_;

  $service_id ||= 'ground';

  try { 
    $service_id = $self->services->{$service_id}->id;
  } catch {
    $self->error( "service ($service_id) not available" );
    $service_id = '';
  };
  return unless $service_id;

  if ( $self->from_address() && $self->to_address() && $self->count_packages > 0 ) {

    my $shipment_id;
    my ($cost, $base_cost, $tax) = (0,0,0);
    my $currency = $self->currency;
    my $package_index = 0;

    foreach my $package (@{ $self->packages }) {

      my $volume = ($package->length * $package->width * $package->height);
      my $volume_unit = 'in3';
      if ($self->dim_unit eq 'cm') {
        $volume *= 0.000001;
        $volume_unit = 'm3';
      }

      my $response = $self->api->create_order(
        description => $package->notes,
        weight => { value => $package->weight, units => $self->weight_unit },
        volume => { value => $volume, units => $volume_unit },
        customer_reference => $self->get_reference(0) || '',
        sender => {
          contact => {
            name => $self->from_address()->name,
            phone => $self->from_address()->phone,
            email => $self->from_address()->email,
            company => $self->from_address()->company,
          },
          address => {
            address_line1 => $self->from_address()->address1,
            address_line2 => $self->from_address()->address2,
            suburb => $self->from_address()->city,
            state_name => $self->from_address()->state_code,
            postcode => $self->from_address()->postal_code,
            country => $self->from_address()->country,
          }
        },
        receiver => {
          instructions => $self->special_instructions || 'n/a',
          contact => {
            name => $self->to_address()->name,
            phone => $self->to_address()->phone,
            email => $self->to_address()->email,
            company => $self->to_address()->company,
          },
          address => {
            address_line1 => $self->to_address()->address1,
            address_line2 => $self->to_address()->address2,
            suburb => $self->to_address()->city,
            state_name => $self->to_address()->state_code,
            postcode => $self->to_address()->postal_code,
            country => $self->to_address()->country,
          }
        },
      );

      if ($self->_api_response_error($response)) {
        return;
      }
  
      my $order = $response->{content};

      $cost += $order->{price}->{gross}->{amount};
      $base_cost += $order->{price}->{net}->{amount};
      $tax += $order->{price}->{tax}->{amount};
      $currency = $order->{price}->{gross}->{currency};

      my $tracking_id = $order->{sendle_reference};
      $shipment_id ||= $tracking_id;

      $self->get_package($package_index)->id( $order->{order_id} );
      $self->get_package($package_index)->tracking_id( $tracking_id );
      $self->get_package($package_index)->cost( Data::Currency->new( $order->{price}->{gross}->{amount}, $order->{price}->{gross}->{currency}) );

      $response = $self->api->label( id => $order->{order_id}, type => $self->printer_type . '.pdf' );

      if ($self->_api_response_error($response)) {
        $self->error('failed to get label for order: ' . $order->{order_id});
      }

      $self->get_package($package_index)->label(
        Shipment::Label->new(
          {
            tracking_id => $tracking_id,
            content_type => 'application/' . $self->printer_type . '-pdf',
            data => $response->{raw},
            file_name => $tracking_id . '.pdf',
          },
       )
      );

      $package_index++;

    }

    $self->tracking_id( $shipment_id );
    $self->service( 
       Shipment::Service->new( 
        id    => $service_id,
        name  => $self->services->{$service_id}->name,
        cost => Data::Currency->new($cost, $currency),
        base_cost => Data::Currency->new($base_cost, $currency),
        tax => Data::Currency->new($tax, $currency),
      )
    );

  }
  else {
    # from and to address required
    $self->error( "Both from and to address, and at least 1 package are required for shipping." );
  }

  return;

}

=head2 track

  This method calls the track_order endpoint of the API and returns the current state

=cut

sub track {
  my ($self) = @_;

  if (!$self->tracking_id) {
    $self->error('no tracking id provided');
    return;
  }

  my $response = $self->api->track_order( ref => $self->tracking_id );

  if ($self->_api_response_error($response)) {
    return;
  }

  return $response->{content}->{state};

}

=head1 AUTHOR

Andrew Baerg @ <andrew at pullingshots dot ca>

http://pullingshots.ca/

=head1 BUGS

Please contact me directly.

=head1 COPYRIGHT

Copyright (C) 2021 Andrew J Baerg, All Rights Reserved

=head1 NO WARRANTY

Absolutely, positively NO WARRANTY, neither express or implied, is
offered with this software.  You use this software at your own risk.  In
case of loss, no person or entity owes you anything whatsoever.  You
have been warned.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
