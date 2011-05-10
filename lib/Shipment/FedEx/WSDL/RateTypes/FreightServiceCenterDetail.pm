package Shipment::FedEx::WSDL::RateTypes::FreightServiceCenterDetail;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/rate/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %InterlineCarrierCode_of :ATTR(:get<InterlineCarrierCode>);
my %InterlineCarrierName_of :ATTR(:get<InterlineCarrierName>);
my %AdditionalDays_of :ATTR(:get<AdditionalDays>);
my %LocalService_of :ATTR(:get<LocalService>);
my %LocalDistance_of :ATTR(:get<LocalDistance>);
my %LocalDuration_of :ATTR(:get<LocalDuration>);
my %LocalServiceScheduling_of :ATTR(:get<LocalServiceScheduling>);
my %LimitedServiceDays_of :ATTR(:get<LimitedServiceDays>);
my %GatewayLocationId_of :ATTR(:get<GatewayLocationId>);
my %Location_of :ATTR(:get<Location>);
my %ContactAndAddress_of :ATTR(:get<ContactAndAddress>);

__PACKAGE__->_factory(
    [ qw(        InterlineCarrierCode
        InterlineCarrierName
        AdditionalDays
        LocalService
        LocalDistance
        LocalDuration
        LocalServiceScheduling
        LimitedServiceDays
        GatewayLocationId
        Location
        ContactAndAddress

    ) ],
    {
        'InterlineCarrierCode' => \%InterlineCarrierCode_of,
        'InterlineCarrierName' => \%InterlineCarrierName_of,
        'AdditionalDays' => \%AdditionalDays_of,
        'LocalService' => \%LocalService_of,
        'LocalDistance' => \%LocalDistance_of,
        'LocalDuration' => \%LocalDuration_of,
        'LocalServiceScheduling' => \%LocalServiceScheduling_of,
        'LimitedServiceDays' => \%LimitedServiceDays_of,
        'GatewayLocationId' => \%GatewayLocationId_of,
        'Location' => \%Location_of,
        'ContactAndAddress' => \%ContactAndAddress_of,
    },
    {
        'InterlineCarrierCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'InterlineCarrierName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'AdditionalDays' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
        'LocalService' => 'Shipment::FedEx::WSDL::RateTypes::ServiceType',
        'LocalDistance' => 'Shipment::FedEx::WSDL::RateTypes::Distance',
        'LocalDuration' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'LocalServiceScheduling' => 'Shipment::FedEx::WSDL::RateTypes::FreightServiceSchedulingType',
        'LimitedServiceDays' => 'Shipment::FedEx::WSDL::RateTypes::DayOfWeekType',
        'GatewayLocationId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Location' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ContactAndAddress' => 'Shipment::FedEx::WSDL::RateTypes::ContactAndAddress',
    },
    {

        'InterlineCarrierCode' => 'InterlineCarrierCode',
        'InterlineCarrierName' => 'InterlineCarrierName',
        'AdditionalDays' => 'AdditionalDays',
        'LocalService' => 'LocalService',
        'LocalDistance' => 'LocalDistance',
        'LocalDuration' => 'LocalDuration',
        'LocalServiceScheduling' => 'LocalServiceScheduling',
        'LimitedServiceDays' => 'LimitedServiceDays',
        'GatewayLocationId' => 'GatewayLocationId',
        'Location' => 'Location',
        'ContactAndAddress' => 'ContactAndAddress',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::FreightServiceCenterDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
FreightServiceCenterDetail from the namespace http://fedex.com/ws/rate/v9.

This class describes the relationship between a customer-specified address and the FedEx Freight / FedEx National Freight Service Center that supports that address.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * InterlineCarrierCode (min/maxOccurs: 0/1)


=item * InterlineCarrierName (min/maxOccurs: 0/1)


=item * AdditionalDays (min/maxOccurs: 0/1)


=item * LocalService (min/maxOccurs: 0/1)


=item * LocalDistance (min/maxOccurs: 0/1)


=item * LocalDuration (min/maxOccurs: 0/1)


=item * LocalServiceScheduling (min/maxOccurs: 0/1)


=item * LimitedServiceDays (min/maxOccurs: 0/unbounded)


=item * GatewayLocationId (min/maxOccurs: 0/1)


=item * Location (min/maxOccurs: 0/1)


=item * ContactAndAddress (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::FreightServiceCenterDetail
   InterlineCarrierCode =>  $some_value, # string
   InterlineCarrierName =>  $some_value, # string
   AdditionalDays =>  $some_value, # int
   LocalService => $some_value, # ServiceType
   LocalDistance =>  { # Shipment::FedEx::WSDL::RateTypes::Distance
     Value =>  $some_value, # decimal
     Units => $some_value, # DistanceUnits
   },
   LocalDuration =>  $some_value, # string
   LocalServiceScheduling => $some_value, # FreightServiceSchedulingType
   LimitedServiceDays => $some_value, # DayOfWeekType
   GatewayLocationId =>  $some_value, # string
   Location =>  $some_value, # string
   ContactAndAddress =>  { # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
     Contact =>  { # Shipment::FedEx::WSDL::RateTypes::Contact
       ContactId =>  $some_value, # string
       PersonName =>  $some_value, # string
       Title =>  $some_value, # string
       CompanyName =>  $some_value, # string
       PhoneNumber =>  $some_value, # string
       PhoneExtension =>  $some_value, # string
       PagerNumber =>  $some_value, # string
       FaxNumber =>  $some_value, # string
       EMailAddress =>  $some_value, # string
     },
     Address =>  { # Shipment::FedEx::WSDL::RateTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

