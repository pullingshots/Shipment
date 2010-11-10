package Shipment::UPS::WSDL::ShipTypes::ProductType;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/IF/v1.0' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Description_of :ATTR(:get<Description>);
my %Unit_of :ATTR(:get<Unit>);
my %CommodityCode_of :ATTR(:get<CommodityCode>);
my %PartNumber_of :ATTR(:get<PartNumber>);
my %OriginCountryCode_of :ATTR(:get<OriginCountryCode>);
my %JointProductionIndicator_of :ATTR(:get<JointProductionIndicator>);
my %NetCostCode_of :ATTR(:get<NetCostCode>);
my %NetCostDateRange_of :ATTR(:get<NetCostDateRange>);
my %PreferenceCriteria_of :ATTR(:get<PreferenceCriteria>);
my %ProducerInfo_of :ATTR(:get<ProducerInfo>);
my %MarksAndNumbers_of :ATTR(:get<MarksAndNumbers>);
my %NumberOfPackagesPerCommodity_of :ATTR(:get<NumberOfPackagesPerCommodity>);
my %ProductWeight_of :ATTR(:get<ProductWeight>);
my %VehicleID_of :ATTR(:get<VehicleID>);
my %ScheduleB_of :ATTR(:get<ScheduleB>);
my %ExportType_of :ATTR(:get<ExportType>);
my %SEDTotalValue_of :ATTR(:get<SEDTotalValue>);

__PACKAGE__->_factory(
    [ qw(        Description
        Unit
        CommodityCode
        PartNumber
        OriginCountryCode
        JointProductionIndicator
        NetCostCode
        NetCostDateRange
        PreferenceCriteria
        ProducerInfo
        MarksAndNumbers
        NumberOfPackagesPerCommodity
        ProductWeight
        VehicleID
        ScheduleB
        ExportType
        SEDTotalValue

    ) ],
    {
        'Description' => \%Description_of,
        'Unit' => \%Unit_of,
        'CommodityCode' => \%CommodityCode_of,
        'PartNumber' => \%PartNumber_of,
        'OriginCountryCode' => \%OriginCountryCode_of,
        'JointProductionIndicator' => \%JointProductionIndicator_of,
        'NetCostCode' => \%NetCostCode_of,
        'NetCostDateRange' => \%NetCostDateRange_of,
        'PreferenceCriteria' => \%PreferenceCriteria_of,
        'ProducerInfo' => \%ProducerInfo_of,
        'MarksAndNumbers' => \%MarksAndNumbers_of,
        'NumberOfPackagesPerCommodity' => \%NumberOfPackagesPerCommodity_of,
        'ProductWeight' => \%ProductWeight_of,
        'VehicleID' => \%VehicleID_of,
        'ScheduleB' => \%ScheduleB_of,
        'ExportType' => \%ExportType_of,
        'SEDTotalValue' => \%SEDTotalValue_of,
    },
    {
        'Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Unit' => 'Shipment::UPS::WSDL::ShipTypes::UnitType',
        'CommodityCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PartNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'OriginCountryCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'JointProductionIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'NetCostCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'NetCostDateRange' => 'Shipment::UPS::WSDL::ShipTypes::NetCostDateType',
        'PreferenceCriteria' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ProducerInfo' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'MarksAndNumbers' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'NumberOfPackagesPerCommodity' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ProductWeight' => 'Shipment::UPS::WSDL::ShipTypes::ProductWeightType',
        'VehicleID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ScheduleB' => 'Shipment::UPS::WSDL::ShipTypes::ScheduleBType',
        'ExportType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'SEDTotalValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'Description' => 'Description',
        'Unit' => 'Unit',
        'CommodityCode' => 'CommodityCode',
        'PartNumber' => 'PartNumber',
        'OriginCountryCode' => 'OriginCountryCode',
        'JointProductionIndicator' => 'JointProductionIndicator',
        'NetCostCode' => 'NetCostCode',
        'NetCostDateRange' => 'NetCostDateRange',
        'PreferenceCriteria' => 'PreferenceCriteria',
        'ProducerInfo' => 'ProducerInfo',
        'MarksAndNumbers' => 'MarksAndNumbers',
        'NumberOfPackagesPerCommodity' => 'NumberOfPackagesPerCommodity',
        'ProductWeight' => 'ProductWeight',
        'VehicleID' => 'VehicleID',
        'ScheduleB' => 'ScheduleB',
        'ExportType' => 'ExportType',
        'SEDTotalValue' => 'SEDTotalValue',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::ShipTypes::ProductType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ProductType from the namespace http://www.ups.com/XMLSchema/XOLTWS/IF/v1.0.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Description (min/maxOccurs: 1/3)


=item * Unit (min/maxOccurs: 0/1)


=item * CommodityCode (min/maxOccurs: 0/1)


=item * PartNumber (min/maxOccurs: 0/1)


=item * OriginCountryCode (min/maxOccurs: 0/1)


=item * JointProductionIndicator (min/maxOccurs: 0/1)


=item * NetCostCode (min/maxOccurs: 0/1)


=item * NetCostDateRange (min/maxOccurs: 0/1)


=item * PreferenceCriteria (min/maxOccurs: 0/1)


=item * ProducerInfo (min/maxOccurs: 0/1)


=item * MarksAndNumbers (min/maxOccurs: 0/1)


=item * NumberOfPackagesPerCommodity (min/maxOccurs: 0/1)


=item * ProductWeight (min/maxOccurs: 0/1)


=item * VehicleID (min/maxOccurs: 0/1)


=item * ScheduleB (min/maxOccurs: 0/1)


=item * ExportType (min/maxOccurs: 0/1)


=item * SEDTotalValue (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::ShipTypes::ProductType
   Description =>  $some_value, # string
   Unit =>  { # Shipment::UPS::WSDL::ShipTypes::UnitType
     Number =>  $some_value, # string
     UnitOfMeasurement =>  { # Shipment::UPS::WSDL::ShipTypes::UnitOfMeasurementType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Value =>  $some_value, # string
   },
   CommodityCode =>  $some_value, # string
   PartNumber =>  $some_value, # string
   OriginCountryCode =>  $some_value, # string
   JointProductionIndicator =>  $some_value, # string
   NetCostCode =>  $some_value, # string
   NetCostDateRange =>  { # Shipment::UPS::WSDL::ShipTypes::NetCostDateType
     BeginDate =>  $some_value, # string
     EndDate =>  $some_value, # string
   },
   PreferenceCriteria =>  $some_value, # string
   ProducerInfo =>  $some_value, # string
   MarksAndNumbers =>  $some_value, # string
   NumberOfPackagesPerCommodity =>  $some_value, # string
   ProductWeight =>  { # Shipment::UPS::WSDL::ShipTypes::ProductWeightType
     UnitOfMeasurement => {}, # Shipment::UPS::WSDL::ShipTypes::UnitOfMeasurementType
     Weight =>  $some_value, # string
   },
   VehicleID =>  $some_value, # string
   ScheduleB =>  { # Shipment::UPS::WSDL::ShipTypes::ScheduleBType
     Number =>  $some_value, # string
     Quantity =>  $some_value, # string
     UnitOfMeasurement => {}, # Shipment::UPS::WSDL::ShipTypes::UnitOfMeasurementType
   },
   ExportType =>  $some_value, # string
   SEDTotalValue =>  $some_value, # string
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

