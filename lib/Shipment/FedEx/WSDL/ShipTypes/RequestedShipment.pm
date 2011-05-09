package Shipment::FedEx::WSDL::ShipTypes::RequestedShipment;
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

my %ShipTimestamp_of :ATTR(:get<ShipTimestamp>);
my %DropoffType_of :ATTR(:get<DropoffType>);
my %ServiceType_of :ATTR(:get<ServiceType>);
my %PackagingType_of :ATTR(:get<PackagingType>);
my %TotalWeight_of :ATTR(:get<TotalWeight>);
my %TotalInsuredValue_of :ATTR(:get<TotalInsuredValue>);
my %TotalDimensions_of :ATTR(:get<TotalDimensions>);
my %Shipper_of :ATTR(:get<Shipper>);
my %Recipient_of :ATTR(:get<Recipient>);
my %RecipientLocationNumber_of :ATTR(:get<RecipientLocationNumber>);
my %Origin_of :ATTR(:get<Origin>);
my %ShippingChargesPayment_of :ATTR(:get<ShippingChargesPayment>);
my %SpecialServicesRequested_of :ATTR(:get<SpecialServicesRequested>);
my %ExpressFreightDetail_of :ATTR(:get<ExpressFreightDetail>);
my %FreightShipmentDetail_of :ATTR(:get<FreightShipmentDetail>);
my %DeliveryInstructions_of :ATTR(:get<DeliveryInstructions>);
my %VariableHandlingChargeDetail_of :ATTR(:get<VariableHandlingChargeDetail>);
my %CustomsClearanceDetail_of :ATTR(:get<CustomsClearanceDetail>);
my %PickupDetail_of :ATTR(:get<PickupDetail>);
my %SmartPostDetail_of :ATTR(:get<SmartPostDetail>);
my %BlockInsightVisibility_of :ATTR(:get<BlockInsightVisibility>);
my %ErrorLabelBehavior_of :ATTR(:get<ErrorLabelBehavior>);
my %LabelSpecification_of :ATTR(:get<LabelSpecification>);
my %ShippingDocumentSpecification_of :ATTR(:get<ShippingDocumentSpecification>);
my %RateRequestTypes_of :ATTR(:get<RateRequestTypes>);
my %CustomerSelectedActualRateType_of :ATTR(:get<CustomerSelectedActualRateType>);
my %EdtRequestType_of :ATTR(:get<EdtRequestType>);
my %MasterTrackingId_of :ATTR(:get<MasterTrackingId>);
my %CodReturnTrackingId_of :ATTR(:get<CodReturnTrackingId>);
my %PackageCount_of :ATTR(:get<PackageCount>);
my %PackageDetail_of :ATTR(:get<PackageDetail>);
my %RequestedPackageLineItems_of :ATTR(:get<RequestedPackageLineItems>);

