package Shipment::Temando::WSDL::Types::Anywhere;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(0);

sub get_xmlns { 'http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %itemNature_of :ATTR(:get<itemNature>);
my %itemMethod_of :ATTR(:get<itemMethod>);
my %originDescription_of :ATTR(:get<originDescription>);
my %originCountry_of :ATTR(:get<originCountry>);
my %originCode_of :ATTR(:get<originCode>);
my %originSuburb_of :ATTR(:get<originSuburb>);
my %originState_of :ATTR(:get<originState>);
my %originCity_of :ATTR(:get<originCity>);
my %originPort_of :ATTR(:get<originPort>);
my %destinationDescription_of :ATTR(:get<destinationDescription>);
my %destinationCountry_of :ATTR(:get<destinationCountry>);
my %destinationCode_of :ATTR(:get<destinationCode>);
my %destinationSuburb_of :ATTR(:get<destinationSuburb>);
my %destinationState_of :ATTR(:get<destinationState>);
my %destinationCity_of :ATTR(:get<destinationCity>);
my %destinationPort_of :ATTR(:get<destinationPort>);
my %portType_of :ATTR(:get<portType>);
my %destinationIs_of :ATTR(:get<destinationIs>);
my %destinationBusPostalBox_of :ATTR(:get<destinationBusPostalBox>);
my %destinationBusUnattended_of :ATTR(:get<destinationBusUnattended>);
my %destinationBusDock_of :ATTR(:get<destinationBusDock>);
my %destinationBusForklift_of :ATTR(:get<destinationBusForklift>);
my %destinationBusLoadingFacilities_of :ATTR(:get<destinationBusLoadingFacilities>);
my %destinationBusInside_of :ATTR(:get<destinationBusInside>);
my %destinationBusNotifyBefore_of :ATTR(:get<destinationBusNotifyBefore>);
my %destinationBusLimitedAccess_of :ATTR(:get<destinationBusLimitedAccess>);
my %destinationBusHeavyLift_of :ATTR(:get<destinationBusHeavyLift>);
my %destinationBusTailgateLifter_of :ATTR(:get<destinationBusTailgateLifter>);
my %destinationBusContainerSwingLifter_of :ATTR(:get<destinationBusContainerSwingLifter>);
my %destinationResPostalBox_of :ATTR(:get<destinationResPostalBox>);
my %destinationResUnattended_of :ATTR(:get<destinationResUnattended>);
my %destinationResInside_of :ATTR(:get<destinationResInside>);
my %destinationResNotifyBefore_of :ATTR(:get<destinationResNotifyBefore>);
my %destinationResLimitedAccess_of :ATTR(:get<destinationResLimitedAccess>);
my %destinationResHeavyLift_of :ATTR(:get<destinationResHeavyLift>);
my %destinationResTailgateLifter_of :ATTR(:get<destinationResTailgateLifter>);
my %originIs_of :ATTR(:get<originIs>);
my %originBusUnattended_of :ATTR(:get<originBusUnattended>);
my %originBusDock_of :ATTR(:get<originBusDock>);
my %originBusForklift_of :ATTR(:get<originBusForklift>);
my %originBusLoadingFacilities_of :ATTR(:get<originBusLoadingFacilities>);
my %originBusInside_of :ATTR(:get<originBusInside>);
my %originBusNotifyBefore_of :ATTR(:get<originBusNotifyBefore>);
my %originBusLimitedAccess_of :ATTR(:get<originBusLimitedAccess>);
my %originBusHeavyLift_of :ATTR(:get<originBusHeavyLift>);
my %originBusTailgateLifter_of :ATTR(:get<originBusTailgateLifter>);
my %originBusContainerSwingLifter_of :ATTR(:get<originBusContainerSwingLifter>);
my %originResUnattended_of :ATTR(:get<originResUnattended>);
my %originResInside_of :ATTR(:get<originResInside>);
my %originResNotifyBefore_of :ATTR(:get<originResNotifyBefore>);
my %originResLimitedAccess_of :ATTR(:get<originResLimitedAccess>);
my %originResHeavyLift_of :ATTR(:get<originResHeavyLift>);
my %originResTailgateLifter_of :ATTR(:get<originResTailgateLifter>);

__PACKAGE__->_factory(
    [ qw(        itemNature
        itemMethod
        originDescription
        originCountry
        originCode
        originSuburb
        originState
        originCity
        originPort
        destinationDescription
        destinationCountry
        destinationCode
        destinationSuburb
        destinationState
        destinationCity
        destinationPort
        portType
        destinationIs
        destinationBusPostalBox
        destinationBusUnattended
        destinationBusDock
        destinationBusForklift
        destinationBusLoadingFacilities
        destinationBusInside
        destinationBusNotifyBefore
        destinationBusLimitedAccess
        destinationBusHeavyLift
        destinationBusTailgateLifter
        destinationBusContainerSwingLifter
        destinationResPostalBox
        destinationResUnattended
        destinationResInside
        destinationResNotifyBefore
        destinationResLimitedAccess
        destinationResHeavyLift
        destinationResTailgateLifter
        originIs
        originBusUnattended
        originBusDock
        originBusForklift
        originBusLoadingFacilities
        originBusInside
        originBusNotifyBefore
        originBusLimitedAccess
        originBusHeavyLift
        originBusTailgateLifter
        originBusContainerSwingLifter
        originResUnattended
        originResInside
        originResNotifyBefore
        originResLimitedAccess
        originResHeavyLift
        originResTailgateLifter

    ) ],
    {
        'itemNature' => \%itemNature_of,
        'itemMethod' => \%itemMethod_of,
        'originDescription' => \%originDescription_of,
        'originCountry' => \%originCountry_of,
        'originCode' => \%originCode_of,
        'originSuburb' => \%originSuburb_of,
        'originState' => \%originState_of,
        'originCity' => \%originCity_of,
        'originPort' => \%originPort_of,
        'destinationDescription' => \%destinationDescription_of,
        'destinationCountry' => \%destinationCountry_of,
        'destinationCode' => \%destinationCode_of,
        'destinationSuburb' => \%destinationSuburb_of,
        'destinationState' => \%destinationState_of,
        'destinationCity' => \%destinationCity_of,
        'destinationPort' => \%destinationPort_of,
        'portType' => \%portType_of,
        'destinationIs' => \%destinationIs_of,
        'destinationBusPostalBox' => \%destinationBusPostalBox_of,
        'destinationBusUnattended' => \%destinationBusUnattended_of,
        'destinationBusDock' => \%destinationBusDock_of,
        'destinationBusForklift' => \%destinationBusForklift_of,
        'destinationBusLoadingFacilities' => \%destinationBusLoadingFacilities_of,
        'destinationBusInside' => \%destinationBusInside_of,
        'destinationBusNotifyBefore' => \%destinationBusNotifyBefore_of,
        'destinationBusLimitedAccess' => \%destinationBusLimitedAccess_of,
        'destinationBusHeavyLift' => \%destinationBusHeavyLift_of,
        'destinationBusTailgateLifter' => \%destinationBusTailgateLifter_of,
        'destinationBusContainerSwingLifter' => \%destinationBusContainerSwingLifter_of,
        'destinationResPostalBox' => \%destinationResPostalBox_of,
        'destinationResUnattended' => \%destinationResUnattended_of,
        'destinationResInside' => \%destinationResInside_of,
        'destinationResNotifyBefore' => \%destinationResNotifyBefore_of,
        'destinationResLimitedAccess' => \%destinationResLimitedAccess_of,
        'destinationResHeavyLift' => \%destinationResHeavyLift_of,
        'destinationResTailgateLifter' => \%destinationResTailgateLifter_of,
        'originIs' => \%originIs_of,
        'originBusUnattended' => \%originBusUnattended_of,
        'originBusDock' => \%originBusDock_of,
        'originBusForklift' => \%originBusForklift_of,
        'originBusLoadingFacilities' => \%originBusLoadingFacilities_of,
        'originBusInside' => \%originBusInside_of,
        'originBusNotifyBefore' => \%originBusNotifyBefore_of,
        'originBusLimitedAccess' => \%originBusLimitedAccess_of,
        'originBusHeavyLift' => \%originBusHeavyLift_of,
        'originBusTailgateLifter' => \%originBusTailgateLifter_of,
        'originBusContainerSwingLifter' => \%originBusContainerSwingLifter_of,
        'originResUnattended' => \%originResUnattended_of,
        'originResInside' => \%originResInside_of,
        'originResNotifyBefore' => \%originResNotifyBefore_of,
        'originResLimitedAccess' => \%originResLimitedAccess_of,
        'originResHeavyLift' => \%originResHeavyLift_of,
        'originResTailgateLifter' => \%originResTailgateLifter_of,
    },
    {
        'itemNature' => 'Shipment::Temando::WSDL::Types::DeliveryNature',
        'itemMethod' => 'Shipment::Temando::WSDL::Types::DeliveryType',
        'originDescription' => 'Shipment::Temando::WSDL::Types::LocationName',
        'originCountry' => 'Shipment::Temando::WSDL::Types::CountryCode',
        'originCode' => 'Shipment::Temando::WSDL::Types::PostalCode',
        'originSuburb' => 'Shipment::Temando::WSDL::Types::Suburb',
        'originState' => 'Shipment::Temando::WSDL::Types::State',
        'originCity' => 'Shipment::Temando::WSDL::Types::City',
        'originPort' => 'Shipment::Temando::WSDL::Types::PortName',
        'destinationDescription' => 'Shipment::Temando::WSDL::Types::LocationName',
        'destinationCountry' => 'Shipment::Temando::WSDL::Types::CountryCode',
        'destinationCode' => 'Shipment::Temando::WSDL::Types::PostalCode',
        'destinationSuburb' => 'Shipment::Temando::WSDL::Types::Suburb',
        'destinationState' => 'Shipment::Temando::WSDL::Types::State',
        'destinationCity' => 'Shipment::Temando::WSDL::Types::City',
        'destinationPort' => 'Shipment::Temando::WSDL::Types::PortName',
        'portType' => 'Shipment::Temando::WSDL::Types::PortType',
        'destinationIs' => 'Shipment::Temando::WSDL::Types::LocationType',
        'destinationBusPostalBox' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationBusUnattended' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationBusDock' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationBusForklift' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationBusLoadingFacilities' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationBusInside' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationBusNotifyBefore' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationBusLimitedAccess' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationBusHeavyLift' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationBusTailgateLifter' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationBusContainerSwingLifter' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationResPostalBox' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationResUnattended' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationResInside' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationResNotifyBefore' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationResLimitedAccess' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationResHeavyLift' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'destinationResTailgateLifter' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originIs' => 'Shipment::Temando::WSDL::Types::LocationType',
        'originBusUnattended' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originBusDock' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originBusForklift' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originBusLoadingFacilities' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originBusInside' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originBusNotifyBefore' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originBusLimitedAccess' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originBusHeavyLift' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originBusTailgateLifter' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originBusContainerSwingLifter' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originResUnattended' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originResInside' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originResNotifyBefore' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originResLimitedAccess' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originResHeavyLift' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'originResTailgateLifter' => 'Shipment::Temando::WSDL::Types::YesNoOption',
    },
    {

        'itemNature' => 'itemNature',
        'itemMethod' => 'itemMethod',
        'originDescription' => 'originDescription',
        'originCountry' => 'originCountry',
        'originCode' => 'originCode',
        'originSuburb' => 'originSuburb',
        'originState' => 'originState',
        'originCity' => 'originCity',
        'originPort' => 'originPort',
        'destinationDescription' => 'destinationDescription',
        'destinationCountry' => 'destinationCountry',
        'destinationCode' => 'destinationCode',
        'destinationSuburb' => 'destinationSuburb',
        'destinationState' => 'destinationState',
        'destinationCity' => 'destinationCity',
        'destinationPort' => 'destinationPort',
        'portType' => 'portType',
        'destinationIs' => 'destinationIs',
        'destinationBusPostalBox' => 'destinationBusPostalBox',
        'destinationBusUnattended' => 'destinationBusUnattended',
        'destinationBusDock' => 'destinationBusDock',
        'destinationBusForklift' => 'destinationBusForklift',
        'destinationBusLoadingFacilities' => 'destinationBusLoadingFacilities',
        'destinationBusInside' => 'destinationBusInside',
        'destinationBusNotifyBefore' => 'destinationBusNotifyBefore',
        'destinationBusLimitedAccess' => 'destinationBusLimitedAccess',
        'destinationBusHeavyLift' => 'destinationBusHeavyLift',
        'destinationBusTailgateLifter' => 'destinationBusTailgateLifter',
        'destinationBusContainerSwingLifter' => 'destinationBusContainerSwingLifter',
        'destinationResPostalBox' => 'destinationResPostalBox',
        'destinationResUnattended' => 'destinationResUnattended',
        'destinationResInside' => 'destinationResInside',
        'destinationResNotifyBefore' => 'destinationResNotifyBefore',
        'destinationResLimitedAccess' => 'destinationResLimitedAccess',
        'destinationResHeavyLift' => 'destinationResHeavyLift',
        'destinationResTailgateLifter' => 'destinationResTailgateLifter',
        'originIs' => 'originIs',
        'originBusUnattended' => 'originBusUnattended',
        'originBusDock' => 'originBusDock',
        'originBusForklift' => 'originBusForklift',
        'originBusLoadingFacilities' => 'originBusLoadingFacilities',
        'originBusInside' => 'originBusInside',
        'originBusNotifyBefore' => 'originBusNotifyBefore',
        'originBusLimitedAccess' => 'originBusLimitedAccess',
        'originBusHeavyLift' => 'originBusHeavyLift',
        'originBusTailgateLifter' => 'originBusTailgateLifter',
        'originBusContainerSwingLifter' => 'originBusContainerSwingLifter',
        'originResUnattended' => 'originResUnattended',
        'originResInside' => 'originResInside',
        'originResNotifyBefore' => 'originResNotifyBefore',
        'originResLimitedAccess' => 'originResLimitedAccess',
        'originResHeavyLift' => 'originResHeavyLift',
        'originResTailgateLifter' => 'originResTailgateLifter',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Types::Anywhere

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Anywhere from the namespace http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * itemNature (min/maxOccurs: 0/1)


=item * itemMethod (min/maxOccurs: 0/1)


=item * originDescription (min/maxOccurs: 0/1)


=item * originCountry (min/maxOccurs: 0/1)


=item * originCode (min/maxOccurs: 0/1)


=item * originSuburb (min/maxOccurs: 0/1)


=item * originState (min/maxOccurs: 0/1)


=item * originCity (min/maxOccurs: 0/1)


=item * originPort (min/maxOccurs: 0/1)


=item * destinationDescription (min/maxOccurs: 0/1)


=item * destinationCountry (min/maxOccurs: 0/1)


=item * destinationCode (min/maxOccurs: 0/1)


=item * destinationSuburb (min/maxOccurs: 0/1)


=item * destinationState (min/maxOccurs: 0/1)


=item * destinationCity (min/maxOccurs: 0/1)


=item * destinationPort (min/maxOccurs: 0/1)


=item * portType (min/maxOccurs: 0/1)


=item * destinationIs (min/maxOccurs: 0/1)


=item * destinationBusPostalBox (min/maxOccurs: 0/1)


=item * destinationBusUnattended (min/maxOccurs: 0/1)


=item * destinationBusDock (min/maxOccurs: 0/1)


=item * destinationBusForklift (min/maxOccurs: 0/1)


=item * destinationBusLoadingFacilities (min/maxOccurs: 0/1)


=item * destinationBusInside (min/maxOccurs: 0/1)


=item * destinationBusNotifyBefore (min/maxOccurs: 0/1)


=item * destinationBusLimitedAccess (min/maxOccurs: 0/1)


=item * destinationBusHeavyLift (min/maxOccurs: 0/1)


=item * destinationBusTailgateLifter (min/maxOccurs: 0/1)


=item * destinationBusContainerSwingLifter (min/maxOccurs: 0/1)


=item * destinationResPostalBox (min/maxOccurs: 0/1)


=item * destinationResUnattended (min/maxOccurs: 0/1)


=item * destinationResInside (min/maxOccurs: 0/1)


=item * destinationResNotifyBefore (min/maxOccurs: 0/1)


=item * destinationResLimitedAccess (min/maxOccurs: 0/1)


=item * destinationResHeavyLift (min/maxOccurs: 0/1)


=item * destinationResTailgateLifter (min/maxOccurs: 0/1)


=item * originIs (min/maxOccurs: 0/1)


=item * originBusUnattended (min/maxOccurs: 0/1)


=item * originBusDock (min/maxOccurs: 0/1)


=item * originBusForklift (min/maxOccurs: 0/1)


=item * originBusLoadingFacilities (min/maxOccurs: 0/1)


=item * originBusInside (min/maxOccurs: 0/1)


=item * originBusNotifyBefore (min/maxOccurs: 0/1)


=item * originBusLimitedAccess (min/maxOccurs: 0/1)


=item * originBusHeavyLift (min/maxOccurs: 0/1)


=item * originBusTailgateLifter (min/maxOccurs: 0/1)


=item * originBusContainerSwingLifter (min/maxOccurs: 0/1)


=item * originResUnattended (min/maxOccurs: 0/1)


=item * originResInside (min/maxOccurs: 0/1)


=item * originResNotifyBefore (min/maxOccurs: 0/1)


=item * originResLimitedAccess (min/maxOccurs: 0/1)


=item * originResHeavyLift (min/maxOccurs: 0/1)


=item * originResTailgateLifter (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Temando::WSDL::Types::Anywhere
   itemNature => $some_value, # DeliveryNature
   itemMethod => $some_value, # DeliveryType
   originDescription => $some_value, # LocationName
   originCountry => $some_value, # CountryCode
   originCode => $some_value, # PostalCode
   originSuburb => $some_value, # Suburb
   originState => $some_value, # State
   originCity => $some_value, # City
   originPort => $some_value, # PortName
   destinationDescription => $some_value, # LocationName
   destinationCountry => $some_value, # CountryCode
   destinationCode => $some_value, # PostalCode
   destinationSuburb => $some_value, # Suburb
   destinationState => $some_value, # State
   destinationCity => $some_value, # City
   destinationPort => $some_value, # PortName
   portType => $some_value, # PortType
   destinationIs => $some_value, # LocationType
   destinationBusPostalBox => $some_value, # YesNoOption
   destinationBusUnattended => $some_value, # YesNoOption
   destinationBusDock => $some_value, # YesNoOption
   destinationBusForklift => $some_value, # YesNoOption
   destinationBusLoadingFacilities => $some_value, # YesNoOption
   destinationBusInside => $some_value, # YesNoOption
   destinationBusNotifyBefore => $some_value, # YesNoOption
   destinationBusLimitedAccess => $some_value, # YesNoOption
   destinationBusHeavyLift => $some_value, # YesNoOption
   destinationBusTailgateLifter => $some_value, # YesNoOption
   destinationBusContainerSwingLifter => $some_value, # YesNoOption
   destinationResPostalBox => $some_value, # YesNoOption
   destinationResUnattended => $some_value, # YesNoOption
   destinationResInside => $some_value, # YesNoOption
   destinationResNotifyBefore => $some_value, # YesNoOption
   destinationResLimitedAccess => $some_value, # YesNoOption
   destinationResHeavyLift => $some_value, # YesNoOption
   destinationResTailgateLifter => $some_value, # YesNoOption
   originIs => $some_value, # LocationType
   originBusUnattended => $some_value, # YesNoOption
   originBusDock => $some_value, # YesNoOption
   originBusForklift => $some_value, # YesNoOption
   originBusLoadingFacilities => $some_value, # YesNoOption
   originBusInside => $some_value, # YesNoOption
   originBusNotifyBefore => $some_value, # YesNoOption
   originBusLimitedAccess => $some_value, # YesNoOption
   originBusHeavyLift => $some_value, # YesNoOption
   originBusTailgateLifter => $some_value, # YesNoOption
   originBusContainerSwingLifter => $some_value, # YesNoOption
   originResUnattended => $some_value, # YesNoOption
   originResInside => $some_value, # YesNoOption
   originResNotifyBefore => $some_value, # YesNoOption
   originResLimitedAccess => $some_value, # YesNoOption
   originResHeavyLift => $some_value, # YesNoOption
   originResTailgateLifter => $some_value, # YesNoOption
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

