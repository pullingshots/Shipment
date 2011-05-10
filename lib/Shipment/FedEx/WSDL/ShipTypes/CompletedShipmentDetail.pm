package Shipment::FedEx::WSDL::ShipTypes::CompletedShipmentDetail;
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

my %UsDomestic_of :ATTR(:get<UsDomestic>);
my %CarrierCode_of :ATTR(:get<CarrierCode>);
my %MasterTrackingId_of :ATTR(:get<MasterTrackingId>);
my %ServiceTypeDescription_of :ATTR(:get<ServiceTypeDescription>);
my %PackagingDescription_of :ATTR(:get<PackagingDescription>);
my %RoutingDetail_of :ATTR(:get<RoutingDetail>);
my %AccessDetail_of :ATTR(:get<AccessDetail>);
my %TagDetail_of :ATTR(:get<TagDetail>);
my %SmartPostDetail_of :ATTR(:get<SmartPostDetail>);
my %ShipmentRating_of :ATTR(:get<ShipmentRating>);
my %CodReturnDetail_of :ATTR(:get<CodReturnDetail>);
my %CompletedHoldAtLocationDetail_of :ATTR(:get<CompletedHoldAtLocationDetail>);
my %IneligibleForMoneyBackGuarantee_of :ATTR(:get<IneligibleForMoneyBackGuarantee>);
my %ExportComplianceStatement_of :ATTR(:get<ExportComplianceStatement>);
my %CompletedEtdDetail_of :ATTR(:get<CompletedEtdDetail>);
my %ShipmentDocuments_of :ATTR(:get<ShipmentDocuments>);
my %CompletedPackageDetails_of :ATTR(:get<CompletedPackageDetails>);

