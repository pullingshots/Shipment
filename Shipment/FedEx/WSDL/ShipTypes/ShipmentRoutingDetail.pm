package Shipment::FedEx::WSDL::ShipTypes::ShipmentRoutingDetail;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/ship/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %UrsaPrefixCode_of :ATTR(:get<UrsaPrefixCode>);
my %UrsaSuffixCode_of :ATTR(:get<UrsaSuffixCode>);
my %OriginLocationId_of :ATTR(:get<OriginLocationId>);
my %OriginServiceArea_of :ATTR(:get<OriginServiceArea>);
my %DestinationLocationId_of :ATTR(:get<DestinationLocationId>);
my %DestinationServiceArea_of :ATTR(:get<DestinationServiceArea>);
my %DestinationLocationStateOrProvinceCode_of :ATTR(:get<DestinationLocationStateOrProvinceCode>);
my %DeliveryDate_of :ATTR(:get<DeliveryDate>);
my %DeliveryDay_of :ATTR(:get<DeliveryDay>);
my %CommitDate_of :ATTR(:get<CommitDate>);
my %CommitDay_of :ATTR(:get<CommitDay>);
my %TransitTime_of :ATTR(:get<TransitTime>);
my %MaximumTransitTime_of :ATTR(:get<MaximumTransitTime>);
my %AstraPlannedServiceLevel_of :ATTR(:get<AstraPlannedServiceLevel>);
my %AstraDescription_of :ATTR(:get<AstraDescription>);
my %PostalCode_of :ATTR(:get<PostalCode>);
my %StateOrProvinceCode_of :ATTR(:get<StateOrProvinceCode>);
my %CountryCode_of :ATTR(:get<CountryCode>);
my %AirportId_of :ATTR(:get<AirportId>);

