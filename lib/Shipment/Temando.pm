package Shipment::Temando;
use strict;
use warnings;

=head1 NAME

Shipment::Temando - Interface to Temando Shipping Web Services

=head1 SYNOPSIS

  use Shipment::Temando;
  use Shipment::Address;
  use Shipment::Package;

  my $shipment = Shipment::Temando->new(
    from_address => Shipment::Address->new( ... ),
    to_address => Shipment::Address->new( ... ),
    packages => [ Shipment::Pacjage->new( ... ), ],
  );

  foreach my $service ( $shipment->all_services ) {
    print $service->id . " (" . $service->cost . ")\n";
  }

  $shipment->rate( 'Service Name' );
  print $shipment->service->cost . "\n";

  $shipment->ship( $service->id );
  $shipment->get_package(0)->label->save;

=head1 ABOUT

This class provides an interface to the Temando Web Services API.

For code examples, see https://github.com/pullingshots/Shipment/tree/master/eg

You must sign up for an API account with Temando in order to make use of ths module.

http://www.temando.com/affiliateRegistration2.html

See related modules for documentation on options and how to access rates and labels:
  
L<Shipment::Base> - common attributes and methods for all interfaces
L<Shipment::Address> - define an from or to address
L<Shipment::Package> - define package details, weight, dimensions, etc
L<Shipment::Service> - access information about a service, rate, etd, etc
L<Shipment::Label> - access the label file

It makes extensive use of SOAP::WSDL in order to create/decode xml requests and responses. The Shipment::Temando::WSDL interface was created primarily using the wsdl2perl.pl script from SOAP::WSDL.

=cut

use Try::Tiny;
use Shipment::SOAP::WSDL;
use Moo;
use MooX::HandlesVia;
use MooX::Types::MooseLike::Base qw(:all);
use namespace::clean;

#$Shipment::SOAP::WSDL::Debug = 1;

extends 'Shipment::Base';

=head1 Class Attributes

=head2 user, password, client_id

Credentials required to access the Temando API.

=cut

has 'username' => (
  is => 'rw',
  isa => Str,
);

has 'password' => (
  is => 'rw',
  isa => Str,
);

has 'client_id' => (
  is => 'rw',
  isa => Str,
);

=head2 live

This determines whether you will use the Temando training web service (for development) or the production web service (live)

=cut

has 'live' => (
  is => 'rw',
  isa => Bool,
  default => 0,
);

=head2 class, subclass

These define the type of shipment.

Currently the default (and only supported) options are class="General Goods" and subclass="Household Goods". This should be sane defaults for most shipments.

Temando supports many other options here including Freight (pallets, containers, etc) and Vehicles.

=cut

has 'class' => (
  is => 'rw',
  default => 'General Goods',
);

has 'subclass' => (
  is => 'rw',
  default => 'Household Goods',
);

=head2 request_id

The Temando request id

This will be set upon a successful call to "ship"

It can also be set before a call to "cancel"

type: String

=cut

has 'request_id' => (
  is => 'rw',
  isa => Str,
);

=head2 comments

Additional comments about the shipment

type: String

=cut

has 'comments' => (
  is => 'rw',
  isa => Str,
);

=head2 credit_card_type, credit_card_expiry, credit_card_number, credit_card_name

Temando accepts payment by credit card

credit_card_type can be one of 'Visa' or 'MasterCard'

credit_card_expiry must be in the format '02-2013'

=cut

has 'credit_card_type' => (
  is => 'rw',
  isa => Enum[ qw( Visa MasterCard ) ],
);

has 'credit_card_expiry' => (
  is => 'rw',
  isa => Str,
);

has 'credit_card_number' => (
  is => 'rw',
  isa => Str,
);

has 'credit_card_name' => (
  is => 'rw',
  isa => Str,
);


=head2 Shipment::Base type maps

Shipment::Base provides abstract types which need to be mapped to Temando (i.e. package_type of "envelope" maps to Temando "Document Envelope")

=cut

has '+bill_type' => (
  isa => Enum[qw( sender account credit credit_card )],
);

my %bill_type_map = (
  'sender'      => 'Account',
  'account'     => 'Account',
  'credit'      => 'Credit',
  'credit_card' => 'Credit Card',
);

my %signature_type_map = (
  'default'      => '',
  'required'     => '',
  'not_required' => undef,
  'adult'        => '',
);

