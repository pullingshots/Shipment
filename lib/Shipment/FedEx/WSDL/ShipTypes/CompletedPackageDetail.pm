package Shipment::FedEx::WSDL::ShipTypes::CompletedPackageDetail;
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
my %TrackingIds_of :ATTR(:get<TrackingIds>);
my %GroupNumber_of :ATTR(:get<GroupNumber>);
my %OversizeClass_of :ATTR(:get<OversizeClass>);
my %PackageRating_of :ATTR(:get<PackageRating>);
my %GroundServiceCode_of :ATTR(:get<GroundServiceCode>);
my %Barcodes_of :ATTR(:get<Barcodes>);
my %AstraHandlingText_of :ATTR(:get<AstraHandlingText>);
my %AstraLabelElements_of :ATTR(:get<AstraLabelElements>);
my %Label_of :ATTR(:get<Label>);
my %PackageDocuments_of :ATTR(:get<PackageDocuments>);
my %CodReturnDetail_of :ATTR(:get<CodReturnDetail>);
my %SignatureOption_of :ATTR(:get<SignatureOption>);
my %HazardousCommodities_of :ATTR(:get<HazardousCommodities>);

__PACKAGE__->_factory(
    [ qw(        SequenceNumber
        TrackingIds
        GroupNumber
        OversizeClass
        PackageRating
        GroundServiceCode
        Barcodes
        AstraHandlingText
        AstraLabelElements
        Label
        PackageDocuments
        CodReturnDetail
        SignatureOption
        HazardousCommodities

    ) ],
    {
        'SequenceNumber' => \%SequenceNumber_of,
        'TrackingIds' => \%TrackingIds_of,
        'GroupNumber' => \%GroupNumber_of,
        'OversizeClass' => \%OversizeClass_of,
        'PackageRating' => \%PackageRating_of,
        'GroundServiceCode' => \%GroundServiceCode_of,
        'Barcodes' => \%Barcodes_of,
        'AstraHandlingText' => \%AstraHandlingText_of,
        'AstraLabelElements' => \%AstraLabelElements_of,
        'Label' => \%Label_of,
        'PackageDocuments' => \%PackageDocuments_of,
        'CodReturnDetail' => \%CodReturnDetail_of,
        'SignatureOption' => \%SignatureOption_of,
        'HazardousCommodities' => \%HazardousCommodities_of,
    },
    {
        'SequenceNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger',
        'TrackingIds' => 'Shipment::FedEx::WSDL::ShipTypes::TrackingId',
        'GroupNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'OversizeClass' => 'Shipment::FedEx::WSDL::ShipTypes::OversizeClassType',
        'PackageRating' => 'Shipment::FedEx::WSDL::ShipTypes::PackageRating',
        'GroundServiceCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Barcodes' => 'Shipment::FedEx::WSDL::ShipTypes::PackageBarcodes',
        'AstraHandlingText' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'AstraLabelElements' => 'Shipment::FedEx::WSDL::ShipTypes::AstraLabelElement',
        'Label' => 'Shipment::FedEx::WSDL::ShipTypes::ShippingDocument',
        'PackageDocuments' => 'Shipment::FedEx::WSDL::ShipTypes::ShippingDocument',
        'CodReturnDetail' => 'Shipment::FedEx::WSDL::ShipTypes::CodReturnPackageDetail',
        'SignatureOption' => 'Shipment::FedEx::WSDL::ShipTypes::SignatureOptionType',
        'HazardousCommodities' => 'Shipment::FedEx::WSDL::ShipTypes::ValidatedHazardousCommodityContent',
    },
    {

        'SequenceNumber' => 'SequenceNumber',
        'TrackingIds' => 'TrackingIds',
        'GroupNumber' => 'GroupNumber',
        'OversizeClass' => 'OversizeClass',
        'PackageRating' => 'PackageRating',
        'GroundServiceCode' => 'GroundServiceCode',
        'Barcodes' => 'Barcodes',
        'AstraHandlingText' => 'AstraHandlingText',
        'AstraLabelElements' => 'AstraLabelElements',
        'Label' => 'Label',
        'PackageDocuments' => 'PackageDocuments',
        'CodReturnDetail' => 'CodReturnDetail',
        'SignatureOption' => 'SignatureOption',
        'HazardousCommodities' => 'HazardousCommodities',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::CompletedPackageDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CompletedPackageDetail from the namespace http://fedex.com/ws/ship/v9.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * SequenceNumber (min/maxOccurs: 0/1)


=item * TrackingIds (min/maxOccurs: 0/unbounded)


=item * GroupNumber (min/maxOccurs: 0/1)


=item * OversizeClass (min/maxOccurs: 0/1)


=item * PackageRating (min/maxOccurs: 0/1)


=item * GroundServiceCode (min/maxOccurs: 0/1)


=item * Barcodes (min/maxOccurs: 0/1)


=item * AstraHandlingText (min/maxOccurs: 0/1)


=item * AstraLabelElements (min/maxOccurs: 0/unbounded)


=item * Label (min/maxOccurs: 0/1)


=item * PackageDocuments (min/maxOccurs: 0/unbounded)


=item * CodReturnDetail (min/maxOccurs: 0/1)


=item * SignatureOption (min/maxOccurs: 0/1)


=item * HazardousCommodities (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::CompletedPackageDetail
   SequenceNumber =>  $some_value, # positiveInteger
   TrackingIds =>  { # Shipment::FedEx::WSDL::ShipTypes::TrackingId
     TrackingIdType => $some_value, # TrackingIdType
     FormId =>  $some_value, # string
     UspsApplicationId =>  $some_value, # string
     TrackingNumber =>  $some_value, # string
   },
   GroupNumber =>  $some_value, # nonNegativeInteger
   OversizeClass => $some_value, # OversizeClassType
   PackageRating =>  { # Shipment::FedEx::WSDL::ShipTypes::PackageRating
     ActualRateType => $some_value, # ReturnedRateType
     EffectiveNetDiscount =>  { # Shipment::FedEx::WSDL::ShipTypes::Money
       Currency =>  $some_value, # string
       Amount =>  $some_value, # decimal
     },
     PackageRateDetails =>  { # Shipment::FedEx::WSDL::ShipTypes::PackageRateDetail
       RateType => $some_value, # ReturnedRateType
       RatedWeightMethod => $some_value, # RatedWeightMethod
       MinimumChargeType => $some_value, # MinimumChargeType
       BillingWeight =>  { # Shipment::FedEx::WSDL::ShipTypes::Weight
         Units => $some_value, # WeightUnits
         Value =>  $some_value, # decimal
       },
       DimWeight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
       OversizeWeight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
       BaseCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalFreightDiscounts => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       NetFreight => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalSurcharges => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       NetFedExCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalTaxes => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       NetCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalRebates => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       FreightDiscounts =>  { # Shipment::FedEx::WSDL::ShipTypes::RateDiscount
         RateDiscountType => $some_value, # RateDiscountType
         Description =>  $some_value, # string
         Amount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
         Percent =>  $some_value, # decimal
       },
       Rebates =>  { # Shipment::FedEx::WSDL::ShipTypes::Rebate
         RebateType => $some_value, # RebateType
         Description =>  $some_value, # string
         Amount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
         Percent =>  $some_value, # decimal
       },
       Surcharges =>  { # Shipment::FedEx::WSDL::ShipTypes::Surcharge
         SurchargeType => $some_value, # SurchargeType
         Level => $some_value, # SurchargeLevelType
         Description =>  $some_value, # string
         Amount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       },
       Taxes =>  { # Shipment::FedEx::WSDL::ShipTypes::Tax
         TaxType => $some_value, # TaxType
         Description =>  $some_value, # string
         Amount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       },
       VariableHandlingCharges =>  { # Shipment::FedEx::WSDL::ShipTypes::VariableHandlingCharges
         VariableHandlingCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
         TotalCustomerCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       },
     },
   },
   GroundServiceCode =>  $some_value, # string
   Barcodes =>  { # Shipment::FedEx::WSDL::ShipTypes::PackageBarcodes
     BinaryBarcodes =>  { # Shipment::FedEx::WSDL::ShipTypes::BinaryBarcode
       Type => $some_value, # BinaryBarcodeType
       Value =>  $some_value, # base64Binary
     },
     StringBarcodes =>  { # Shipment::FedEx::WSDL::ShipTypes::StringBarcode
       Type => $some_value, # StringBarcodeType
       Value =>  $some_value, # string
     },
   },
   AstraHandlingText =>  $some_value, # string
   AstraLabelElements =>  { # Shipment::FedEx::WSDL::ShipTypes::AstraLabelElement
     Number =>  $some_value, # int
     Content =>  $some_value, # string
   },
   Label =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocument
     Type => $some_value, # ReturnedShippingDocumentType
     Grouping => $some_value, # ShippingDocumentGroupingType
     ShippingDocumentDisposition => $some_value, # ShippingDocumentDispositionType
     AccessReference =>  $some_value, # string
     Resolution =>  $some_value, # nonNegativeInteger
     CopiesToPrint =>  $some_value, # nonNegativeInteger
     Parts =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentPart
       DocumentPartSequenceNumber =>  $some_value, # positiveInteger
       Image =>  $some_value, # base64Binary
     },
   },
   PackageDocuments => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocument
   CodReturnDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CodReturnPackageDetail
     CollectionAmount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     Electronic =>  $some_value, # boolean
     Barcodes => {}, # Shipment::FedEx::WSDL::ShipTypes::PackageBarcodes
     Label => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocument
   },
   SignatureOption => $some_value, # SignatureOptionType
   HazardousCommodities =>  { # Shipment::FedEx::WSDL::ShipTypes::ValidatedHazardousCommodityContent
     Description =>  { # Shipment::FedEx::WSDL::ShipTypes::ValidatedHazardousCommodityDescription
       Id =>  $some_value, # string
       PackingGroup => $some_value, # HazardousCommodityPackingGroupType
       ProperShippingName =>  $some_value, # string
       ProperShippingNameAndDescription =>  $some_value, # string
       TechnicalName =>  $some_value, # string
       HazardClass =>  $some_value, # string
       SubsidiaryClasses =>  $some_value, # string
       Symbols =>  $some_value, # string
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
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