__PACKAGE__->_factory(
    [ qw(        UsDomestic
        CarrierCode
        MasterTrackingId
        ServiceTypeDescription
        PackagingDescription
        RoutingDetail
        AccessDetail
        TagDetail
        SmartPostDetail
        ShipmentRating
        CodReturnDetail
        CompletedHoldAtLocationDetail
        IneligibleForMoneyBackGuarantee
        ExportComplianceStatement
        CompletedEtdDetail
        ShipmentDocuments
        CompletedPackageDetails

    ) ],
    {
        'UsDomestic' => \%UsDomestic_of,
        'CarrierCode' => \%CarrierCode_of,
        'MasterTrackingId' => \%MasterTrackingId_of,
        'ServiceTypeDescription' => \%ServiceTypeDescription_of,
        'PackagingDescription' => \%PackagingDescription_of,
        'RoutingDetail' => \%RoutingDetail_of,
        'AccessDetail' => \%AccessDetail_of,
        'TagDetail' => \%TagDetail_of,
        'SmartPostDetail' => \%SmartPostDetail_of,
        'ShipmentRating' => \%ShipmentRating_of,
        'CodReturnDetail' => \%CodReturnDetail_of,
        'CompletedHoldAtLocationDetail' => \%CompletedHoldAtLocationDetail_of,
        'IneligibleForMoneyBackGuarantee' => \%IneligibleForMoneyBackGuarantee_of,
        'ExportComplianceStatement' => \%ExportComplianceStatement_of,
        'CompletedEtdDetail' => \%CompletedEtdDetail_of,
        'ShipmentDocuments' => \%ShipmentDocuments_of,
        'CompletedPackageDetails' => \%CompletedPackageDetails_of,
    },
    {
        'UsDomestic' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'CarrierCode' => 'Shipment::FedEx::WSDL::ShipTypes::CarrierCodeType',
        'MasterTrackingId' => 'Shipment::FedEx::WSDL::ShipTypes::TrackingId',
        'ServiceTypeDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PackagingDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'RoutingDetail' => 'Shipment::FedEx::WSDL::ShipTypes::ShipmentRoutingDetail',
        'AccessDetail' => 'Shipment::FedEx::WSDL::ShipTypes::PendingShipmentAccessDetail',
        'TagDetail' => 'Shipment::FedEx::WSDL::ShipTypes::CompletedTagDetail',
        'SmartPostDetail' => 'Shipment::FedEx::WSDL::ShipTypes::CompletedSmartPostDetail',
        'ShipmentRating' => 'Shipment::FedEx::WSDL::ShipTypes::ShipmentRating',
        'CodReturnDetail' => 'Shipment::FedEx::WSDL::ShipTypes::CodReturnShipmentDetail',
        'CompletedHoldAtLocationDetail' => 'Shipment::FedEx::WSDL::ShipTypes::CompletedHoldAtLocationDetail',
        'IneligibleForMoneyBackGuarantee' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'ExportComplianceStatement' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CompletedEtdDetail' => 'Shipment::FedEx::WSDL::ShipTypes::CompletedEtdDetail',
        'ShipmentDocuments' => 'Shipment::FedEx::WSDL::ShipTypes::ShippingDocument',
        'CompletedPackageDetails' => 'Shipment::FedEx::WSDL::ShipTypes::CompletedPackageDetail',
    },
    {

        'UsDomestic' => 'UsDomestic',
        'CarrierCode' => 'CarrierCode',
        'MasterTrackingId' => 'MasterTrackingId',
        'ServiceTypeDescription' => 'ServiceTypeDescription',
        'PackagingDescription' => 'PackagingDescription',
        'RoutingDetail' => 'RoutingDetail',
        'AccessDetail' => 'AccessDetail',
        'TagDetail' => 'TagDetail',
        'SmartPostDetail' => 'SmartPostDetail',
        'ShipmentRating' => 'ShipmentRating',
        'CodReturnDetail' => 'CodReturnDetail',
        'CompletedHoldAtLocationDetail' => 'CompletedHoldAtLocationDetail',
        'IneligibleForMoneyBackGuarantee' => 'IneligibleForMoneyBackGuarantee',
        'ExportComplianceStatement' => 'ExportComplianceStatement',
        'CompletedEtdDetail' => 'CompletedEtdDetail',
        'ShipmentDocuments' => 'ShipmentDocuments',
        'CompletedPackageDetails' => 'CompletedPackageDetails',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::CompletedShipmentDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CompletedShipmentDetail from the namespace http://fedex.com/ws/ship/v9.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * UsDomestic (min/maxOccurs: 0/1)


=item * CarrierCode (min/maxOccurs: 0/1)


=item * MasterTrackingId (min/maxOccurs: 0/1)


=item * ServiceTypeDescription (min/maxOccurs: 0/1)


=item * PackagingDescription (min/maxOccurs: 0/1)


=item * RoutingDetail (min/maxOccurs: 0/1)


=item * AccessDetail (min/maxOccurs: 0/1)


=item * TagDetail (min/maxOccurs: 0/1)


=item * SmartPostDetail (min/maxOccurs: 0/1)


=item * ShipmentRating (min/maxOccurs: 0/1)


=item * CodReturnDetail (min/maxOccurs: 0/1)


=item * CompletedHoldAtLocationDetail (min/maxOccurs: 0/1)


=item * IneligibleForMoneyBackGuarantee (min/maxOccurs: 0/1)


=item * ExportComplianceStatement (min/maxOccurs: 0/1)


=item * CompletedEtdDetail (min/maxOccurs: 0/1)


=item * ShipmentDocuments (min/maxOccurs: 0/unbounded)


=item * CompletedPackageDetails (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::CompletedShipmentDetail
   UsDomestic =>  $some_value, # boolean
   CarrierCode => $some_value, # CarrierCodeType
   MasterTrackingId =>  { # Shipment::FedEx::WSDL::ShipTypes::TrackingId
     TrackingIdType => $some_value, # TrackingIdType
     FormId =>  $some_value, # string
     UspsApplicationId =>  $some_value, # string
     TrackingNumber =>  $some_value, # string
   },
   ServiceTypeDescription =>  $some_value, # string
   PackagingDescription =>  $some_value, # string
   RoutingDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ShipmentRoutingDetail
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
   AccessDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::PendingShipmentAccessDetail
     EmailLabelUrl =>  $some_value, # string
     UserId =>  $some_value, # string
     Password =>  $some_value, # string
     ExpirationTimestamp =>  $some_value, # dateTime
   },
   TagDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CompletedTagDetail
     ConfirmationNumber =>  $some_value, # string
     AccessTime =>  $some_value, # duration
     CutoffTime =>  $some_value, # time
     Location =>  $some_value, # string
     DeliveryCommitment =>  $some_value, # dateTime
     DispatchDate =>  $some_value, # date
   },
   SmartPostDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CompletedSmartPostDetail
     PickUpCarrier => $some_value, # CarrierCodeType
     Machinable =>  $some_value, # boolean
   },
   ShipmentRating =>  { # Shipment::FedEx::WSDL::ShipTypes::ShipmentRating
     ActualRateType => $some_value, # ReturnedRateType
     EffectiveNetDiscount =>  { # Shipment::FedEx::WSDL::ShipTypes::Money
       Currency =>  $some_value, # string
       Amount =>  $some_value, # decimal
     },
     ShipmentRateDetails =>  { # Shipment::FedEx::WSDL::ShipTypes::ShipmentRateDetail
       RateType => $some_value, # ReturnedRateType
       RateScale =>  $some_value, # string
       RateZone =>  $some_value, # string
       PricingCode => $some_value, # PricingCodeType
       RatedWeightMethod => $some_value, # RatedWeightMethod
       MinimumChargeType => $some_value, # MinimumChargeType
       CurrencyExchangeRate =>  { # Shipment::FedEx::WSDL::ShipTypes::CurrencyExchangeRate
         FromCurrency =>  $some_value, # string
         IntoCurrency =>  $some_value, # string
         Rate =>  $some_value, # decimal
       },
       SpecialRatingApplied => $some_value, # SpecialRatingAppliedType
       DimDivisor =>  $some_value, # nonNegativeInteger
       DimDivisorType => $some_value, # RateDimensionalDivisorType
       FuelSurchargePercent =>  $some_value, # decimal
       TotalBillingWeight =>  { # Shipment::FedEx::WSDL::ShipTypes::Weight
         Units => $some_value, # WeightUnits
         Value =>  $some_value, # decimal
       },
       TotalDimWeight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
       TotalBaseCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalFreightDiscounts => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalNetFreight => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalSurcharges => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalNetFedExCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalTaxes => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalNetCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalRebates => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalDutiesAndTaxes => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TotalNetChargeWithDutiesAndTaxes => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       FreightRateDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightRateDetail
         QuoteNumber =>  $some_value, # string
         BaseCharges =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightBaseCharge
           FreightClass => $some_value, # FreightClassType
           RatedAsClass => $some_value, # FreightClassType
           NmfcCode =>  $some_value, # string
           Description =>  $some_value, # string
           Weight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
           ChargeRate => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
           ChargeBasis => $some_value, # FreightChargeBasisType
           ExtendedAmount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
         },
         Notations =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightRateNotation
           Code =>  $some_value, # string
           Description =>  $some_value, # string
         },
       },
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
       DutiesAndTaxes =>  { # Shipment::FedEx::WSDL::ShipTypes::EdtCommodityTax
         HarmonizedCode =>  $some_value, # string
         Taxes =>  { # Shipment::FedEx::WSDL::ShipTypes::EdtTaxDetail
           TaxType => $some_value, # EdtTaxType
           EffectiveDate =>  $some_value, # date
           Name =>  $some_value, # string
           TaxableValue => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
           Description =>  $some_value, # string
           Formula =>  $some_value, # string
           Amount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
         },
       },
       VariableHandlingCharges =>  { # Shipment::FedEx::WSDL::ShipTypes::VariableHandlingCharges
         VariableHandlingCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
         TotalCustomerCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       },
       TotalVariableHandlingCharges => {}, # Shipment::FedEx::WSDL::ShipTypes::VariableHandlingCharges
     },
   },
   CodReturnDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CodReturnShipmentDetail
     CollectionAmount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     Handling =>  $some_value, # string
     ServiceTypeDescription =>  $some_value, # string
     PackagingDescription =>  $some_value, # string
     SecuredDescription =>  $some_value, # string
     Remitter =>  { # Shipment::FedEx::WSDL::ShipTypes::Party
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
     CodRecipient => {}, # Shipment::FedEx::WSDL::ShipTypes::Party
     CodRoutingDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::RoutingDetail
       ShipmentRoutingDetail => {}, # Shipment::FedEx::WSDL::ShipTypes::ShipmentRoutingDetail
       AstraDetails =>  { # Shipment::FedEx::WSDL::ShipTypes::RoutingAstraDetail
         TrackingId => {}, # Shipment::FedEx::WSDL::ShipTypes::TrackingId
         Barcode =>  { # Shipment::FedEx::WSDL::ShipTypes::StringBarcode
           Type => $some_value, # StringBarcodeType
           Value =>  $some_value, # string
         },
         AstraHandlingText =>  $some_value, # string
         AstraLabelElements =>  { # Shipment::FedEx::WSDL::ShipTypes::AstraLabelElement
           Number =>  $some_value, # int
           Content =>  $some_value, # string
         },
       },
     },
     Barcodes =>  { # Shipment::FedEx::WSDL::ShipTypes::PackageBarcodes
       BinaryBarcodes =>  { # Shipment::FedEx::WSDL::ShipTypes::BinaryBarcode
         Type => $some_value, # BinaryBarcodeType
         Value =>  $some_value, # base64Binary
       },
       StringBarcodes => {}, # Shipment::FedEx::WSDL::ShipTypes::StringBarcode
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
   },
   CompletedHoldAtLocationDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CompletedHoldAtLocationDetail
     HoldingLocation =>  { # Shipment::FedEx::WSDL::ShipTypes::ContactAndAddress
       Contact => {}, # Shipment::FedEx::WSDL::ShipTypes::Contact
       Address => {}, # Shipment::FedEx::WSDL::ShipTypes::Address
     },
     HoldingLocationType => $some_value, # FedExLocationType
   },
   IneligibleForMoneyBackGuarantee =>  $some_value, # boolean
   ExportComplianceStatement =>  $some_value, # string
   CompletedEtdDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CompletedEtdDetail
     FolderId =>  $some_value, # string
     UploadDocumentReferenceDetails =>  { # Shipment::FedEx::WSDL::ShipTypes::UploadDocumentReferenceDetail
       LineNumber =>  $some_value, # nonNegativeInteger
       CustomerReference =>  $some_value, # string
       DocumentProducer => $some_value, # UploadDocumentProducerType
       DocumentType => $some_value, # UploadDocumentType
       DocumentId =>  $some_value, # string
       DocumentIdProducer => $some_value, # UploadDocumentIdProducer
     },
   },
   ShipmentDocuments => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocument
   CompletedPackageDetails =>  { # Shipment::FedEx::WSDL::ShipTypes::CompletedPackageDetail
     SequenceNumber =>  $some_value, # positiveInteger
     TrackingIds => {}, # Shipment::FedEx::WSDL::ShipTypes::TrackingId
     GroupNumber =>  $some_value, # nonNegativeInteger
     OversizeClass => $some_value, # OversizeClassType
     PackageRating =>  { # Shipment::FedEx::WSDL::ShipTypes::PackageRating
       ActualRateType => $some_value, # ReturnedRateType
       EffectiveNetDiscount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       PackageRateDetails =>  { # Shipment::FedEx::WSDL::ShipTypes::PackageRateDetail
         RateType => $some_value, # ReturnedRateType
         RatedWeightMethod => $some_value, # RatedWeightMethod
         MinimumChargeType => $some_value, # MinimumChargeType
         BillingWeight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
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
         FreightDiscounts => {}, # Shipment::FedEx::WSDL::ShipTypes::RateDiscount
         Rebates => {}, # Shipment::FedEx::WSDL::ShipTypes::Rebate
         Surcharges => {}, # Shipment::FedEx::WSDL::ShipTypes::Surcharge
         Taxes => {}, # Shipment::FedEx::WSDL::ShipTypes::Tax
         VariableHandlingCharges => {}, # Shipment::FedEx::WSDL::ShipTypes::VariableHandlingCharges
       },
     },
     GroundServiceCode =>  $some_value, # string
     Barcodes => {}, # Shipment::FedEx::WSDL::ShipTypes::PackageBarcodes
     AstraHandlingText =>  $some_value, # string
     AstraLabelElements => {}, # Shipment::FedEx::WSDL::ShipTypes::AstraLabelElement
     Label => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocument
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
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