my %package_type_map = (
  'custom'              => 'Carton',
  'carton'              => 'Carton',
  'envelope'            => 'Document Envelope',
  'tube'                => 'Tube',
  'box'                 => 'Box',
  'pack'                => 'Flat Pack',
  'pallet'              => 'Pallet',
  'cylinder'            => 'Cylinder',
  'letter'              => 'Letter',
  'parcel'              => 'Parcel',
  'bag'                 => 'Satchel/Bag',
  'skid'                => 'Skid',
  'unpacked'            => 'Unpackaged or N/A',
  'wheel'               => 'Wheel/Tyre',
);

my %units_type_map = (
  'lb'          => 'Pounds',
  'oz'          => 'Ounces',
  'kg'          => 'Kilograms',
  'g'          => 'Grams',
  'in'          => 'Inches',
  'ft'          => 'Feet',
  'cm'          => 'Centimetres',
  'm'           => 'Metres',
);

=head2 custom package types

Temando provides package types in addition to the defaults in Shipment::Base

=cut

has '+package_type' => (
  isa => Enum[keys %package_type_map],
  default => 'custom',
);

=head2 printer types

Temando does not offer true thermal printing, all labels are provided as documents (pdf, doc, or xls), thermal labels are simply a 4x6 documents.

=cut

my %printer_type_map = (
  'pdf'        => 'Standard',
  'thermal'        => 'Thermal',
  'image'      => 'Standard',
);

my %content_type_map = (
  'application/pdf' => 'pdf',
  'application/msword' => 'doc',
  'application/excel'   => 'xls',
);

=head2 default currency

The default currency is AUD

=cut

has '+currency' => (
  default => 'AUD',
);


=head1 Class Methods

=head2 _build_services

This calls getQuotesByRequest from the Temando API

Each Quote that is returned is added to services

The following service mapping is used:
  * ground => cheapest where <usingGeneralRoad>
  * express => cheapest where <usingExpressRoad>
  * priority => cheapest where <usingExpressAir>

=cut