__PACKAGE__->_factory(
    [ qw(        UrsaPrefixCode
        UrsaSuffixCode
        OriginLocationId
        OriginServiceArea
        DestinationLocationId
        DestinationServiceArea
        DestinationLocationStateOrProvinceCode
        DeliveryDate
        DeliveryDay
        CommitDate
        CommitDay
        TransitTime
        MaximumTransitTime
        AstraPlannedServiceLevel
        AstraDescription
        PostalCode
        StateOrProvinceCode
        CountryCode
        AirportId

    ) ],
    {
        'UrsaPrefixCode' => \%UrsaPrefixCode_of,
        'UrsaSuffixCode' => \%UrsaSuffixCode_of,
        'OriginLocationId' => \%OriginLocationId_of,
        'OriginServiceArea' => \%OriginServiceArea_of,
        'DestinationLocationId' => \%DestinationLocationId_of,
        'DestinationServiceArea' => \%DestinationServiceArea_of,
        'DestinationLocationStateOrProvinceCode' => \%DestinationLocationStateOrProvinceCode_of,
        'DeliveryDate' => \%DeliveryDate_of,
        'DeliveryDay' => \%DeliveryDay_of,
        'CommitDate' => \%CommitDate_of,
        'CommitDay' => \%CommitDay_of,
        'TransitTime' => \%TransitTime_of,
        'MaximumTransitTime' => \%MaximumTransitTime_of,
        'AstraPlannedServiceLevel' => \%AstraPlannedServiceLevel_of,
        'AstraDescription' => \%AstraDescription_of,
        'PostalCode' => \%PostalCode_of,
        'StateOrProvinceCode' => \%StateOrProvinceCode_of,
        'CountryCode' => \%CountryCode_of,
        'AirportId' => \%AirportId_of,
    },
    {
        'UrsaPrefixCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'UrsaSuffixCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'OriginLocationId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'OriginServiceArea' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DestinationLocationId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DestinationServiceArea' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DestinationLocationStateOrProvinceCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DeliveryDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
        'DeliveryDay' => 'Shipment::FedEx::WSDL::ShipTypes::DayOfWeekType',
        'CommitDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
        'CommitDay' => 'Shipment::FedEx::WSDL::ShipTypes::DayOfWeekType',
        'TransitTime' => 'Shipment::FedEx::WSDL::ShipTypes::TransitTimeType',
        'MaximumTransitTime' => 'Shipment::FedEx::WSDL::ShipTypes::TransitTimeType',
        'AstraPlannedServiceLevel' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'AstraDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'StateOrProvinceCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CountryCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'AirportId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'UrsaPrefixCode' => 'UrsaPrefixCode',
        'UrsaSuffixCode' => 'UrsaSuffixCode',
        'OriginLocationId' => 'OriginLocationId',
        'OriginServiceArea' => 'OriginServiceArea',
        'DestinationLocationId' => 'DestinationLocationId',
        'DestinationServiceArea' => 'DestinationServiceArea',
        'DestinationLocationStateOrProvinceCode' => 'DestinationLocationStateOrProvinceCode',
        'DeliveryDate' => 'DeliveryDate',
        'DeliveryDay' => 'DeliveryDay',
        'CommitDate' => 'CommitDate',
        'CommitDay' => 'CommitDay',
        'TransitTime' => 'TransitTime',
        'MaximumTransitTime' => 'MaximumTransitTime',
        'AstraPlannedServiceLevel' => 'AstraPlannedServiceLevel',
        'AstraDescription' => 'AstraDescription',
        'PostalCode' => 'PostalCode',
        'StateOrProvinceCode' => 'StateOrProvinceCode',
        'CountryCode' => 'CountryCode',
        'AirportId' => 'AirportId',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::ShipmentRoutingDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ShipmentRoutingDetail from the namespace http://fedex.com/ws/ship/v9.

Information about the routing, origin, destination and delivery of a shipment.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * UrsaPrefixCode (min/maxOccurs: 0/1)


=item * UrsaSuffixCode (min/maxOccurs: 0/1)


=item * OriginLocationId (min/maxOccurs: 0/1)


=item * OriginServiceArea (min/maxOccurs: 0/1)


=item * DestinationLocationId (min/maxOccurs: 0/1)


=item * DestinationServiceArea (min/maxOccurs: 0/1)


=item * DestinationLocationStateOrProvinceCode (min/maxOccurs: 0/1)


=item * DeliveryDate (min/maxOccurs: 0/1)


=item * DeliveryDay (min/maxOccurs: 0/1)


=item * CommitDate (min/maxOccurs: 0/1)


=item * CommitDay (min/maxOccurs: 0/1)


=item * TransitTime (min/maxOccurs: 0/1)


=item * MaximumTransitTime (min/maxOccurs: 0/1)


=item * AstraPlannedServiceLevel (min/maxOccurs: 0/1)


=item * AstraDescription (min/maxOccurs: 0/1)


=item * PostalCode (min/maxOccurs: 0/1)


=item * StateOrProvinceCode (min/maxOccurs: 0/1)


=item * CountryCode (min/maxOccurs: 0/1)


=item * AirportId (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::ShipmentRoutingDetail
   UrsaPrefixCode =>  $some_value, # string
   UrsaSuffixCode =>  $some_value, # string
   OriginLocationId =>  $some_value, # string
   OriginServiceArea =>  $some_value, # string
   DestinationLocationId =>  $some_value, # string
   DestinationServiceArea =>  $some_value, # string
   DestinationLocationStateOrProvinceCode =>  $some_value, # string
   DeliveryDate =>  $some_value, # date
   DeliveryDay => $some_value, # DayOfWeekType
   CommitDate =>  $some_value, # date
   CommitDay => $some_value, # DayOfWeekType
   TransitTime => $some_value, # TransitTimeType
   MaximumTransitTime => $some_value, # TransitTimeType
   AstraPlannedServiceLevel =>  $some_value, # string
   AstraDescription =>  $some_value, # string
   PostalCode =>  $some_value, # string
   StateOrProvinceCode =>  $some_value, # string
   CountryCode =>  $some_value, # string
   AirportId =>  $some_value, # string
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

