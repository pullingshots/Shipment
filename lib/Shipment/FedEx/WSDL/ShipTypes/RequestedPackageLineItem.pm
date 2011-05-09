package Shipment::FedEx::WSDL::ShipTypes::RequestedPackageLineItem;
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

my %SequenceNumber_of :ATTR(:get<SequenceNumber>);
my %GroupNumber_of :ATTR(:get<GroupNumber>);
my %GroupPackageCount_of :ATTR(:get<GroupPackageCount>);
my %VariableHandlingChargeDetail_of :ATTR(:get<VariableHandlingChargeDetail>);
my %InsuredValue_of :ATTR(:get<InsuredValue>);
my %Weight_of :ATTR(:get<Weight>);
my %Dimensions_of :ATTR(:get<Dimensions>);
my %PhysicalPackaging_of :ATTR(:get<PhysicalPackaging>);
my %ItemDescription_of :ATTR(:get<ItemDescription>);
my %CustomerReferences_of :ATTR(:get<CustomerReferences>);
my %SpecialServicesRequested_of :ATTR(:get<SpecialServicesRequested>);
my %ContentRecords_of :ATTR(:get<ContentRecords>);

__PACKAGE__->_factory(
    [ qw(        SequenceNumber
        GroupNumber
        GroupPackageCount
        VariableHandlingChargeDetail
        InsuredValue
        Weight
        Dimensions
        PhysicalPackaging
        ItemDescription
        CustomerReferences
        SpecialServicesRequested
        ContentRecords

    ) ],
    {
        'SequenceNumber' => \%SequenceNumber_of,
        'GroupNumber' => \%GroupNumber_of,
        'GroupPackageCount' => \%GroupPackageCount_of,
        'VariableHandlingChargeDetail' => \%VariableHandlingChargeDetail_of,
        'InsuredValue' => \%InsuredValue_of,
        'Weight' => \%Weight_of,
        'Dimensions' => \%Dimensions_of,
        'PhysicalPackaging' => \%PhysicalPackaging_of,
        'ItemDescription' => \%ItemDescription_of,
        'CustomerReferences' => \%CustomerReferences_of,
        'SpecialServicesRequested' => \%SpecialServicesRequested_of,
        'ContentRecords' => \%ContentRecords_of,
    },
    {
        'SequenceNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger',
        'GroupNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'GroupPackageCount' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'VariableHandlingChargeDetail' => 'Shipment::FedEx::WSDL::ShipTypes::VariableHandlingChargeDetail',
        'InsuredValue' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'Weight' => 'Shipment::FedEx::WSDL::ShipTypes::Weight',
        'Dimensions' => 'Shipment::FedEx::WSDL::ShipTypes::Dimensions',
        'PhysicalPackaging' => 'Shipment::FedEx::WSDL::ShipTypes::PhysicalPackagingType',
        'ItemDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CustomerReferences' => 'Shipment::FedEx::WSDL::ShipTypes::CustomerReference',
        'SpecialServicesRequested' => 'Shipment::FedEx::WSDL::ShipTypes::PackageSpecialServicesRequested',
        'ContentRecords' => 'Shipment::FedEx::WSDL::ShipTypes::ContentRecord',
    },
    {

        'SequenceNumber' => 'SequenceNumber',
        'GroupNumber' => 'GroupNumber',
        'GroupPackageCount' => 'GroupPackageCount',
        'VariableHandlingChargeDetail' => 'VariableHandlingChargeDetail',
        'InsuredValue' => 'InsuredValue',
        'Weight' => 'Weight',
        'Dimensions' => 'Dimensions',
        'PhysicalPackaging' => 'PhysicalPackaging',
        'ItemDescription' => 'ItemDescription',
        'CustomerReferences' => 'CustomerReferences',
        'SpecialServicesRequested' => 'SpecialServicesRequested',
        'ContentRecords' => 'ContentRecords',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::RequestedPackageLineItem

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
RequestedPackageLineItem from the namespace http://fedex.com/ws/ship/v9.

This class rationalizes RequestedPackage and RequestedPackageSummary from previous interfaces. The way in which it is uses within a RequestedShipment depends on the RequestedPackageDetailType value specified for that shipment.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * SequenceNumber (min/maxOccurs: 0/1)


=item * GroupNumber (min/maxOccurs: 0/1)


=item * GroupPackageCount (min/maxOccurs: 0/1)


=item * VariableHandlingChargeDetail (min/maxOccurs: 0/1)


=item * InsuredValue (min/maxOccurs: 0/1)


=item * Weight (min/maxOccurs: 0/1)


=item * Dimensions (min/maxOccurs: 0/1)


=item * PhysicalPackaging (min/maxOccurs: 0/1)


=item * ItemDescription (min/maxOccurs: 0/1)


=item * CustomerReferences (min/maxOccurs: 0/3)


=item * SpecialServicesRequested (min/maxOccurs: 0/1)


=item * ContentRecords (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::RequestedPackageLineItem
   SequenceNumber =>  $some_value, # positiveInteger
   GroupNumber =>  $some_value, # nonNegativeInteger
   GroupPackageCount =>  $some_value, # nonNegativeInteger
   VariableHandlingChargeDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::VariableHandlingChargeDetail
     VariableHandlingChargeType => $some_value, # VariableHandlingChargeType
     FixedValue =>  { # Shipment::FedEx::WSDL::ShipTypes::Money
       Currency =>  $some_value, # string
       Amount =>  $some_value, # decimal
     },
     PercentValue =>  $some_value, # decimal
   },
   InsuredValue => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
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
   PhysicalPackaging => $some_value, # PhysicalPackagingType
   ItemDescription =>  $some_value, # string
   CustomerReferences =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomerReference
     CustomerReferenceType => $some_value, # CustomerReferenceType
     Value =>  $some_value, # string
   },
   SpecialServicesRequested =>  { # Shipment::FedEx::WSDL::ShipTypes::PackageSpecialServicesRequested
     SpecialServiceTypes => $some_value, # PackageSpecialServiceType
     CodDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CodDetail
       CodCollectionAmount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       AddTransportationCharges => $some_value, # CodAddTransportationChargesType
       CollectionType => $some_value, # CodCollectionType
       CodRecipient =>  { # Shipment::FedEx::WSDL::ShipTypes::Party
         AccountNumber =>  $some_value, # string
         Tins =>  { # Shipment::FedEx::WSDL::ShipTypes::TaxpayerIdentification
           TinType => $some_value, # TinType
           Number =>  $some_value, # string
           Usage =>  $some_value, # string
         },
         Contact =>  { # Shipment::FedEx::WSDL::ShipTypes::Contact
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
         Address =>  { # Shipment::FedEx::WSDL::ShipTypes::Address
           StreetLines =>  $some_value, # string
           City =>  $some_value, # string
           StateOrProvinceCode =>  $some_value, # string
           PostalCode =>  $some_value, # string
           UrbanizationCode =>  $some_value, # string
           CountryCode =>  $some_value, # string
           Residential =>  $some_value, # boolean
         },
       },
       ReferenceIndicator => $some_value, # CodReturnReferenceIndicatorType
     },
     DangerousGoodsDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::DangerousGoodsDetail
       Accessibility => $some_value, # DangerousGoodsAccessibilityType
       CargoAircraftOnly =>  $some_value, # boolean
       Options => $some_value, # HazardousCommodityOptionType
       HazardousCommodities =>  { # Shipment::FedEx::WSDL::ShipTypes::HazardousCommodityContent
         Description =>  { # Shipment::FedEx::WSDL::ShipTypes::HazardousCommodityDescription
           Id =>  $some_value, # string
           PackingGroup => $some_value, # HazardousCommodityPackingGroupType
           ProperShippingName =>  $some_value, # string
           TechnicalName =>  $some_value, # string
           HazardClass =>  $some_value, # string
           SubsidiaryClasses =>  $some_value, # string
           LabelText =>  $some_value, # string
         },
         Quantity =>  { # Shipment::FedEx::WSDL::ShipTypes::HazardousCommodityQuantityDetail
           Amount =>  $some_value, # decimal
           Units =>  $some_value, # string
         },
         Options =>  { # Shipment::FedEx::WSDL::ShipTypes::HazardousCommodityOptionDetail
           LabelTextOption => $some_value, # HazardousCommodityLabelTextOptionType
           CustomerSuppliedLabelText =>  $some_value, # string
         },
       },
       Packaging =>  { # Shipment::FedEx::WSDL::ShipTypes::HazardousCommodityPackagingDetail
         Count =>  $some_value, # nonNegativeInteger
         Units =>  $some_value, # string
       },
       EmergencyContactNumber =>  $some_value, # string
       Offeror =>  $some_value, # string
     },
     DryIceWeight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
     SignatureOptionDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::SignatureOptionDetail
       OptionType => $some_value, # SignatureOptionType
       SignatureReleaseNumber =>  $some_value, # string
     },
     PriorityAlertDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::PriorityAlertDetail
       Content =>  $some_value, # string
     },
   },
   ContentRecords =>  { # Shipment::FedEx::WSDL::ShipTypes::ContentRecord
     PartNumber =>  $some_value, # string
     ItemNumber =>  $some_value, # string
     ReceivedQuantity =>  $some_value, # nonNegativeInteger
     Description =>  $some_value, # string
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