sub _build_services {
  my $self = shift;

  use Shipment::Package;
  use Shipment::Service;
  use Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port;
  
  my $interface = Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port->new(
    {
      live => $self->live,
    }
  );

  my $goods_value;
  my $insured_value;

  my @pieces;
  foreach (@{ $self->packages }) {
    push @pieces,
      {
          class => $self->class,
          subclass => $self->subclass,
          packaging => ($_->type) ? $package_type_map{$_->type} : $package_type_map{$self->package_type},
          qualifierFreightGeneralFragile => ($_->fragile) ? 'Y' : 'N',
          distanceMeasurementType => $units_type_map{$self->dim_unit},
          weightMeasurementType => $units_type_map{$self->weight_unit},
          length => $_->length,
          width => $_->width,
          height => $_->height,
          weight => $_->weight,
          quantity => 1,
          description => $_->notes,
      };
    $goods_value += $_->goods_value->value;
    $insured_value += $_->insured_value->value;
  }
  $goods_value ||= 1;

  my $anytime;
  $anytime = {
          readyDate => $self->pickup_date->ymd,
          readyTime => $self->pickup_date->strftime('%p'),
        } if $self->pickup_date;

  my $response;
  my %services;

  try {

    $response = $interface->getQuotesByRequest(
      {
        anythings => {
          anything => \@pieces,
        },
        anywhere => {
          itemNature => 'Domestic', ## Temando currently only supports domestic shipments
          itemMethod => 'Door to Door', ## Temando also supports 'Depot to Depot'
          originCountry => $self->from_address->country_code,
          originCode => $self->from_address->postal_code,
          originSuburb => $self->from_address->city,
          destinationCountry => $self->to_address->country_code,
          destinationCode => $self->to_address->postal_code,
          destinationSuburb => $self->to_address->city,
          destinationIs => ($self->from_address->address_type eq 'residential') ? 'Residence' : 'Business',
          originIs => ($self->from_address->address_type eq 'residential') ? 'Residence' : 'Business',
        },
        anytime => $anytime,
        general => {
          goodsValue => $goods_value,
        },
        clientId => $self->client_id,
      },
      {
        UsernameToken => {
          Username => $self->username,
          Password => $self->password,
        },
      },
    );

    #warn $response;

    foreach my $quote (@{ $response->get_quote }) {
      #warn $quote;
      my $id = $quote->get_carrier->get_id->get_value . $quote->get_deliveryMethod->get_value;
      $services{$id} = Shipment::Service->new(
          id            => $id,
          name          => $quote->get_carrier->get_companyName->get_value . " - " . $quote->get_deliveryMethod->get_value,
          etd           => $quote->get_etaTo->get_value,
          pickup_etd    => $quote->get_etaFrom->get_value,
          cost          => Data::Currency->new($quote->get_totalPrice->get_value, $quote->get_currency->get_value),
          base_cost     => Data::Currency->new($quote->get_basePrice->get_value, $quote->get_currency->get_value),
          tax           => Data::Currency->new($quote->get_tax->get_value, $quote->get_currency->get_value),
          carrier_id    => $quote->get_carrier->get_id->get_value,
          carrier_name  => $quote->get_carrier->get_companyName->get_value,
          service_name  => $quote->get_deliveryMethod->get_value,
          guaranteed    => ($quote->get_guaranteedEta->get_value eq 'Y') ? 1 : 0,
        );

      my $adjustments = 0;
      if ($quote->get_adjustments->get_adjustment) {
	      foreach my $adjustment (@{ $quote->get_adjustments->get_adjustment }) {
		if ($self->bill_type eq 'credit_card' && $adjustment->get_description->get_value eq 'Credit Card Payment Adjustment') {
		  $adjustments += $adjustment->get_amount->get_value + $adjustment->get_tax->get_value;
		}
		if ($self->bill_type eq 'credit' && $adjustment->get_description->get_value eq 'Credit Payment Adjustment') {
		  $adjustments += $adjustment->get_amount->get_value + $adjustment->get_tax->get_value;
		}
	      }
      }

      my $extra_charges = 0;
      if ($quote->get_extras->get_extra) {
	      foreach my $extra (@{ $quote->get_extras->get_extra }) {
		$services{$id}->extras->{$extra->get_summary->get_value} = Shipment::Service->new(
		    id        => $extra->get_summary->get_value,
		    name      => $extra->get_details->get_value,
		    cost      => Data::Currency->new($extra->get_totalPrice->get_value, $quote->get_currency->get_value),
		    base_cost => Data::Currency->new($extra->get_basePrice->get_value, $quote->get_currency->get_value),
		    tax       => Data::Currency->new($extra->get_tax->get_value, $quote->get_currency->get_value),
		  );
		if ($insured_value && $extra->get_summary->get_value eq 'Insurance') {
		  $extra_charges += $extra->get_totalPrice->get_value;
		}
		if ($self->carbon_offset && $extra->get_summary->get_value eq 'Carbon Offset') {
		  $extra_charges += $extra->get_totalPrice->get_value;
		}

		if ($quote->get_adjustments->get_adjustment) {
			foreach my $adjustment (@{ $quote->get_adjustments->get_adjustment }) {
			  if ($self->bill_type eq 'credit_card' && $adjustment->get_description->get_value eq 'Credit Card Payment Adjustment') {
			    $adjustments += $adjustment->get_amount->get_value + $adjustment->get_tax->get_value;
			  }
			  if ($self->bill_type eq 'credit' && $adjustment->get_description->get_value eq 'Credit Payment Adjustment') {
			    $adjustments += $adjustment->get_amount->get_value + $adjustment->get_tax->get_value;
			  }
			}
		}
	      }
      }
      $services{$id}->extra_charges(Data::Currency->new($extra_charges, $quote->get_currency->get_value));
      $services{$id}->adjustments(Data::Currency->new($adjustments, $quote->get_currency->get_value));

      my $type; 
      $type = 'ground' if $quote->get_usingGeneralRoad->get_value eq 'Y';
      $type = 'express' if $quote->get_usingExpressRoad->get_value eq 'Y';
      $type = 'priority' if $quote->get_usingExpressAir->get_value eq 'Y';

      if ($services{$type}) {
        $services{$type} = $services{$id} if $services{$type}->cost > $services{$id}->cost;
      }
      else {
        $services{$type} = $services{$id};
      }
    }

  } catch {
    warn $_;
    warn $response->get_faultstring;
    $self->error( $response->get_faultcode->get_value . ":" . $response->get_faultstring->get_value );
  };

  \%services
}

=head2 rate

This method sets $self->service to $self->services{$service_id}

=cut

