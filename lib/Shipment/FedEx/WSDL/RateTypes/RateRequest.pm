package Shipment::FedEx::WSDL::RateTypes::RateRequest;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/rate/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %WebAuthenticationDetail_of :ATTR(:get<WebAuthenticationDetail>);
my %ClientDetail_of :ATTR(:get<ClientDetail>);
my %TransactionDetail_of :ATTR(:get<TransactionDetail>);
my %Version_of :ATTR(:get<Version>);
my %ReturnTransitAndCommit_of :ATTR(:get<ReturnTransitAndCommit>);
my %CarrierCodes_of :ATTR(:get<CarrierCodes>);
my %VariableOptions_of :ATTR(:get<VariableOptions>);
my %RequestedShipment_of :ATTR(:get<RequestedShipment>);

__PACKAGE__->_factory(
    [ qw(        WebAuthenticationDetail
        ClientDetail
        TransactionDetail
        Version
        ReturnTransitAndCommit
        CarrierCodes
        VariableOptions
        RequestedShipment

    ) ],
    {
        'WebAuthenticationDetail' => \%WebAuthenticationDetail_of,
        'ClientDetail' => \%ClientDetail_of,
        'TransactionDetail' => \%TransactionDetail_of,
        'Version' => \%Version_of,
        'ReturnTransitAndCommit' => \%ReturnTransitAndCommit_of,
        'CarrierCodes' => \%CarrierCodes_of,
        'VariableOptions' => \%VariableOptions_of,
        'RequestedShipment' => \%RequestedShipment_of,
    },
    {
        'WebAuthenticationDetail' => 'Shipment::FedEx::WSDL::RateTypes::WebAuthenticationDetail',
        'ClientDetail' => 'Shipment::FedEx::WSDL::RateTypes::ClientDetail',
        'TransactionDetail' => 'Shipment::FedEx::WSDL::RateTypes::TransactionDetail',
        'Version' => 'Shipment::FedEx::WSDL::RateTypes::VersionId',
        'ReturnTransitAndCommit' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'CarrierCodes' => 'Shipment::FedEx::WSDL::RateTypes::CarrierCodeType',
        'VariableOptions' => 'Shipment::FedEx::WSDL::RateTypes::ServiceOptionType',
        'RequestedShipment' => 'Shipment::FedEx::WSDL::RateTypes::RequestedShipment',
    },
    {

        'WebAuthenticationDetail' => 'WebAuthenticationDetail',
        'ClientDetail' => 'ClientDetail',
        'TransactionDetail' => 'TransactionDetail',
        'Version' => 'Version',
        'ReturnTransitAndCommit' => 'ReturnTransitAndCommit',
        'CarrierCodes' => 'CarrierCodes',
        'VariableOptions' => 'VariableOptions',
        'RequestedShipment' => 'RequestedShipment',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::RateRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
RateRequest from the namespace http://fedex.com/ws/rate/v9.

Descriptive data sent to FedEx by a customer in order to rate a package/shipment.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * WebAuthenticationDetail (min/maxOccurs: 1/1)


=item * ClientDetail (min/maxOccurs: 1/1)


=item * TransactionDetail (min/maxOccurs: 0/1)


=item * Version (min/maxOccurs: 1/1)


=item * ReturnTransitAndCommit (min/maxOccurs: 0/1)


=item * CarrierCodes (min/maxOccurs: 0/unbounded)


=item * VariableOptions (min/maxOccurs: 0/unbounded)


=item * RequestedShipment (min/maxOccurs: 1/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::RateRequest
   WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::RateTypes::WebAuthenticationDetail
     UserCredential =>  { # Shipment::FedEx::WSDL::RateTypes::WebAuthenticationCredential
       Key =>  $some_value, # string
       Password =>  $some_value, # string
     },
   },
   ClientDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ClientDetail
     AccountNumber =>  $some_value, # string
     MeterNumber =>  $some_value, # string
     IntegratorId =>  $some_value, # string
     Region => $some_value, # ExpressRegionCode
     Localization =>  { # Shipment::FedEx::WSDL::RateTypes::Localization
       LanguageCode =>  $some_value, # string
       LocaleCode =>  $some_value, # string
     },
   },
   TransactionDetail =>  { # Shipment::FedEx::WSDL::RateTypes::TransactionDetail
     CustomerTransactionId =>  $some_value, # string
     Localization => {}, # Shipment::FedEx::WSDL::RateTypes::Localization
   },
   Version =>  { # Shipment::FedEx::WSDL::RateTypes::VersionId
     ServiceId =>  $some_value, # string
     Major =>  $some_value, # int
     Intermediate =>  $some_value, # int
     Minor =>  $some_value, # int
   },
   ReturnTransitAndCommit =>  $some_value, # boolean
   CarrierCodes => $some_value, # CarrierCodeType
   VariableOptions => $some_value, # ServiceOptionType
   RequestedShipment =>  { # Shipment::FedEx::WSDL::RateTypes::RequestedShipment
     ShipTimestamp =>  $some_value, # dateTime
     DropoffType => $some_value, # DropoffType
     ServiceType => $some_value, # ServiceType
     PackagingType => $some_value, # PackagingType
     TotalWeight =>  { # Shipment::FedEx::WSDL::RateTypes::Weight
       Units => $some_value, # WeightUnits
       Value =>  $some_value, # decimal
     },
     TotalInsuredValue =>  { # Shipment::FedEx::WSDL::RateTypes::Money
       Currency =>  $some_value, # string
       Amount =>  $some_value, # decimal
     },
     Shipper =>  { # Shipment::FedEx::WSDL::RateTypes::Party
       AccountNumber =>  $some_value, # string
       Tins =>  { # Shipment::FedEx::WSDL::RateTypes::TaxpayerIdentification
         TinType => $some_value, # TinType
         Number =>  $some_value, # string
         Usage =>  $some_value, # string
       },
       Contact =>  { # Shipment::FedEx::WSDL::RateTypes::Contact
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
       Address =>  { # Shipment::FedEx::WSDL::RateTypes::Address
         StreetLines =>  $some_value, # string
         City =>  $some_value, # string
         StateOrProvinceCode =>  $some_value, # string
         PostalCode =>  $some_value, # string
         UrbanizationCode =>  $some_value, # string
         CountryCode =>  $some_value, # string
         Residential =>  $some_value, # boolean
       },
     },
     Recipient => {}, # Shipment::FedEx::WSDL::RateTypes::Party
     RecipientLocationNumber =>  $some_value, # string
     Origin =>  { # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
       Contact => {}, # Shipment::FedEx::WSDL::RateTypes::Contact
       Address => {}, # Shipment::FedEx::WSDL::RateTypes::Address
     },
     ShippingChargesPayment =>  { # Shipment::FedEx::WSDL::RateTypes::Payment
       PaymentType => $some_value, # PaymentType
       Payor =>  { # Shipment::FedEx::WSDL::RateTypes::Payor
         AccountNumber =>  $some_value, # string
         CountryCode =>  $some_value, # string
       },
     },
     SpecialServicesRequested =>  { # Shipment::FedEx::WSDL::RateTypes::ShipmentSpecialServicesRequested
       SpecialServiceTypes => $some_value, # ShipmentSpecialServiceType
       CodDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CodDetail
         CodCollectionAmount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         AddTransportationCharges => $some_value, # CodAddTransportationChargesType
         CollectionType => $some_value, # CodCollectionType
         CodRecipient => {}, # Shipment::FedEx::WSDL::RateTypes::Party
         ReferenceIndicator => $some_value, # CodReturnReferenceIndicatorType
       },
       HoldAtLocationDetail =>  { # Shipment::FedEx::WSDL::RateTypes::HoldAtLocationDetail
         PhoneNumber =>  $some_value, # string
         LocationContactAndAddress => {}, # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
         LocationType => $some_value, # FedExLocationType
         LocationId =>  $some_value, # string
         LocationNumber =>  $some_value, # int
       },
       EMailNotificationDetail =>  { # Shipment::FedEx::WSDL::RateTypes::EMailNotificationDetail
         PersonalMessage =>  $some_value, # string
         Recipients =>  { # Shipment::FedEx::WSDL::RateTypes::EMailNotificationRecipient
           EMailNotificationRecipientType => $some_value, # EMailNotificationRecipientType
           EMailAddress =>  $some_value, # string
           NotifyOnShipment =>  $some_value, # boolean
           NotifyOnException =>  $some_value, # boolean
           NotifyOnDelivery =>  $some_value, # boolean
           Format => $some_value, # EMailNotificationFormatType
           Localization => {}, # Shipment::FedEx::WSDL::RateTypes::Localization
         },
       },
       ReturnShipmentDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ReturnShipmentDetail
         ReturnType => $some_value, # ReturnType
         Rma =>  { # Shipment::FedEx::WSDL::RateTypes::Rma
           Number =>  $some_value, # string
           Reason =>  $some_value, # string
         },
         ReturnEMailDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ReturnEMailDetail
           MerchantPhoneNumber =>  $some_value, # string
           AllowedSpecialServices => $some_value, # ReturnEMailAllowedSpecialServiceType
         },
       },
       PendingShipmentDetail =>  { # Shipment::FedEx::WSDL::RateTypes::PendingShipmentDetail
         Type => $some_value, # PendingShipmentType
         ExpirationDate =>  $some_value, # dateTime
         EmailLabelDetail =>  { # Shipment::FedEx::WSDL::RateTypes::EMailLabelDetail
           NotificationEMailAddress =>  $some_value, # string
           NotificationMessage =>  $some_value, # string
         },
       },
       ShipmentDryIceDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ShipmentDryIceDetail
         PackageCount =>  $some_value, # nonNegativeInteger
         TotalWeight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
       },
       HomeDeliveryPremiumDetail =>  { # Shipment::FedEx::WSDL::RateTypes::HomeDeliveryPremiumDetail
         HomeDeliveryPremiumType => $some_value, # HomeDeliveryPremiumType
         Date =>  $some_value, # date
         PhoneNumber =>  $some_value, # string
       },
       FlatbedTrailerDetail =>  { # Shipment::FedEx::WSDL::RateTypes::FlatbedTrailerDetail
         Options => $some_value, # FlatbedTrailerOption
       },
       FreightGuaranteeDetail =>  { # Shipment::FedEx::WSDL::RateTypes::FreightGuaranteeDetail
         Type => $some_value, # FreightGuaranteeType
         Date =>  $some_value, # date
         Time =>  $some_value, # time
       },
       EtdDetail =>  { # Shipment::FedEx::WSDL::RateTypes::EtdDetail
         RequestedDocumentCopies => $some_value, # RequestedShippingDocumentType
         Documents =>  { # Shipment::FedEx::WSDL::RateTypes::UploadDocumentDetail
           LineNumber =>  $some_value, # nonNegativeInteger
           CustomerReference =>  $some_value, # string
           DocumentProducer => $some_value, # UploadDocumentProducerType
           DocumentType => $some_value, # UploadDocumentType
           FileName =>  $some_value, # string
           DocumentContent =>  $some_value, # base64Binary
         },
         DocumentReferences =>  { # Shipment::FedEx::WSDL::RateTypes::UploadDocumentReferenceDetail
           LineNumber =>  $some_value, # nonNegativeInteger
           CustomerReference =>  $some_value, # string
           DocumentProducer => $some_value, # UploadDocumentProducerType
           DocumentType => $some_value, # UploadDocumentType
           DocumentId =>  $some_value, # string
           DocumentIdProducer => $some_value, # UploadDocumentIdProducer
         },
       },
       CustomDeliveryWindowDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CustomDeliveryWindowDetail
         Type => $some_value, # CustomDeliveryWindowType
         RequestTime =>  $some_value, # time
         RequestRange =>  { # Shipment::FedEx::WSDL::RateTypes::DateRange
           Begins =>  $some_value, # date
           Ends =>  $some_value, # date
         },
         RequestDate =>  $some_value, # date
       },
     },
     ExpressFreightDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ExpressFreightDetail
       PackingListEnclosed =>  $some_value, # boolean
       ShippersLoadAndCount =>  $some_value, # positiveInteger
       BookingConfirmationNumber =>  $some_value, # string
       ReferenceLabelRequested =>  $some_value, # boolean
       BeforeDeliveryContact =>  { # Shipment::FedEx::WSDL::RateTypes::ExpressFreightDetailContact
         Name =>  $some_value, # string
         Phone =>  $some_value, # string
       },
       UndeliverableContact => {}, # Shipment::FedEx::WSDL::RateTypes::ExpressFreightDetailContact
     },
     FreightShipmentDetail =>  { # Shipment::FedEx::WSDL::RateTypes::FreightShipmentDetail
       FedExFreightAccountNumber =>  $some_value, # string
       FedExFreightBillingContactAndAddress => {}, # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
       FedExNationalFreightAccountNumber =>  $some_value, # string
       FedExNationalFreightBillingContactAndAddress => {}, # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
       Role => $some_value, # FreightShipmentRoleType
       PaymentType => $some_value, # FreightAccountPaymentType
       DeclaredValuePerUnit => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       DeclaredValueUnits =>  $some_value, # string
       LiabilityCoverageDetail =>  { # Shipment::FedEx::WSDL::RateTypes::LiabilityCoverageDetail
         CoverageType => $some_value, # LiabilityCoverageType
         CoverageAmount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       },
       Coupons =>  $some_value, # string
       TotalHandlingUnits =>  $some_value, # nonNegativeInteger
       ClientDiscountPercent =>  $some_value, # decimal
       PalletWeight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
       ShipmentDimensions =>  { # Shipment::FedEx::WSDL::RateTypes::Dimensions
         Length => $some_value, # atomic
         Width => $some_value, # atomic
         Height => $some_value, # atomic
         Units => $some_value, # LinearUnits
       },
       Comment =>  $some_value, # string
       SpecialServicePayments =>  { # Shipment::FedEx::WSDL::RateTypes::FreightSpecialServicePayment
         SpecialService => $some_value, # ShipmentSpecialServiceType
         PaymentType => $some_value, # FreightAccountPaymentType
       },
       LineItems =>  { # Shipment::FedEx::WSDL::RateTypes::FreightShipmentLineItem
         FreightClass => $some_value, # FreightClassType
         Packaging => $some_value, # PhysicalPackagingType
         Description =>  $some_value, # string
         Weight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
         Dimensions => {}, # Shipment::FedEx::WSDL::RateTypes::Dimensions
         Volume =>  { # Shipment::FedEx::WSDL::RateTypes::Volume
           Units => $some_value, # VolumeUnits
           Value =>  $some_value, # decimal
         },
       },
     },
     DeliveryInstructions =>  $some_value, # string
     VariableHandlingChargeDetail =>  { # Shipment::FedEx::WSDL::RateTypes::VariableHandlingChargeDetail
       VariableHandlingChargeType => $some_value, # VariableHandlingChargeType
       FixedValue => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       PercentValue =>  $some_value, # decimal
     },
     CustomsClearanceDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CustomsClearanceDetail
       Broker => {}, # Shipment::FedEx::WSDL::RateTypes::Party
       ClearanceBrokerage => $some_value, # ClearanceBrokerageType
       ImporterOfRecord => {}, # Shipment::FedEx::WSDL::RateTypes::Party
       RecipientCustomsId =>  { # Shipment::FedEx::WSDL::RateTypes::RecipientCustomsId
         Type => $some_value, # RecipientCustomsIdType
         Value =>  $some_value, # string
       },
       DutiesPayment => {}, # Shipment::FedEx::WSDL::RateTypes::Payment
       DocumentContent => $some_value, # InternationalDocumentContentType
       CustomsValue => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       FreightOnValue => $some_value, # FreightOnValueType
       InsuranceCharges => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       PartiesToTransactionAreRelated =>  $some_value, # boolean
       CommercialInvoice =>  { # Shipment::FedEx::WSDL::RateTypes::CommercialInvoice
         Comments =>  $some_value, # string
         FreightCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         TaxesOrMiscellaneousCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         PackingCosts => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         HandlingCosts => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         SpecialInstructions =>  $some_value, # string
         DeclarationStatment =>  $some_value, # string
         PaymentTerms =>  $some_value, # string
         Purpose => $some_value, # PurposeOfShipmentType
         PurposeOfShipmentDescription =>  $some_value, # string
         CustomerInvoiceNumber =>  $some_value, # string
         OriginatorName =>  $some_value, # string
         TermsOfSale => $some_value, # TermsOfSaleType
       },
       Commodities =>  { # Shipment::FedEx::WSDL::RateTypes::Commodity
         Name =>  $some_value, # string
         NumberOfPieces =>  $some_value, # nonNegativeInteger
         Description =>  $some_value, # string
         CountryOfManufacture =>  $some_value, # string
         HarmonizedCode =>  $some_value, # string
         Weight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
         Quantity =>  $some_value, # nonNegativeInteger
         QuantityUnits =>  $some_value, # string
         AdditionalMeasures =>  { # Shipment::FedEx::WSDL::RateTypes::Measure
           Quantity =>  $some_value, # decimal
           Units =>  $some_value, # string
         },
         UnitPrice => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         CustomsValue => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         ExciseConditions =>  { # Shipment::FedEx::WSDL::RateTypes::EdtExciseCondition
           Category =>  $some_value, # string
           Value =>  $some_value, # string
         },
         ExportLicenseNumber =>  $some_value, # string
         ExportLicenseExpirationDate =>  $some_value, # date
         CIMarksAndNumbers =>  $some_value, # string
         NaftaDetail =>  { # Shipment::FedEx::WSDL::RateTypes::NaftaCommodityDetail
           PreferenceCriterion => $some_value, # NaftaPreferenceCriterionCode
           ProducerDetermination => $some_value, # NaftaProducerDeterminationCode
           ProducerId =>  $some_value, # string
           NetCostMethod => $some_value, # NaftaNetCostMethodCode
           NetCostDateRange => {}, # Shipment::FedEx::WSDL::RateTypes::DateRange
         },
       },
       ExportDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ExportDetail
         B13AFilingOption => $some_value, # B13AFilingOptionType
         ExportComplianceStatement =>  $some_value, # string
         PermitNumber =>  $some_value, # string
         DestinationControlDetail =>  { # Shipment::FedEx::WSDL::RateTypes::DestinationControlDetail
           StatementTypes => $some_value, # DestinationControlStatementType
           DestinationCountries =>  $some_value, # string
           EndUser =>  $some_value, # string
         },
       },
       RegulatoryControls => $some_value, # RegulatoryControlType
     },
     PickupDetail =>  { # Shipment::FedEx::WSDL::RateTypes::PickupDetail
       ReadyDateTime =>  $some_value, # dateTime
       LatestPickupDateTime =>  $some_value, # dateTime
       CourierInstructions =>  $some_value, # string
       RequestType => $some_value, # PickupRequestType
       RequestSource => $some_value, # PickupRequestSourceType
     },
     SmartPostDetail =>  { # Shipment::FedEx::WSDL::RateTypes::SmartPostShipmentDetail
       Indicia => $some_value, # SmartPostIndiciaType
       AncillaryEndorsement => $some_value, # SmartPostAncillaryEndorsementType
       HubId =>  $some_value, # string
       CustomerManifestId =>  $some_value, # string
     },
     BlockInsightVisibility =>  $some_value, # boolean
     LabelSpecification =>  { # Shipment::FedEx::WSDL::RateTypes::LabelSpecification
       LabelFormatType => $some_value, # LabelFormatType
       ImageType => $some_value, # ShippingDocumentImageType
       LabelStockType => $some_value, # LabelStockType
       LabelPrintingOrientation => $some_value, # LabelPrintingOrientationType
       LabelRotation => $some_value, # LabelRotationType
       PrintedLabelOrigin => {}, # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
       CustomerSpecifiedDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CustomerSpecifiedLabelDetail
         DocTabContent =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabContent
           DocTabContentType => $some_value, # DocTabContentType
           Zone001 =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabContentZone001
             DocTabZoneSpecifications =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabZoneSpecification
               ZoneNumber =>  $some_value, # positiveInteger
               Header =>  $some_value, # string
               DataField =>  $some_value, # string
               LiteralValue =>  $some_value, # string
               Justification => $some_value, # DocTabZoneJustificationType
             },
           },
           Barcoded =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabContentBarcoded
             Symbology => $some_value, # BarcodeSymbologyType
             Specification => {}, # Shipment::FedEx::WSDL::RateTypes::DocTabZoneSpecification
           },
         },
         CustomContent =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelDetail
           CoordinateUnits => $some_value, # CustomLabelCoordinateUnits
           TextEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelTextEntry
             Position =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
               X =>  $some_value, # nonNegativeInteger
               Y =>  $some_value, # nonNegativeInteger
             },
             Format =>  $some_value, # string
             DataFields =>  $some_value, # string
             ThermalFontId =>  $some_value, # string
             FontName =>  $some_value, # string
             FontSize =>  $some_value, # positiveInteger
           },
           GraphicEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelGraphicEntry
             Position => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
             PrinterGraphicId =>  $some_value, # string
             FileGraphicFullName =>  $some_value, # string
           },
           BoxEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelBoxEntry
             TopLeftCorner => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
             BottomRightCorner => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
           },
           BarcodeEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelBarcodeEntry
             Position => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
             Format =>  $some_value, # string
             DataFields =>  $some_value, # string
             BarHeight =>  $some_value, # int
             ThinBarWidth =>  $some_value, # int
             BarcodeSymbology => $some_value, # BarcodeSymbologyType
           },
         },
         ConfigurableReferenceEntries =>  { # Shipment::FedEx::WSDL::RateTypes::ConfigurableLabelReferenceEntry
           ZoneNumber =>  $some_value, # positiveInteger
           Header =>  $some_value, # string
           DataField =>  $some_value, # string
           LiteralValue =>  $some_value, # string
         },
         MaskedData => $some_value, # LabelMaskableDataType
         TermsAndConditionsLocalization => {}, # Shipment::FedEx::WSDL::RateTypes::Localization
         AdditionalLabels =>  { # Shipment::FedEx::WSDL::RateTypes::AdditionalLabelsDetail
           Type => $some_value, # AdditionalLabelsType
           Count =>  $some_value, # nonNegativeInteger
         },
         AirWaybillSuppressionCount =>  $some_value, # nonNegativeInteger
       },
     },
     ShippingDocumentSpecification =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentSpecification
       ShippingDocumentTypes => $some_value, # RequestedShippingDocumentType
       CertificateOfOrigin =>  { # Shipment::FedEx::WSDL::RateTypes::CertificateOfOriginDetail
         DocumentFormat =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
           Dispositions =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentDispositionDetail
             DispositionType => $some_value, # ShippingDocumentDispositionType
             Grouping => $some_value, # ShippingDocumentGroupingType
             EMailDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentEMailDetail
               EMailRecipients =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentEMailRecipient
                 RecipientType => $some_value, # EMailNotificationRecipientType
                 Address =>  $some_value, # string
               },
               Grouping => $some_value, # ShippingDocumentEMailGroupingType
             },
             PrintDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentPrintDetail
               PrinterId =>  $some_value, # string
             },
           },
           TopOfPageOffset =>  { # Shipment::FedEx::WSDL::RateTypes::LinearMeasure
             Value =>  $some_value, # decimal
             Units => $some_value, # LinearUnits
           },
           ImageType => $some_value, # ShippingDocumentImageType
           StockType => $some_value, # ShippingDocumentStockType
           ProvideInstructions =>  $some_value, # boolean
           Localization => {}, # Shipment::FedEx::WSDL::RateTypes::Localization
         },
         CustomerImageUsages =>  { # Shipment::FedEx::WSDL::RateTypes::CustomerImageUsage
           Type => $some_value, # CustomerImageUsageType
           Id => $some_value, # ImageId
         },
       },
       CommercialInvoiceDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CommercialInvoiceDetail
         Format => {}, # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
         CustomerImageUsages => {}, # Shipment::FedEx::WSDL::RateTypes::CustomerImageUsage
       },
       CustomPackageDocumentDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail
         Format => {}, # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
         LabelPrintingOrientation => $some_value, # LabelPrintingOrientationType
         LabelRotation => $some_value, # LabelRotationType
         SpecificationId =>  $some_value, # string
       },
       CustomShipmentDocumentDetail => {}, # Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail
       GeneralAgencyAgreementDetail =>  { # Shipment::FedEx::WSDL::RateTypes::GeneralAgencyAgreementDetail
         Format => {}, # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
       },
       NaftaCertificateOfOriginDetail =>  { # Shipment::FedEx::WSDL::RateTypes::NaftaCertificateOfOriginDetail
         Format => {}, # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
         BlanketPeriod => {}, # Shipment::FedEx::WSDL::RateTypes::DateRange
         ImporterSpecification => $some_value, # NaftaImporterSpecificationType
         SignatureContact => {}, # Shipment::FedEx::WSDL::RateTypes::Contact
         ProducerSpecification => $some_value, # NaftaProducerSpecificationType
         Producers =>  { # Shipment::FedEx::WSDL::RateTypes::NaftaProducer
           Id =>  $some_value, # string
           Producer => {}, # Shipment::FedEx::WSDL::RateTypes::Party
         },
         CustomerImageUsages => {}, # Shipment::FedEx::WSDL::RateTypes::CustomerImageUsage
       },
       Op900Detail =>  { # Shipment::FedEx::WSDL::RateTypes::Op900Detail
         Format => {}, # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
         Reference => $some_value, # CustomerReferenceType
         CustomerImageUsages => {}, # Shipment::FedEx::WSDL::RateTypes::CustomerImageUsage
         SignatureName =>  $some_value, # string
       },
     },
     RateRequestTypes => $some_value, # RateRequestType
     EdtRequestType => $some_value, # EdtRequestType
     PackageCount =>  $some_value, # nonNegativeInteger
     PackageDetail => $some_value, # RequestedPackageDetailType
     RequestedPackageLineItems =>  { # Shipment::FedEx::WSDL::RateTypes::RequestedPackageLineItem
       SequenceNumber =>  $some_value, # positiveInteger
       GroupNumber =>  $some_value, # nonNegativeInteger
       GroupPackageCount =>  $some_value, # nonNegativeInteger
       VariableHandlingChargeDetail => {}, # Shipment::FedEx::WSDL::RateTypes::VariableHandlingChargeDetail
       InsuredValue => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       Weight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
       Dimensions => {}, # Shipment::FedEx::WSDL::RateTypes::Dimensions
       PhysicalPackaging => $some_value, # PhysicalPackagingType
       ItemDescription =>  $some_value, # string
       CustomerReferences =>  { # Shipment::FedEx::WSDL::RateTypes::CustomerReference
         CustomerReferenceType => $some_value, # CustomerReferenceType
         Value =>  $some_value, # string
       },
       SpecialServicesRequested =>  { # Shipment::FedEx::WSDL::RateTypes::PackageSpecialServicesRequested
         SpecialServiceTypes => $some_value, # PackageSpecialServiceType
         CodDetail => {}, # Shipment::FedEx::WSDL::RateTypes::CodDetail
         DangerousGoodsDetail =>  { # Shipment::FedEx::WSDL::RateTypes::DangerousGoodsDetail
           Accessibility => $some_value, # DangerousGoodsAccessibilityType
           CargoAircraftOnly =>  $some_value, # boolean
           Options => $some_value, # HazardousCommodityOptionType
           HazardousCommodities =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityContent
             Description =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityDescription
               Id =>  $some_value, # string
               PackingGroup => $some_value, # HazardousCommodityPackingGroupType
               ProperShippingName =>  $some_value, # string
               TechnicalName =>  $some_value, # string
               HazardClass =>  $some_value, # string
               SubsidiaryClasses =>  $some_value, # string
               LabelText =>  $some_value, # string
             },
             Quantity =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityQuantityDetail
               Amount =>  $some_value, # decimal
               Units =>  $some_value, # string
             },
             Options =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityOptionDetail
               LabelTextOption => $some_value, # HazardousCommodityLabelTextOptionType
               CustomerSuppliedLabelText =>  $some_value, # string
             },
           },
           Packaging =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityPackagingDetail
             Count =>  $some_value, # nonNegativeInteger
             Units =>  $some_value, # string
           },
           EmergencyContactNumber =>  $some_value, # string
         },
         DryIceWeight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
         SignatureOptionDetail =>  { # Shipment::FedEx::WSDL::RateTypes::SignatureOptionDetail
           OptionType => $some_value, # SignatureOptionType
           SignatureReleaseNumber =>  $some_value, # string
         },
         PriorityAlertDetail =>  { # Shipment::FedEx::WSDL::RateTypes::PriorityAlertDetail
           Content =>  $some_value, # string
         },
       },
       ContentRecords =>  { # Shipment::FedEx::WSDL::RateTypes::ContentRecord
         PartNumber =>  $some_value, # string
         ItemNumber =>  $some_value, # string
         ReceivedQuantity =>  $some_value, # nonNegativeInteger
         Description =>  $some_value, # string
       },
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

