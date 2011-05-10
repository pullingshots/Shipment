package Shipment::UPS::WSDL::RateTypes::RatedShipmentType;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Rate/v1.1' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Service_of :ATTR(:get<Service>);
my %RatedShipmentAlert_of :ATTR(:get<RatedShipmentAlert>);
my %BillingWeight_of :ATTR(:get<BillingWeight>);
my %TransportationCharges_of :ATTR(:get<TransportationCharges>);
my %FRSShipmentData_of :ATTR(:get<FRSShipmentData>);
my %ServiceOptionsCharges_of :ATTR(:get<ServiceOptionsCharges>);
my %TotalCharges_of :ATTR(:get<TotalCharges>);
my %NegotiatedRateCharges_of :ATTR(:get<NegotiatedRateCharges>);
my %GuaranteedDelivery_of :ATTR(:get<GuaranteedDelivery>);
my %RatedPackage_of :ATTR(:get<RatedPackage>);

__PACKAGE__->_factory(
    [ qw(        Service
        RatedShipmentAlert
        BillingWeight
        TransportationCharges
        FRSShipmentData
        ServiceOptionsCharges
        TotalCharges
        NegotiatedRateCharges
        GuaranteedDelivery
        RatedPackage

    ) ],
    {
        'Service' => \%Service_of,
        'RatedShipmentAlert' => \%RatedShipmentAlert_of,
        'BillingWeight' => \%BillingWeight_of,
        'TransportationCharges' => \%TransportationCharges_of,
        'FRSShipmentData' => \%FRSShipmentData_of,
        'ServiceOptionsCharges' => \%ServiceOptionsCharges_of,
        'TotalCharges' => \%TotalCharges_of,
        'NegotiatedRateCharges' => \%NegotiatedRateCharges_of,
        'GuaranteedDelivery' => \%GuaranteedDelivery_of,
        'RatedPackage' => \%RatedPackage_of,
    },
    {
        'Service' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
        'RatedShipmentAlert' => 'Shipment::UPS::WSDL::RateTypes::RatedShipmentInfoType',
        'BillingWeight' => 'Shipment::UPS::WSDL::RateTypes::BillingWeightType',
        'TransportationCharges' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
        'FRSShipmentData' => 'Shipment::UPS::WSDL::RateTypes::FRSShipmentType',
        'ServiceOptionsCharges' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
        'TotalCharges' => 'Shipment::UPS::WSDL::RateTypes::ChargesType',
        'NegotiatedRateCharges' => 'Shipment::UPS::WSDL::RateTypes::TotalChargeType',
        'GuaranteedDelivery' => 'Shipment::UPS::WSDL::RateTypes::GuaranteedDeliveryType',
        'RatedPackage' => 'Shipment::UPS::WSDL::RateTypes::RatedPackageType',
    },
    {

        'Service' => 'Service',
        'RatedShipmentAlert' => 'RatedShipmentAlert',
        'BillingWeight' => 'BillingWeight',
        'TransportationCharges' => 'TransportationCharges',
        'FRSShipmentData' => 'FRSShipmentData',
        'ServiceOptionsCharges' => 'ServiceOptionsCharges',
        'TotalCharges' => 'TotalCharges',
        'NegotiatedRateCharges' => 'NegotiatedRateCharges',
        'GuaranteedDelivery' => 'GuaranteedDelivery',
        'RatedPackage' => 'RatedPackage',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::RateTypes::RatedShipmentType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
RatedShipmentType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Rate/v1.1.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Service (min/maxOccurs: 1/1)


=item * RatedShipmentAlert (min/maxOccurs: 0/unbounded)


=item * BillingWeight (min/maxOccurs: 1/1)


=item * TransportationCharges (min/maxOccurs: 1/1)


=item * FRSShipmentData (min/maxOccurs: 0/1)


=item * ServiceOptionsCharges (min/maxOccurs: 1/1)


=item * TotalCharges (min/maxOccurs: 1/1)


=item * NegotiatedRateCharges (min/maxOccurs: 0/1)


=item * GuaranteedDelivery (min/maxOccurs: 0/1)


=item * RatedPackage (min/maxOccurs: 1/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::RateTypes::RatedShipmentType
   Service =>  { # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   RatedShipmentAlert =>  { # Shipment::UPS::WSDL::RateTypes::RatedShipmentInfoType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   BillingWeight =>  { # Shipment::UPS::WSDL::RateTypes::BillingWeightType
     UnitOfMeasurement => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
     Weight =>  $some_value, # string
   },
   TransportationCharges =>  { # Shipment::UPS::WSDL::RateTypes::ChargesType
     CurrencyCode =>  $some_value, # string
     MonetaryValue =>  $some_value, # string
   },
   FRSShipmentData =>  { # Shipment::UPS::WSDL::RateTypes::FRSShipmentType
     TransportationCharges =>  { # Shipment::UPS::WSDL::RateTypes::TransportationChargesType
       GrossCharge => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
       DiscountAmount => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
       DiscountPercentage =>  $some_value, # string
       NetCharge => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
     },
   },
   ServiceOptionsCharges => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
   TotalCharges => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
   NegotiatedRateCharges =>  { # Shipment::UPS::WSDL::RateTypes::TotalChargeType
     TotalCharge => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
   },
   GuaranteedDelivery =>  { # Shipment::UPS::WSDL::RateTypes::GuaranteedDeliveryType
     BusinessDaysInTransit =>  $some_value, # string
     DeliveryByTime =>  $some_value, # string
   },
   RatedPackage =>  { # Shipment::UPS::WSDL::RateTypes::RatedPackageType
     TransportationCharges => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
     ServiceOptionsCharges => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
     TotalCharges => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
     Weight =>  $some_value, # string
     BillingWeight => {}, # Shipment::UPS::WSDL::RateTypes::BillingWeightType
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