sub rate {
  my ( $self, $service_id ) = @_;

  try { 
    $service_id = $self->services->{$service_id}->id;
  } catch {
    warn $_;
    warn "service ($service_id) not available";
    $self->error( "service ($service_id) not available" );
    $service_id = '';
  };
  return unless $service_id;

  $self->service($self->services->{$service_id});

}

=head2 ship

This method calls makeBookingByRequest from the Temando API

All labels are available in $self->documents

The consignment document is available in $self->manifest

=cut

sub ship {
  my ( $self, $service_id ) = @_;

  try {
    $self->rate($service_id);
    $service_id = $self->service->id;
  } catch {
    warn $_;
    warn "service ($service_id) not available";
    $self->error( "service ($service_id) not available" );
    $service_id = '';
  };
  return unless $service_id;

  use Shipment::Package;
  use Shipment::Service;
  use Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port;
  
  my $interface = Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port->new(
    {
      live => $self->live,
    }
  );

  my $goods_value;
  my $insured_value;

  my @pieces;
  foreach (@{ $self->packages }) {
    push @pieces,
      {
          class => $self->class,
          subclass => $self->subclass,
          packaging => ($_->type) ? $package_type_map{$_->type} : $package_type_map{$self->package_type},
          qualifierFreightGeneralFragile => ($_->fragile) ? 'Y' : 'N',
          distanceMeasurementType => $units_type_map{$self->dim_unit},
          weightMeasurementType => $units_type_map{$self->weight_unit},
          length => $_->length,
          width => $_->width,
          height => $_->height,
          weight => $_->weight,
          quantity => 1,
          description => $_->notes,
      };
    $goods_value += $_->goods_value->value;
    $insured_value += $_->insured_value->value;
  }
  $goods_value ||= 1;

  my @extras;
  if ($insured_value && $self->service->extras->{'Insurance'}) {
    my $insurance = $self->service->extras->{'Insurance'};
    push @extras, 
      {
        summary => $insurance->id,
        details => $insurance->name,
        totalPrice => $insurance->cost->value,
        basePrice => $insurance->base_cost->value,
        tax => $insurance->tax->value,
      };
  }

  if ($self->carbon_offset && $self->service->extras->{'Carbon Offset'}) {
    my $carbon_offset = $self->service->extras->{'Carbon Offset'};
    push @extras, 
      {
        summary => $carbon_offset->id,
        details => $carbon_offset->name,
        totalPrice => $carbon_offset->cost->value,
        basePrice => $carbon_offset->base_cost->value,
        tax => $carbon_offset->tax->value,
      };
  }

  my $anytime;
  $anytime = {
          readyDate => $self->pickup_date->ymd,
          readyTime => $self->pickup_date->strftime('%p'),
        } if $self->pickup_date;

  my $payment;
  $payment->{paymentType} = $bill_type_map{$self->bill_type};
  if ($self->bill_type eq 'credit_card') {
    $payment->{cardType} = $self->credit_card_type;
    $payment->{cardExpiryDate} = $self->credit_card_expiry;
    $payment->{cardNumber} = $self->credit_card_number;
    $payment->{cardName} = $self->credit_card_name;
  }

  my $response;
  my %services;

  try {

    $response = $interface->makeBookingByRequest(
      {
        anythings => {
          anything => \@pieces,
        },
        anywhere => {
          itemNature => 'Domestic', ## Temando currently only supports domestic shipments
          itemMethod => 'Door to Door', ## Temando also supports 'Depot to Depot'
          originCountry => $self->from_address->country_code,
          originCode => $self->from_address->postal_code,
          originSuburb => $self->from_address->city,
          destinationCountry => $self->to_address->country_code,
          destinationCode => $self->to_address->postal_code,
          destinationSuburb => $self->to_address->city,
          destinationIs => ($self->from_address->address_type eq 'residential') ? 'Residence' : 'Business',
          originIs => ($self->from_address->address_type eq 'residential') ? 'Residence' : 'Business',
        },
        anytime => $anytime,
        general => {
          goodsValue => $goods_value,
        },
        origin => {
          contactName => $self->from_address->contact,
          companyName => $self->from_address->company,
          street      => $self->from_address->address1 . " " . $self->from_address->address2,
          suburb      => $self->from_address->city,
          state       => $self->from_address->province,
          code        => $self->from_address->postal_code,
          country     => $self->from_address->country_code,
          phone1      => $self->from_address->phone || undef,
          email       => $self->from_address->email || undef,
        },
        destination => {
          contactName => $self->to_address->contact,
          companyName => $self->to_address->company,
          street      => $self->to_address->address1 . " " . $self->to_address->address2,
          suburb      => $self->to_address->city,
          state       => $self->to_address->province,
          code        => $self->to_address->postal_code,
          country     => $self->to_address->country_code,
          phone1      => $self->to_address->phone || undef,
          email       => $self->to_address->email || undef,
        },
        quote => {
          totalPrice  => $self->service->cost->value,
          basePrice   => $self->service->base_cost->value,
          tax         => $self->service->tax->value,
          currency    => $self->service->cost->code,
          deliveryMethod  => $self->service->service_name,
          etaFrom         => $self->service->pickup_etd,
          etaTo           => $self->service->etd,
          guaranteedEta   => ($self->service->guaranteed) ? 'Y' : 'N',
          carrierId       => $self->service->carrier_id,
          extras => {
            extra => \@extras,
          },
        },
        payment => $payment,
        instructions => $self->special_instructions,
        reference => join(" ", $self->all_references),
        comments => $self->comments,
        labelPrinterType => $printer_type_map{$self->printer_type},
        clientId => $self->client_id,
      },
      {
        UsernameToken => {
          Username => $self->username,
          Password => $self->password,
        },
      },
    );

    #warn $response;

    use Shipment::Label;
    use MIME::Base64;

    my $tracking_id = $response->get_consignmentNumber->get_value || $response->get_bookingNumber->get_value || $response->get_requestId->get_value;
    $self->tracking_id( $tracking_id );
    $self->request_id( $response->get_requestId->get_value );

    my $data = decode_base64($response->get_labelDocument->get_value);
    $self->documents(
        Shipment::Label->new(
          {
            tracking_id => $tracking_id,
            content_type => $response->get_labelDocumentType->get_value,
            data => $data,
            file_name => $tracking_id . '-labels.' . $content_type_map{$response->get_labelDocumentType->get_value},
          },
        )
      );

    $data = decode_base64($response->get_consignmentDocument->get_value);
    $self->manifest(
        Shipment::Label->new(
          {
            content_type => $response->get_consignmentDocumentType->get_value,
            data => $data,
            file_name => $tracking_id . '-manifest.' . $content_type_map{$response->get_consignmentDocumentType->get_value},
          },
        )
      );

    foreach (@{ $self->packages }) {
      $_->tracking_id( $tracking_id );

      $data = decode_base64($response->get_labelDocument->get_value);

      $_->label(
        Shipment::Label->new(
          {
            tracking_id => $tracking_id,
            content_type => $response->get_labelDocumentType->get_value,
            data => $data,
            file_name => $tracking_id . '.' . $content_type_map{$response->get_labelDocumentType->get_value},
          },
        )
      );
    }

  } catch {
    warn $_;
    warn $response->get_faultstring;
    $self->error( $response->get_faultcode->get_value . ":" . $response->get_faultstring->get_value );
  };

}

