package Shipment::FedEx::WSDL::TrackTypes::Commodity;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/track/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %CommodityId_of :ATTR(:get<CommodityId>);
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
my %PartNumber_of :ATTR(:get<PartNumber>);
my %NaftaDetail_of :ATTR(:get<NaftaDetail>);

__PACKAGE__->_factory(
    [ qw(        CommodityId
        Name
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
        PartNumber
        NaftaDetail

    ) ],
    {
        'CommodityId' => \%CommodityId_of,
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
        'PartNumber' => \%PartNumber_of,
        'NaftaDetail' => \%NaftaDetail_of,
    },
    {
        'CommodityId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Name' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'NumberOfPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CountryOfManufacture' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'HarmonizedCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Weight' => 'Shipment::FedEx::WSDL::TrackTypes::Weight',
        'Quantity' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
        'QuantityUnits' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'AdditionalMeasures' => 'Shipment::FedEx::WSDL::TrackTypes::Measure',
        'UnitPrice' => 'Shipment::FedEx::WSDL::TrackTypes::Money',
        'CustomsValue' => 'Shipment::FedEx::WSDL::TrackTypes::Money',
        'ExciseConditions' => 'Shipment::FedEx::WSDL::TrackTypes::EdtExciseCondition',
        'ExportLicenseNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ExportLicenseExpirationDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
        'CIMarksAndNumbers' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PartNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'NaftaDetail' => 'Shipment::FedEx::WSDL::TrackTypes::NaftaCommodityDetail',
    },
    {

        'CommodityId' => 'CommodityId',
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
        'PartNumber' => 'PartNumber',
        'NaftaDetail' => 'NaftaDetail',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::TrackTypes::Commodity

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Commodity from the namespace http://fedex.com/ws/track/v9.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * CommodityId


=item * Name


=item * NumberOfPieces


=item * Description


=item * CountryOfManufacture


=item * HarmonizedCode


=item * Weight


=item * Quantity


=item * QuantityUnits


=item * AdditionalMeasures


=item * UnitPrice


=item * CustomsValue


=item * ExciseConditions


=item * ExportLicenseNumber


=item * ExportLicenseExpirationDate


=item * CIMarksAndNumbers


=item * PartNumber


=item * NaftaDetail




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::TrackTypes::Commodity
   CommodityId =>  $some_value, # string
   Name =>  $some_value, # string
   NumberOfPieces =>  $some_value, # nonNegativeInteger
   Description =>  $some_value, # string
   CountryOfManufacture =>  $some_value, # string
   HarmonizedCode =>  $some_value, # string
   Weight =>  { # Shipment::FedEx::WSDL::TrackTypes::Weight
     Units => $some_value, # WeightUnits
     Value =>  $some_value, # decimal
   },
   Quantity =>  $some_value, # decimal
   QuantityUnits =>  $some_value, # string
   AdditionalMeasures =>  { # Shipment::FedEx::WSDL::TrackTypes::Measure
     Quantity =>  $some_value, # decimal
     Units =>  $some_value, # string
   },
   UnitPrice =>  { # Shipment::FedEx::WSDL::TrackTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   CustomsValue =>  { # Shipment::FedEx::WSDL::TrackTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   ExciseConditions =>  { # Shipment::FedEx::WSDL::TrackTypes::EdtExciseCondition
     Category =>  $some_value, # string
     Value =>  $some_value, # string
   },
   ExportLicenseNumber =>  $some_value, # string
   ExportLicenseExpirationDate =>  $some_value, # date
   CIMarksAndNumbers =>  $some_value, # string
   PartNumber =>  $some_value, # string
   NaftaDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::NaftaCommodityDetail
     PreferenceCriterion => $some_value, # NaftaPreferenceCriterionCode
     ProducerDetermination => $some_value, # NaftaProducerDeterminationCode
     ProducerId =>  $some_value, # string
     NetCostMethod => $some_value, # NaftaNetCostMethodCode
     NetCostDateRange =>  { # Shipment::FedEx::WSDL::TrackTypes::DateRange
       Begins =>  $some_value, # date
       Ends =>  $some_value, # date
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

