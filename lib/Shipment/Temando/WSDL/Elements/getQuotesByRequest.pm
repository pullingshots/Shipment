
package Shipment::Temando::WSDL::Elements::getQuotesByRequest;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/server.xsd' }

__PACKAGE__->__set_name('getQuotesByRequest');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %anythings_of :ATTR(:get<anythings>);
my %anywhere_of :ATTR(:get<anywhere>);
my %anytime_of :ATTR(:get<anytime>);
my %general_of :ATTR(:get<general>);
my %clientId_of :ATTR(:get<clientId>);

__PACKAGE__->_factory(
    [ qw(        anythings
        anywhere
        anytime
        general
        clientId

    ) ],
    {
        'anythings' => \%anythings_of,
        'anywhere' => \%anywhere_of,
        'anytime' => \%anytime_of,
        'general' => \%general_of,
        'clientId' => \%clientId_of,
    },
    {

        'anythings' => 'Shipment::Temando::WSDL::Elements::getQuotesByRequest::_anythings',
        'anywhere' => 'Shipment::Temando::WSDL::Types::Anywhere',
        'anytime' => 'Shipment::Temando::WSDL::Types::Anytime',
        'general' => 'Shipment::Temando::WSDL::Types::General',
        'clientId' => 'Shipment::Temando::WSDL::Types::ClientId',
    },
    {

        'anythings' => 'anythings',
        'anywhere' => 'anywhere',
        'anytime' => 'anytime',
        'general' => 'general',
        'clientId' => 'clientId',
    }
);

} # end BLOCK




package Shipment::Temando::WSDL::Elements::getQuotesByRequest::_anythings;
use strict;
use warnings;
{
our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %anything_of :ATTR(:get<anything>);

__PACKAGE__->_factory(
    [ qw(        anything

    ) ],
    {
        'anything' => \%anything_of,
    },
    {
        'anything' => 'Shipment::Temando::WSDL::Types::Anything',
    },
    {

        'anything' => 'anything',
    }
);

} # end BLOCK






}





} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Elements::getQuotesByRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
getQuotesByRequest from the namespace http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/server.xsd.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * anythings

 $element->set_anythings($data);
 $element->get_anythings();




=item * anywhere

 $element->set_anywhere($data);
 $element->get_anywhere();




=item * anytime

 $element->set_anytime($data);
 $element->get_anytime();




=item * general

 $element->set_general($data);
 $element->get_general();




=item * clientId

 $element->set_clientId($data);
 $element->get_clientId();





=back


=head1 METHODS

=head2 new

 my $element = Shipment::Temando::WSDL::Elements::getQuotesByRequest->new($data);

Constructor. The following data structure may be passed to new():

 {
   anythings =>  {
     anything =>  { # Shipment::Temando::WSDL::Types::Anything
       class => $some_value, # Class
       subclass => $some_value, # Subclass
       mode => $some_value, # Mode
       tlSubclass => $some_value, # TlSubclass
       packaging => $some_value, # Packaging
       palletType => $some_value, # PalletType
       palletNature => $some_value, # PalletNature
       containerDimensions => $some_value, # ContainerDimensions
       containerNature => $some_value, # ContainerNature
       containerRegistered => $some_value, # YesNoOption
       qualifierFreightGeneralDangerousGoods => $some_value, # YesNoOption
       qualifierFreightGeneralFragile => $some_value, # YesNoOption
       qualifierFreightGeneralRefrigerated => $some_value, # YesNoOption
       qualifierVehicleMake => $some_value, # VehicleMake
       qualifierVehicleModel => $some_value, # VehicleModel
       qualifierVehicleDescription => $some_value, # VehicleDescription
       qualifierVehicleRunning => $some_value, # YesNoOption
       qualifierVehicleRegistered => $some_value, # YesNoOption
       qualifierVehicleYear => $some_value, # VehicleYear
       qualifierVehicleRegistration => $some_value, # VehicleRegistration
       qualifierBoatMake => $some_value, # BoatMake
       qualifierBoatModel => $some_value, # BoatModel
       qualifierBoatSeaworthy => $some_value, # YesNoOption
       qualifierBoatTrailer => $some_value, # YesNoOption
       qualifierBoatHullType => $some_value, # BoatHullType
       qualifierLivestockType => $some_value, # LivestockType
       qualifierAnimalVaccinated => $some_value, # YesNoOption
       qualifierAnimalRegistered => $some_value, # YesNoOption
       qualifierAnimalType => $some_value, # AnimalType
       qualifierAnimalBreed => $some_value, # AnimalBreed
       qualifierAnimalSex => $some_value, # Sex
       qualifierAnimalAge => $some_value, # AnimalAge
       qualifierAnimalCrate => $some_value, # AnimalCrate
       distanceMeasurementType => $some_value, # DistanceMeasurementType
       weightMeasurementType => $some_value, # WeightMeasurementType
       length => $some_value, # Length
       width => $some_value, # Width
       height => $some_value, # Height
       weight => $some_value, # Weight
       quantity => $some_value, # Quantity
       description => $some_value, # ItemDescription
     },
   },
   anywhere =>  { # Shipment::Temando::WSDL::Types::Anywhere
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
   anytime =>  { # Shipment::Temando::WSDL::Types::Anytime
     readyDate => $some_value, # Date
     readyTime => $some_value, # ReadyTime
   },
   general =>  { # Shipment::Temando::WSDL::Types::General
     goodsValue => $some_value, # CurrencyAmount
   },
   clientId => $some_value, # ClientId
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