=head2 cancel

This method calls cancelRequest from the Temando API

It uses $self->request_id to identify the request to be cancelled

returns "Cancelled"  if successful,

=cut

sub cancel {
  my $self = shift;

  if (!$self->request_id) {
    $self->error('no request id provided');
    return;
  }

  use Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port;
  
  my $interface = Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port->new(
    {
      live => $self->live,
    }
  );

  my $response = $interface->cancelRequest(
    {
      requestId => $self->request_id,
    },
    {
      UsernameToken => {
        Username => $self->username,
        Password => $self->password,
      },
    },
  );
  #warn $response;

  my $error;
  try {
    $error = $response->get_faultstring;
  }
  catch { };

  if ($error) {
    warn $response->get_faultstring;
    $self->error( $response->get_faultcode->get_value . ":" . $response->get_faultstring->get_value );
    return;
  }
  else {
    return 'Cancelled';
  }

}

=head1 AUTHOR

Andrew Baerg @ <andrew at pullingshots dot ca>

http://pullingshots.ca/

=head1 ACKNOWLEDGEMENTS

SiteSuite Australasia (http://www.sitesuite.com.au/) commissioned and paid for the development of this module

=head1 BUGS

Please contact me directly.

=head1 COPYRIGHT

Copyright (C) 2012 Andrew J Baerg, All Rights Reserved

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
