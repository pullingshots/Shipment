package Shipment::FedEx::WSDL::ShipTypes::Commodity;
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

my %Name_of :ATTR(:get<Name>);
my %NumberOfPieces_of :ATTR(:get<NumberOfPieces>);
my %Description_of :ATTR(:get<Description>);
my %CountryOfManufacture_of :ATTR(:get<CountryOfManufacture>);
my %HarmonizedCode_of :ATTR(:get<HarmonizedCode>);
my %Weight_of :ATTR(:get<Weight>);
my %Quantity_of :ATTR(:get<Quantity>);
my %QuantityUnits_of :ATTR(:get<QuantityUnits>);
my %AdditionalMeasures_of :ATTR(:get<AdditionalMeasures>);
my %UnitPrice_of :ATTR(:get<UnitPrice>);
my %CustomsValue_of :ATTR(:get<CustomsValue>);
my %ExciseConditions_of :ATTR(:get<ExciseConditions>);
my %ExportLicenseNumber_of :ATTR(:get<ExportLicenseNumber>);
my %ExportLicenseExpirationDate_of :ATTR(:get<ExportLicenseExpirationDate>);
my %CIMarksAndNumbers_of :ATTR(:get<CIMarksAndNumbers>);
my %NaftaDetail_of :ATTR(:get<NaftaDetail>);

__PACKAGE__->_factory(
    [ qw(        Name
        NumberOfPieces
        Description
        CountryOfManufacture
        HarmonizedCode
        Weight
        Quantity
        QuantityUnits
        AdditionalMeasures
        UnitPrice
        CustomsValue
        ExciseConditions
        ExportLicenseNumber
        ExportLicenseExpirationDate
        CIMarksAndNumbers
        NaftaDetail

    ) ],
    {
        'Name' => \%Name_of,
        'NumberOfPieces' => \%NumberOfPieces_of,
        'Description' => \%Description_of,
        'CountryOfManufacture' => \%CountryOfManufacture_of,
        'HarmonizedCode' => \%HarmonizedCode_of,
        'Weight' => \%Weight_of,
        'Quantity' => \%Quantity_of,
        'QuantityUnits' => \%QuantityUnits_of,
        'AdditionalMeasures' => \%AdditionalMeasures_of,
        'UnitPrice' => \%UnitPrice_of,
        'CustomsValue' => \%CustomsValue_of,
        'ExciseConditions' => \%ExciseConditions_of,
        'ExportLicenseNumber' => \%ExportLicenseNumber_of,
        'ExportLicenseExpirationDate' => \%ExportLicenseExpirationDate_of,
        'CIMarksAndNumbers' => \%CIMarksAndNumbers_of,
        'NaftaDetail' => \%NaftaDetail_of,
    },
    {
        'Name' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'NumberOfPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CountryOfManufacture' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'HarmonizedCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Weight' => 'Shipment::FedEx::WSDL::ShipTypes::Weight',
        'Quantity' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'QuantityUnits' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'AdditionalMeasures' => 'Shipment::FedEx::WSDL::ShipTypes::Measure',
        'UnitPrice' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'CustomsValue' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'ExciseConditions' => 'Shipment::FedEx::WSDL::ShipTypes::EdtExciseCondition',
        'ExportLicenseNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ExportLicenseExpirationDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
        'CIMarksAndNumbers' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'NaftaDetail' => 'Shipment::FedEx::WSDL::ShipTypes::NaftaCommodityDetail',
    },
    {

        'Name' => 'Name',
        'NumberOfPieces' => 'NumberOfPieces',
        'Description' => 'Description',
        'CountryOfManufacture' => 'CountryOfManufacture',
        'HarmonizedCode' => 'HarmonizedCode',
        'Weight' => 'Weight',
        'Quantity' => 'Quantity',
        'QuantityUnits' => 'QuantityUnits',
        'AdditionalMeasures' => 'AdditionalMeasures',
        'UnitPrice' => 'UnitPrice',
        'CustomsValue' => 'CustomsValue',
        'ExciseConditions' => 'ExciseConditions',
        'ExportLicenseNumber' => 'ExportLicenseNumber',
        'ExportLicenseExpirationDate' => 'ExportLicenseExpirationDate',
        'CIMarksAndNumbers' => 'CIMarksAndNumbers',
        'NaftaDetail' => 'NaftaDetail',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::Commodity

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Commodity from the namespace http://fedex.com/ws/ship/v9.

For international multiple piece shipments, commodity information must be passed in the Master and on each child transaction. If this shipment cotains more than four commodities line items, the four highest valued should be included in the first 4 occurances for this request. 




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Name (min/maxOccurs: 0/1)


=item * NumberOfPieces (min/maxOccurs: 1/1)


=item * Description (min/maxOccurs: 0/1)


=item * CountryOfManufacture (min/maxOccurs: 1/1)


=item * HarmonizedCode (min/maxOccurs: 0/1)


=item * Weight (min/maxOccurs: 1/1)


=item * Quantity (min/maxOccurs: 0/1)


=item * QuantityUnits (min/maxOccurs: 0/1)


=item * AdditionalMeasures (min/maxOccurs: 0/unbounded)


=item * UnitPrice (min/maxOccurs: 0/1)


=item * CustomsValue (min/maxOccurs: 0/1)


=item * ExciseConditions (min/maxOccurs: 0/unbounded)


=item * ExportLicenseNumber (min/maxOccurs: 0/1)


=item * ExportLicenseExpirationDate (min/maxOccurs: 0/1)


=item * CIMarksAndNumbers (min/maxOccurs: 0/1)


=item * NaftaDetail (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::Commodity
   Name =>  $some_value, # string
   NumberOfPieces =>  $some_value, # nonNegativeInteger
   Description =>  $some_value, # string
   CountryOfManufacture =>  $some_value, # string
   HarmonizedCode =>  $some_value, # string
   Weight =>  { # Shipment::FedEx::WSDL::ShipTypes::Weight
     Units => $some_value, # WeightUnits
     Value =>  $some_value, # decimal
   },
   Quantity =>  $some_value, # nonNegativeInteger
   QuantityUnits =>  $some_value, # string
   AdditionalMeasures =>  { # Shipment::FedEx::WSDL::ShipTypes::Measure
     Quantity =>  $some_value, # decimal
     Units =>  $some_value, # string
   },
   UnitPrice =>  { # Shipment::FedEx::WSDL::ShipTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   CustomsValue => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   ExciseConditions =>  { # Shipment::FedEx::WSDL::ShipTypes::EdtExciseCondition
     Category =>  $some_value, # string
     Value =>  $some_value, # string
   },
   ExportLicenseNumber =>  $some_value, # string
   ExportLicenseExpirationDate =>  $some_value, # date
   CIMarksAndNumbers =>  $some_value, # string
   NaftaDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::NaftaCommodityDetail
     PreferenceCriterion => $some_value, # NaftaPreferenceCriterionCode
     ProducerDetermination => $some_value, # NaftaProducerDeterminationCode
     ProducerId =>  $some_value, # string
     NetCostMethod => $some_value, # NaftaNetCostMethodCode
     NetCostDateRange =>  { # Shipment::FedEx::WSDL::ShipTypes::DateRange
       Begins =>  $some_value, # date
       Ends =>  $some_value, # date
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