__PACKAGE__->_factory(
    [ qw(        ShipTimestamp
        DropoffType
        ServiceType
        PackagingType
        TotalWeight
        TotalInsuredValue
        TotalDimensions
        Shipper
        Recipient
        RecipientLocationNumber
        Origin
        ShippingChargesPayment
        SpecialServicesRequested
        ExpressFreightDetail
        FreightShipmentDetail
        DeliveryInstructions
        VariableHandlingChargeDetail
        CustomsClearanceDetail
        PickupDetail
        SmartPostDetail
        BlockInsightVisibility
        ErrorLabelBehavior
        LabelSpecification
        ShippingDocumentSpecification
        RateRequestTypes
        CustomerSelectedActualRateType
        EdtRequestType
        MasterTrackingId
        CodReturnTrackingId
        PackageCount
        PackageDetail
        RequestedPackageLineItems

    ) ],
    {
        'ShipTimestamp' => \%ShipTimestamp_of,
        'DropoffType' => \%DropoffType_of,
        'ServiceType' => \%ServiceType_of,
        'PackagingType' => \%PackagingType_of,
        'TotalWeight' => \%TotalWeight_of,
        'TotalInsuredValue' => \%TotalInsuredValue_of,
        'TotalDimensions' => \%TotalDimensions_of,
        'Shipper' => \%Shipper_of,
        'Recipient' => \%Recipient_of,
        'RecipientLocationNumber' => \%RecipientLocationNumber_of,
        'Origin' => \%Origin_of,
        'ShippingChargesPayment' => \%ShippingChargesPayment_of,
        'SpecialServicesRequested' => \%SpecialServicesRequested_of,
        'ExpressFreightDetail' => \%ExpressFreightDetail_of,
        'FreightShipmentDetail' => \%FreightShipmentDetail_of,
        'DeliveryInstructions' => \%DeliveryInstructions_of,
        'VariableHandlingChargeDetail' => \%VariableHandlingChargeDetail_of,
        'CustomsClearanceDetail' => \%CustomsClearanceDetail_of,
        'PickupDetail' => \%PickupDetail_of,
        'SmartPostDetail' => \%SmartPostDetail_of,
        'BlockInsightVisibility' => \%BlockInsightVisibility_of,
        'ErrorLabelBehavior' => \%ErrorLabelBehavior_of,
        'LabelSpecification' => \%LabelSpecification_of,
        'ShippingDocumentSpecification' => \%ShippingDocumentSpecification_of,
        'RateRequestTypes' => \%RateRequestTypes_of,
        'CustomerSelectedActualRateType' => \%CustomerSelectedActualRateType_of,
        'EdtRequestType' => \%EdtRequestType_of,
        'MasterTrackingId' => \%MasterTrackingId_of,
        'CodReturnTrackingId' => \%CodReturnTrackingId_of,
        'PackageCount' => \%PackageCount_of,
        'PackageDetail' => \%PackageDetail_of,
        'RequestedPackageLineItems' => \%RequestedPackageLineItems_of,
    },
    {
        'ShipTimestamp' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
        'DropoffType' => 'Shipment::FedEx::WSDL::ShipTypes::DropoffType',
        'ServiceType' => 'Shipment::FedEx::WSDL::ShipTypes::ServiceType',
        'PackagingType' => 'Shipment::FedEx::WSDL::ShipTypes::PackagingType',
        'TotalWeight' => 'Shipment::FedEx::WSDL::ShipTypes::Weight',
        'TotalInsuredValue' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalDimensions' => 'Shipment::FedEx::WSDL::ShipTypes::Dimensions',
        'Shipper' => 'Shipment::FedEx::WSDL::ShipTypes::Party',
        'Recipient' => 'Shipment::FedEx::WSDL::ShipTypes::Party',
        'RecipientLocationNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Origin' => 'Shipment::FedEx::WSDL::ShipTypes::ContactAndAddress',
        'ShippingChargesPayment' => 'Shipment::FedEx::WSDL::ShipTypes::Payment',
        'SpecialServicesRequested' => 'Shipment::FedEx::WSDL::ShipTypes::ShipmentSpecialServicesRequested',
        'ExpressFreightDetail' => 'Shipment::FedEx::WSDL::ShipTypes::ExpressFreightDetail',
        'FreightShipmentDetail' => 'Shipment::FedEx::WSDL::ShipTypes::FreightShipmentDetail',
        'DeliveryInstructions' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'VariableHandlingChargeDetail' => 'Shipment::FedEx::WSDL::ShipTypes::VariableHandlingChargeDetail',
        'CustomsClearanceDetail' => 'Shipment::FedEx::WSDL::ShipTypes::CustomsClearanceDetail',
        'PickupDetail' => 'Shipment::FedEx::WSDL::ShipTypes::PickupDetail',
        'SmartPostDetail' => 'Shipment::FedEx::WSDL::ShipTypes::SmartPostShipmentDetail',
        'BlockInsightVisibility' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'ErrorLabelBehavior' => 'Shipment::FedEx::WSDL::ShipTypes::ErrorLabelBehaviorType',
        'LabelSpecification' => 'Shipment::FedEx::WSDL::ShipTypes::LabelSpecification',
        'ShippingDocumentSpecification' => 'Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentSpecification',
        'RateRequestTypes' => 'Shipment::FedEx::WSDL::ShipTypes::RateRequestType',
        'CustomerSelectedActualRateType' => 'Shipment::FedEx::WSDL::ShipTypes::ReturnedRateType',
        'EdtRequestType' => 'Shipment::FedEx::WSDL::ShipTypes::EdtRequestType',
        'MasterTrackingId' => 'Shipment::FedEx::WSDL::ShipTypes::TrackingId',
        'CodReturnTrackingId' => 'Shipment::FedEx::WSDL::ShipTypes::TrackingId',
        'PackageCount' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'PackageDetail' => 'Shipment::FedEx::WSDL::ShipTypes::RequestedPackageDetailType',
        'RequestedPackageLineItems' => 'Shipment::FedEx::WSDL::ShipTypes::RequestedPackageLineItem',
    },
    {

        'ShipTimestamp' => 'ShipTimestamp',
        'DropoffType' => 'DropoffType',
        'ServiceType' => 'ServiceType',
        'PackagingType' => 'PackagingType',
        'TotalWeight' => 'TotalWeight',
        'TotalInsuredValue' => 'TotalInsuredValue',
        'TotalDimensions' => 'TotalDimensions',
        'Shipper' => 'Shipper',
        'Recipient' => 'Recipient',
        'RecipientLocationNumber' => 'RecipientLocationNumber',
        'Origin' => 'Origin',
        'ShippingChargesPayment' => 'ShippingChargesPayment',
        'SpecialServicesRequested' => 'SpecialServicesRequested',
        'ExpressFreightDetail' => 'ExpressFreightDetail',
        'FreightShipmentDetail' => 'FreightShipmentDetail',
        'DeliveryInstructions' => 'DeliveryInstructions',
        'VariableHandlingChargeDetail' => 'VariableHandlingChargeDetail',
        'CustomsClearanceDetail' => 'CustomsClearanceDetail',
        'PickupDetail' => 'PickupDetail',
        'SmartPostDetail' => 'SmartPostDetail',
        'BlockInsightVisibility' => 'BlockInsightVisibility',
        'ErrorLabelBehavior' => 'ErrorLabelBehavior',
        'LabelSpecification' => 'LabelSpecification',
        'ShippingDocumentSpecification' => 'ShippingDocumentSpecification',
        'RateRequestTypes' => 'RateRequestTypes',
        'CustomerSelectedActualRateType' => 'CustomerSelectedActualRateType',
        'EdtRequestType' => 'EdtRequestType',
        'MasterTrackingId' => 'MasterTrackingId',
        'CodReturnTrackingId' => 'CodReturnTrackingId',
        'PackageCount' => 'PackageCount',
        'PackageDetail' => 'PackageDetail',
        'RequestedPackageLineItems' => 'RequestedPackageLineItems',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::RequestedShipment

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
RequestedShipment from the namespace http://fedex.com/ws/ship/v9.

The descriptive data for the shipment being tendered to FedEx.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ShipTimestamp (min/maxOccurs: 1/1)


=item * DropoffType (min/maxOccurs: 1/1)


=item * ServiceType (min/maxOccurs: 1/1)


=item * PackagingType (min/maxOccurs: 1/1)


=item * TotalWeight (min/maxOccurs: 0/1)


=item * TotalInsuredValue (min/maxOccurs: 0/1)


=item * TotalDimensions (min/maxOccurs: 0/1)


=item * Shipper (min/maxOccurs: 1/1)


=item * Recipient (min/maxOccurs: 1/1)


=item * RecipientLocationNumber (min/maxOccurs: 0/1)


=item * Origin (min/maxOccurs: 0/1)


=item * ShippingChargesPayment (min/maxOccurs: 0/1)


=item * SpecialServicesRequested (min/maxOccurs: 0/1)


=item * ExpressFreightDetail (min/maxOccurs: 0/1)


=item * FreightShipmentDetail (min/maxOccurs: 0/1)


=item * DeliveryInstructions (min/maxOccurs: 0/1)


=item * VariableHandlingChargeDetail (min/maxOccurs: 0/1)


=item * CustomsClearanceDetail (min/maxOccurs: 0/1)


=item * PickupDetail (min/maxOccurs: 0/1)


=item * SmartPostDetail (min/maxOccurs: 0/1)


=item * BlockInsightVisibility (min/maxOccurs: 0/1)


=item * ErrorLabelBehavior (min/maxOccurs: 0/1)


=item * LabelSpecification (min/maxOccurs: 1/1)


=item * ShippingDocumentSpecification (min/maxOccurs: 0/1)


=item * RateRequestTypes (min/maxOccurs: 1/unbounded)


=item * CustomerSelectedActualRateType (min/maxOccurs: 0/1)


=item * EdtRequestType (min/maxOccurs: 0/1)


=item * MasterTrackingId (min/maxOccurs: 0/1)


=item * CodReturnTrackingId (min/maxOccurs: 0/1)


=item * PackageCount (min/maxOccurs: 1/1)


=item * PackageDetail (min/maxOccurs: 0/1)


=item * RequestedPackageLineItems (min/maxOccurs: 0/999)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::RequestedShipment
   ShipTimestamp =>  $some_value, # dateTime
   DropoffType => $some_value, # DropoffType
   ServiceType => $some_value, # ServiceType
   PackagingType => $some_value, # PackagingType
   TotalWeight =>  { # Shipment::FedEx::WSDL::ShipTypes::Weight
     Units => $some_value, # WeightUnits
     Value =>  $some_value, # decimal
   },
   TotalInsuredValue =>  { # Shipment::FedEx::WSDL::ShipTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   TotalDimensions =>  { # Shipment::FedEx::WSDL::ShipTypes::Dimensions
     Length =>  $some_value, # nonNegativeInteger
     Width =>  $some_value, # nonNegativeInteger
     Height =>  $some_value, # nonNegativeInteger
     Units => $some_value, # LinearUnits
   },
   Shipper =>  { # Shipment::FedEx::WSDL::ShipTypes::Party
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
   Recipient => {}, # Shipment::FedEx::WSDL::ShipTypes::Party
   RecipientLocationNumber =>  $some_value, # string
   Origin =>  { # Shipment::FedEx::WSDL::ShipTypes::ContactAndAddress
     Contact => {}, # Shipment::FedEx::WSDL::ShipTypes::Contact
     Address => {}, # Shipment::FedEx::WSDL::ShipTypes::Address
   },
   ShippingChargesPayment =>  { # Shipment::FedEx::WSDL::ShipTypes::Payment
     PaymentType => $some_value, # PaymentType
     Payor =>  { # Shipment::FedEx::WSDL::ShipTypes::Payor
       AccountNumber =>  $some_value, # string
       CountryCode =>  $some_value, # string
     },
   },
   SpecialServicesRequested =>  { # Shipment::FedEx::WSDL::ShipTypes::ShipmentSpecialServicesRequested
     SpecialServiceTypes => $some_value, # ShipmentSpecialServiceType
     CodDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CodDetail
       CodCollectionAmount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       AddTransportationCharges => $some_value, # CodAddTransportationChargesType
       CollectionType => $some_value, # CodCollectionType
       CodRecipient => {}, # Shipment::FedEx::WSDL::ShipTypes::Party
       ReferenceIndicator => $some_value, # CodReturnReferenceIndicatorType
     },
     HoldAtLocationDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::HoldAtLocationDetail
       PhoneNumber =>  $some_value, # string
       LocationContactAndAddress => {}, # Shipment::FedEx::WSDL::ShipTypes::ContactAndAddress
       LocationType => $some_value, # FedExLocationType
     },
     EMailNotificationDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::EMailNotificationDetail
       AggregationType => $some_value, # EMailNotificationAggregationType
       PersonalMessage =>  $some_value, # string
       Recipients =>  { # Shipment::FedEx::WSDL::ShipTypes::EMailNotificationRecipient
         EMailNotificationRecipientType => $some_value, # EMailNotificationRecipientType
         EMailAddress =>  $some_value, # string
         NotifyOnShipment =>  $some_value, # boolean
         NotifyOnException =>  $some_value, # boolean
         NotifyOnDelivery =>  $some_value, # boolean
         Format => $some_value, # EMailNotificationFormatType
         Localization =>  { # Shipment::FedEx::WSDL::ShipTypes::Localization
           LanguageCode =>  $some_value, # string
           LocaleCode =>  $some_value, # string
         },
       },
     },
     ReturnShipmentDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ReturnShipmentDetail
       ReturnType => $some_value, # ReturnType
       Rma =>  { # Shipment::FedEx::WSDL::ShipTypes::Rma
         Number =>  $some_value, # string
         Reason =>  $some_value, # string
       },
       ReturnEMailDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ReturnEMailDetail
         MerchantPhoneNumber =>  $some_value, # string
         AllowedSpecialServices => $some_value, # ReturnEMailAllowedSpecialServiceType
       },
     },
     PendingShipmentDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::PendingShipmentDetail
       Type => $some_value, # PendingShipmentType
       ExpirationDate =>  $some_value, # date
       EmailLabelDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::EMailLabelDetail
         NotificationEMailAddress =>  $some_value, # string
         NotificationMessage =>  $some_value, # string
       },
     },
     ShipmentDryIceDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ShipmentDryIceDetail
       PackageCount =>  $some_value, # nonNegativeInteger
       TotalWeight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
     },
     HomeDeliveryPremiumDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::HomeDeliveryPremiumDetail
       HomeDeliveryPremiumType => $some_value, # HomeDeliveryPremiumType
       Date =>  $some_value, # date
       PhoneNumber =>  $some_value, # string
     },
     EtdDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::EtdDetail
       RequestedDocumentCopies => $some_value, # RequestedShippingDocumentType
       DocumentReferences =>  { # Shipment::FedEx::WSDL::ShipTypes::UploadDocumentReferenceDetail
         LineNumber =>  $some_value, # nonNegativeInteger
         CustomerReference =>  $some_value, # string
         DocumentProducer => $some_value, # UploadDocumentProducerType
         DocumentType => $some_value, # UploadDocumentType
         DocumentId =>  $some_value, # string
         DocumentIdProducer => $some_value, # UploadDocumentIdProducer
       },
     },
     CustomDeliveryWindowDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomDeliveryWindowDetail
       Type => $some_value, # CustomDeliveryWindowType
       RequestTime =>  $some_value, # time
       RequestRange =>  { # Shipment::FedEx::WSDL::ShipTypes::DateRange
         Begins =>  $some_value, # date
         Ends =>  $some_value, # date
       },
       RequestDate =>  $some_value, # date
     },
   },
   ExpressFreightDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ExpressFreightDetail
     PackingListEnclosed =>  $some_value, # boolean
     ShippersLoadAndCount =>  $some_value, # positiveInteger
     BookingConfirmationNumber =>  $some_value, # string
   },
   FreightShipmentDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightShipmentDetail
     FedExFreightAccountNumber =>  $some_value, # string
     FedExFreightBillingContactAndAddress => {}, # Shipment::FedEx::WSDL::ShipTypes::ContactAndAddress
     PrintedReferences =>  { # Shipment::FedEx::WSDL::ShipTypes::PrintedReference
       Type => $some_value, # PrintedReferenceType
       Value =>  $some_value, # string
     },
     Role => $some_value, # FreightShipmentRoleType
     PaymentType => $some_value, # FreightAccountPaymentType
     CollectTermsType => $some_value, # FreightCollectTermsType
     DeclaredValuePerUnit => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     DeclaredValueUnits =>  $some_value, # string
     LiabilityCoverageDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::LiabilityCoverageDetail
       CoverageType => $some_value, # LiabilityCoverageType
       CoverageAmount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     },
     Coupons =>  $some_value, # string
     TotalHandlingUnits =>  $some_value, # nonNegativeInteger
     ClientDiscountPercent =>  $some_value, # decimal
     PalletWeight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
     ShipmentDimensions => {}, # Shipment::FedEx::WSDL::ShipTypes::Dimensions
     Comment =>  $some_value, # string
     SpecialServicePayments =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightSpecialServicePayment
       SpecialService => $some_value, # ShipmentSpecialServiceType
       PaymentType => $some_value, # FreightAccountPaymentType
     },
     HazardousMaterialsEmergencyContactNumber =>  $some_value, # string
     LineItems =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightShipmentLineItem
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
       Weight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
       Dimensions => {}, # Shipment::FedEx::WSDL::ShipTypes::Dimensions
       Volume =>  { # Shipment::FedEx::WSDL::ShipTypes::Volume
         Units => $some_value, # VolumeUnits
         Value =>  $some_value, # decimal
       },
     },
   },
   DeliveryInstructions =>  $some_value, # string
   VariableHandlingChargeDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::VariableHandlingChargeDetail
     VariableHandlingChargeType => $some_value, # VariableHandlingChargeType
     FixedValue => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     PercentValue =>  $some_value, # decimal
   },
   CustomsClearanceDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomsClearanceDetail
     Broker => {}, # Shipment::FedEx::WSDL::ShipTypes::Party
     ClearanceBrokerage => $some_value, # ClearanceBrokerageType
     ImporterOfRecord => {}, # Shipment::FedEx::WSDL::ShipTypes::Party
     RecipientCustomsId =>  { # Shipment::FedEx::WSDL::ShipTypes::RecipientCustomsId
       Type => $some_value, # RecipientCustomsIdType
       Value =>  $some_value, # string
     },
     DutiesPayment => {}, # Shipment::FedEx::WSDL::ShipTypes::Payment
     DocumentContent => $some_value, # InternationalDocumentContentType
     CustomsValue => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     FreightOnValue => $some_value, # FreightOnValueType
     InsuranceCharges => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     PartiesToTransactionAreRelated =>  $some_value, # boolean
     CommercialInvoice =>  { # Shipment::FedEx::WSDL::ShipTypes::CommercialInvoice
       Comments =>  $some_value, # string
       FreightCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       TaxesOrMiscellaneousCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       PackingCosts => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       HandlingCosts => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       SpecialInstructions =>  $some_value, # string
       DeclarationStatment =>  $some_value, # string
       PaymentTerms =>  $some_value, # string
       Purpose => $some_value, # PurposeOfShipmentType
       CustomerInvoiceNumber =>  $some_value, # string
       OriginatorName =>  $some_value, # string
       TermsOfSale => $some_value, # TermsOfSaleType
     },
     Commodities =>  { # Shipment::FedEx::WSDL::ShipTypes::Commodity
       Name =>  $some_value, # string
       NumberOfPieces =>  $some_value, # nonNegativeInteger
       Description =>  $some_value, # string
       CountryOfManufacture =>  $some_value, # string
       HarmonizedCode =>  $some_value, # string
       Weight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
       Quantity =>  $some_value, # nonNegativeInteger
       QuantityUnits =>  $some_value, # string
       AdditionalMeasures =>  { # Shipment::FedEx::WSDL::ShipTypes::Measure
         Quantity =>  $some_value, # decimal
         Units =>  $some_value, # string
       },
       UnitPrice => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
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
         NetCostDateRange => {}, # Shipment::FedEx::WSDL::ShipTypes::DateRange
       },
     },
     ExportDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ExportDetail
       B13AFilingOption => $some_value, # B13AFilingOptionType
       ExportComplianceStatement =>  $some_value, # string
       PermitNumber =>  $some_value, # string
       DestinationControlDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::DestinationControlDetail
         StatementTypes => $some_value, # DestinationControlStatementType
         DestinationCountries =>  $some_value, # string
         EndUser =>  $some_value, # string
       },
     },
     RegulatoryControls => $some_value, # RegulatoryControlType
   },
   PickupDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::PickupDetail
     ReadyDateTime =>  $some_value, # dateTime
     LatestPickupDateTime =>  $some_value, # dateTime
     CourierInstructions =>  $some_value, # string
     RequestType => $some_value, # PickupRequestType
     RequestSource => $some_value, # PickupRequestSourceType
   },
   SmartPostDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::SmartPostShipmentDetail
     Indicia => $some_value, # SmartPostIndiciaType
     AncillaryEndorsement => $some_value, # SmartPostAncillaryEndorsementType
     HubId =>  $some_value, # string
     CustomerManifestId =>  $some_value, # string
   },
   BlockInsightVisibility =>  $some_value, # boolean
   ErrorLabelBehavior => $some_value, # ErrorLabelBehaviorType
   LabelSpecification =>  { # Shipment::FedEx::WSDL::ShipTypes::LabelSpecification
     Dispositions =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentDispositionDetail
       DispositionType => $some_value, # ShippingDocumentDispositionType
       Grouping => $some_value, # ShippingDocumentGroupingType
       EMailDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentEMailDetail
         EMailRecipients =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentEMailRecipient
           RecipientType => $some_value, # EMailNotificationRecipientType
           Address =>  $some_value, # string
         },
         Grouping => $some_value, # ShippingDocumentEMailGroupingType
       },
       PrintDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentPrintDetail
         PrinterId =>  $some_value, # string
       },
     },
     LabelFormatType => $some_value, # LabelFormatType
     ImageType => $some_value, # ShippingDocumentImageType
     LabelStockType => $some_value, # LabelStockType
     LabelPrintingOrientation => $some_value, # LabelPrintingOrientationType
     PrintedLabelOrigin => {}, # Shipment::FedEx::WSDL::ShipTypes::ContactAndAddress
     CustomerSpecifiedDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomerSpecifiedLabelDetail
       DocTabContent =>  { # Shipment::FedEx::WSDL::ShipTypes::DocTabContent
         DocTabContentType => $some_value, # DocTabContentType
         Zone001 =>  { # Shipment::FedEx::WSDL::ShipTypes::DocTabContentZone001
           DocTabZoneSpecifications =>  { # Shipment::FedEx::WSDL::ShipTypes::DocTabZoneSpecification
             ZoneNumber =>  $some_value, # positiveInteger
             Header =>  $some_value, # string
             DataField =>  $some_value, # string
             LiteralValue =>  $some_value, # string
             Justification => $some_value, # DocTabZoneJustificationType
           },
         },
         Barcoded =>  { # Shipment::FedEx::WSDL::ShipTypes::DocTabContentBarcoded
           Symbology => $some_value, # BarcodeSymbologyType
           Specification => {}, # Shipment::FedEx::WSDL::ShipTypes::DocTabZoneSpecification
         },
       },
       CustomContent =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelDetail
         CoordinateUnits => $some_value, # CustomLabelCoordinateUnits
         TextEntries =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelTextEntry
           Position =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelPosition
             X =>  $some_value, # nonNegativeInteger
             Y =>  $some_value, # nonNegativeInteger
           },
           Format =>  $some_value, # string
           DataFields =>  $some_value, # string
           ThermalFontId =>  $some_value, # string
           FontName =>  $some_value, # string
           FontSize =>  $some_value, # positiveInteger
         },
         GraphicEntries =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelGraphicEntry
           Position => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomLabelPosition
           PrinterGraphicId =>  $some_value, # string
           FileGraphicFullName =>  $some_value, # string
         },
         BoxEntries =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelBoxEntry
           TopLeftCorner => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomLabelPosition
           BottomRightCorner => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomLabelPosition
         },
         BarcodeEntries =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelBarcodeEntry
           Position => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomLabelPosition
           Format =>  $some_value, # string
           DataFields =>  $some_value, # string
           BarHeight =>  $some_value, # int
           ThinBarWidth =>  $some_value, # int
           BarcodeSymbology => $some_value, # BarcodeSymbologyType
         },
       },
       ConfigurableReferenceEntries =>  { # Shipment::FedEx::WSDL::ShipTypes::ConfigurableLabelReferenceEntry
         ZoneNumber =>  $some_value, # positiveInteger
         Header =>  $some_value, # string
         DataField =>  $some_value, # string
         LiteralValue =>  $some_value, # string
       },
       MaskedData => $some_value, # LabelMaskableDataType
       ScncOverride =>  $some_value, # nonNegativeInteger
       TermsAndConditionsLocalization => {}, # Shipment::FedEx::WSDL::ShipTypes::Localization
       AdditionalLabels =>  { # Shipment::FedEx::WSDL::ShipTypes::AdditionalLabelsDetail
         Type => $some_value, # AdditionalLabelsType
         Count =>  $some_value, # nonNegativeInteger
       },
       AirWaybillSuppressionCount =>  $some_value, # nonNegativeInteger
     },
   },
   ShippingDocumentSpecification =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentSpecification
     ShippingDocumentTypes => $some_value, # RequestedShippingDocumentType
     CertificateOfOrigin =>  { # Shipment::FedEx::WSDL::ShipTypes::CertificateOfOriginDetail
       DocumentFormat =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentFormat
         Dispositions => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentDispositionDetail
         TopOfPageOffset =>  { # Shipment::FedEx::WSDL::ShipTypes::LinearMeasure
           Value =>  $some_value, # decimal
           Units => $some_value, # LinearUnits
         },
         ImageType => $some_value, # ShippingDocumentImageType
         StockType => $some_value, # ShippingDocumentStockType
         ProvideInstructions =>  $some_value, # boolean
         Localization => {}, # Shipment::FedEx::WSDL::ShipTypes::Localization
         CustomDocumentIdentifier =>  $some_value, # string
       },
       CustomerImageUsages =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomerImageUsage
         Type => $some_value, # CustomerImageUsageType
         Id => $some_value, # ImageId
       },
     },
     CommercialInvoiceDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CommercialInvoiceDetail
       Format => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentFormat
       CustomerImageUsages => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomerImageUsage
     },
     CustomPackageDocumentDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomDocumentDetail
       Format => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentFormat
       LabelPrintingOrientation => $some_value, # LabelPrintingOrientationType
       LabelRotation => $some_value, # LabelRotationType
       SpecificationId =>  $some_value, # string
       CustomDocumentIdentifier =>  $some_value, # string
       DocTabContent => {}, # Shipment::FedEx::WSDL::ShipTypes::DocTabContent
     },
     CustomShipmentDocumentDetail => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomDocumentDetail
     GeneralAgencyAgreementDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::GeneralAgencyAgreementDetail
       Format => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentFormat
     },
     NaftaCertificateOfOriginDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::NaftaCertificateOfOriginDetail
       Format => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentFormat
       BlanketPeriod => {}, # Shipment::FedEx::WSDL::ShipTypes::DateRange
       ImporterSpecification => $some_value, # NaftaImporterSpecificationType
       SignatureContact => {}, # Shipment::FedEx::WSDL::ShipTypes::Contact
       ProducerSpecification => $some_value, # NaftaProducerSpecificationType
       Producers =>  { # Shipment::FedEx::WSDL::ShipTypes::NaftaProducer
         Id =>  $some_value, # string
         Producer => {}, # Shipment::FedEx::WSDL::ShipTypes::Party
       },
       CustomerImageUsages => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomerImageUsage
     },
     Op900Detail =>  { # Shipment::FedEx::WSDL::ShipTypes::Op900Detail
       Format => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentFormat
       Reference => $some_value, # CustomerReferenceType
       CustomerImageUsages => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomerImageUsage
       SignatureName =>  $some_value, # string
     },
     FreightAddressLabelDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightAddressLabelDetail
       Format => {}, # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentFormat
       Copies =>  $some_value, # nonNegativeInteger
       DocTabContent => {}, # Shipment::FedEx::WSDL::ShipTypes::DocTabContent
     },
   },
   RateRequestTypes => $some_value, # RateRequestType
   CustomerSelectedActualRateType => $some_value, # ReturnedRateType
   EdtRequestType => $some_value, # EdtRequestType
   MasterTrackingId =>  { # Shipment::FedEx::WSDL::ShipTypes::TrackingId
     TrackingIdType => $some_value, # TrackingIdType
     FormId =>  $some_value, # string
     UspsApplicationId =>  $some_value, # string
     TrackingNumber =>  $some_value, # string
   },
   CodReturnTrackingId => {}, # Shipment::FedEx::WSDL::ShipTypes::TrackingId
   PackageCount =>  $some_value, # nonNegativeInteger
   PackageDetail => $some_value, # RequestedPackageDetailType
   RequestedPackageLineItems =>  { # Shipment::FedEx::WSDL::ShipTypes::RequestedPackageLineItem
     SequenceNumber =>  $some_value, # positiveInteger
     GroupNumber =>  $some_value, # nonNegativeInteger
     GroupPackageCount =>  $some_value, # nonNegativeInteger
     VariableHandlingChargeDetail => {}, # Shipment::FedEx::WSDL::ShipTypes::VariableHandlingChargeDetail
     InsuredValue => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     Weight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
     Dimensions => {}, # Shipment::FedEx::WSDL::ShipTypes::Dimensions
     PhysicalPackaging => $some_value, # PhysicalPackagingType
     ItemDescription =>  $some_value, # string
     CustomerReferences =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomerReference
       CustomerReferenceType => $some_value, # CustomerReferenceType
       Value =>  $some_value, # string
     },
     SpecialServicesRequested =>  { # Shipment::FedEx::WSDL::ShipTypes::PackageSpecialServicesRequested
       SpecialServiceTypes => $some_value, # PackageSpecialServiceType
       CodDetail => {}, # Shipment::FedEx::WSDL::ShipTypes::CodDetail
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
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

