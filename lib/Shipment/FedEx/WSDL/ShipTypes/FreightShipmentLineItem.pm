package Shipment::FedEx::WSDL::ShipTypes::FreightShipmentLineItem;
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

my %FreightClass_of :ATTR(:get<FreightClass>);
my %ClassProvidedByCustomer_of :ATTR(:get<ClassProvidedByCustomer>);
my %HandlingUnits_of :ATTR(:get<HandlingUnits>);
my %Packaging_of :ATTR(:get<Packaging>);
my %Pieces_of :ATTR(:get<Pieces>);
my %NmfcCode_of :ATTR(:get<NmfcCode>);
my %HazardousMaterials_of :ATTR(:get<HazardousMaterials>);
my %BillOfLadingNumber_of :ATTR(:get<BillOfLadingNumber>);
my %PurchaseOrderNumber_of :ATTR(:get<PurchaseOrderNumber>);
my %Description_of :ATTR(:get<Description>);
my %Weight_of :ATTR(:get<Weight>);
my %Dimensions_of :ATTR(:get<Dimensions>);
my %Volume_of :ATTR(:get<Volume>);

__PACKAGE__->_factory(
    [ qw(        FreightClass
        ClassProvidedByCustomer
        HandlingUnits
        Packaging
        Pieces
        NmfcCode
        HazardousMaterials
        BillOfLadingNumber
        PurchaseOrderNumber
        Description
        Weight
        Dimensions
        Volume

    ) ],
    {
        'FreightClass' => \%FreightClass_of,
        'ClassProvidedByCustomer' => \%ClassProvidedByCustomer_of,
        'HandlingUnits' => \%HandlingUnits_of,
        'Packaging' => \%Packaging_of,
        'Pieces' => \%Pieces_of,
        'NmfcCode' => \%NmfcCode_of,
        'HazardousMaterials' => \%HazardousMaterials_of,
        'BillOfLadingNumber' => \%BillOfLadingNumber_of,
        'PurchaseOrderNumber' => \%PurchaseOrderNumber_of,
        'Description' => \%Description_of,
        'Weight' => \%Weight_of,
        'Dimensions' => \%Dimensions_of,
        'Volume' => \%Volume_of,
    },
    {
        'FreightClass' => 'Shipment::FedEx::WSDL::ShipTypes::FreightClassType',
        'ClassProvidedByCustomer' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'HandlingUnits' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'Packaging' => 'Shipment::FedEx::WSDL::ShipTypes::PhysicalPackagingType',
        'Pieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'NmfcCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'HazardousMaterials' => 'Shipment::FedEx::WSDL::ShipTypes::HazardousCommodityOptionType',
        'BillOfLadingNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PurchaseOrderNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Weight' => 'Shipment::FedEx::WSDL::ShipTypes::Weight',
        'Dimensions' => 'Shipment::FedEx::WSDL::ShipTypes::Dimensions',
        'Volume' => 'Shipment::FedEx::WSDL::ShipTypes::Volume',
    },
    {

        'FreightClass' => 'FreightClass',
        'ClassProvidedByCustomer' => 'ClassProvidedByCustomer',
        'HandlingUnits' => 'HandlingUnits',
        'Packaging' => 'Packaging',
        'Pieces' => 'Pieces',
        'NmfcCode' => 'NmfcCode',
        'HazardousMaterials' => 'HazardousMaterials',
        'BillOfLadingNumber' => 'BillOfLadingNumber',
        'PurchaseOrderNumber' => 'PurchaseOrderNumber',
        'Description' => 'Description',
        'Weight' => 'Weight',
        'Dimensions' => 'Dimensions',
        'Volume' => 'Volume',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::FreightShipmentLineItem

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
FreightShipmentLineItem from the namespace http://fedex.com/ws/ship/v9.

Description of an individual commodity or class of content in a shipment.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * FreightClass (min/maxOccurs: 0/1)


=item * ClassProvidedByCustomer (min/maxOccurs: 0/1)


=item * HandlingUnits (min/maxOccurs: 0/1)


=item * Packaging (min/maxOccurs: 0/1)


=item * Pieces (min/maxOccurs: 0/1)


=item * NmfcCode (min/maxOccurs: 0/1)


=item * HazardousMaterials (min/maxOccurs: 0/1)


=item * BillOfLadingNumber (min/maxOccurs: 0/1)


=item * PurchaseOrderNumber (min/maxOccurs: 0/1)


=item * Description (min/maxOccurs: 0/1)


=item * Weight (min/maxOccurs: 0/1)


=item * Dimensions (min/maxOccurs: 0/1)


=item * Volume (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::FreightShipmentLineItem
   FreightClass => $some_value, # FreightClassType
   ClassProvidedByCustomer =>  $some_value, # boolean
   HandlingUnits =>  $some_value, # nonNegativeInteger
   Packaging => $some_value, # PhysicalPackagingType
   Pieces =>  $some_value, # nonNegativeInteger
   NmfcCode =>  $some_value, # string
   HazardousMaterials => $some_value, # HazardousCommodityOptionType
   BillOfLadingNumber =>  $some_value, # string
   PurchaseOrderNumber =>  $some_value, # string
   Description =>  $some_value, # string
   Weight =>  { # Shipment::FedEx::WSDL::ShipTypes::Weight
     Units => $some_value, # WeightUnits
     Value =>  $some_value, # decimal
   },
   Dimensions =>  { # Shipment::FedEx::WSDL::ShipTypes::Dimensions
     Length =>  $some_value, # nonNegativeInteger
     Width =>  $some_value, # nonNegativeInteger
     Height =>  $some_value, # nonNegativeInteger
     Units => $some_value, # LinearUnits
   },
   Volume =>  { # Shipment::FedEx::WSDL::ShipTypes::Volume
     Units => $some_value, # VolumeUnits
     Value =>  $some_value, # decimal
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

