package Shipment::UPS::WSDL::ShipTypes::ShipmentType;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0' };

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
my %ReturnService_of :ATTR(:get<ReturnService>);
my %DocumentsOnlyIndicator_of :ATTR(:get<DocumentsOnlyIndicator>);
my %Shipper_of :ATTR(:get<Shipper>);
my %ShipTo_of :ATTR(:get<ShipTo>);
my %ShipFrom_of :ATTR(:get<ShipFrom>);
my %PaymentInformation_of :ATTR(:get<PaymentInformation>);
my %FRSPaymentInformation_of :ATTR(:get<FRSPaymentInformation>);
my %GoodsNotInFreeCirculationIndicator_of :ATTR(:get<GoodsNotInFreeCirculationIndicator>);
my %ShipmentRatingOptions_of :ATTR(:get<ShipmentRatingOptions>);
my %MovementReferenceNumber_of :ATTR(:get<MovementReferenceNumber>);
my %ReferenceNumber_of :ATTR(:get<ReferenceNumber>);
my %Service_of :ATTR(:get<Service>);
my %InvoiceLineTotal_of :ATTR(:get<InvoiceLineTotal>);
my %ShipmentServiceOptions_of :ATTR(:get<ShipmentServiceOptions>);
my %Package_of :ATTR(:get<Package>);

__PACKAGE__->_factory(
    [ qw(        Description
        ReturnService
        DocumentsOnlyIndicator
        Shipper
        ShipTo
        ShipFrom
        PaymentInformation
        FRSPaymentInformation
        GoodsNotInFreeCirculationIndicator
        ShipmentRatingOptions
        MovementReferenceNumber
        ReferenceNumber
        Service
        InvoiceLineTotal
        ShipmentServiceOptions
        Package

    ) ],
    {
        'Description' => \%Description_of,
        'ReturnService' => \%ReturnService_of,
        'DocumentsOnlyIndicator' => \%DocumentsOnlyIndicator_of,
        'Shipper' => \%Shipper_of,
        'ShipTo' => \%ShipTo_of,
        'ShipFrom' => \%ShipFrom_of,
        'PaymentInformation' => \%PaymentInformation_of,
        'FRSPaymentInformation' => \%FRSPaymentInformation_of,
        'GoodsNotInFreeCirculationIndicator' => \%GoodsNotInFreeCirculationIndicator_of,
        'ShipmentRatingOptions' => \%ShipmentRatingOptions_of,
        'MovementReferenceNumber' => \%MovementReferenceNumber_of,
        'ReferenceNumber' => \%ReferenceNumber_of,
        'Service' => \%Service_of,
        'InvoiceLineTotal' => \%InvoiceLineTotal_of,
        'ShipmentServiceOptions' => \%ShipmentServiceOptions_of,
        'Package' => \%Package_of,
    },
    {
        'Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ReturnService' => 'Shipment::UPS::WSDL::ShipTypes::ReturnServiceType',
        'DocumentsOnlyIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Shipper' => 'Shipment::UPS::WSDL::ShipTypes::ShipperType',
        'ShipTo' => 'Shipment::UPS::WSDL::ShipTypes::ShipToType',
        'ShipFrom' => 'Shipment::UPS::WSDL::ShipTypes::ShipFromType',
        'PaymentInformation' => 'Shipment::UPS::WSDL::ShipTypes::PaymentInfoType',
        'FRSPaymentInformation' => 'Shipment::UPS::WSDL::ShipTypes::FRSPaymentInfoType',
        'GoodsNotInFreeCirculationIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ShipmentRatingOptions' => 'Shipment::UPS::WSDL::ShipTypes::RateInfoType',
        'MovementReferenceNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ReferenceNumber' => 'Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType',
        'Service' => 'Shipment::UPS::WSDL::ShipTypes::ServiceType',
        'InvoiceLineTotal' => 'Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType',

        'ShipmentServiceOptions' => 'Shipment::UPS::WSDL::ShipTypes::ShipmentType::_ShipmentServiceOptions',
        'Package' => 'Shipment::UPS::WSDL::ShipTypes::PackageType',
    },
    {

        'Description' => 'Description',
        'ReturnService' => 'ReturnService',
        'DocumentsOnlyIndicator' => 'DocumentsOnlyIndicator',
        'Shipper' => 'Shipper',
        'ShipTo' => 'ShipTo',
        'ShipFrom' => 'ShipFrom',
        'PaymentInformation' => 'PaymentInformation',
        'FRSPaymentInformation' => 'FRSPaymentInformation',
        'GoodsNotInFreeCirculationIndicator' => 'GoodsNotInFreeCirculationIndicator',
        'ShipmentRatingOptions' => 'ShipmentRatingOptions',
        'MovementReferenceNumber' => 'MovementReferenceNumber',
        'ReferenceNumber' => 'ReferenceNumber',
        'Service' => 'Service',
        'InvoiceLineTotal' => 'InvoiceLineTotal',
        'ShipmentServiceOptions' => 'ShipmentServiceOptions',
        'Package' => 'Package',
    }
);

} # end BLOCK




package Shipment::UPS::WSDL::ShipTypes::ShipmentType::_ShipmentServiceOptions;
use strict;
use warnings;
{
our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}


use base qw(Shipment::UPS::WSDL::ShipTypes::ShipmentServiceOptionsType);
# Variety: sequence
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %SaturdayDeliveryIndicator_of :ATTR(:get<SaturdayDeliveryIndicator>);
my %OnCall_of :ATTR(:get<OnCall>);
my %COD_of :ATTR(:get<COD>);
my %Notification_of :ATTR(:get<Notification>);
my %LabelDelivery_of :ATTR(:get<LabelDelivery>);
my %InternationalForms_of :ATTR(:get<InternationalForms>);
my %DeliveryConfirmation_of :ATTR(:get<DeliveryConfirmation>);
my %ReturnOfDocumentIndicator_of :ATTR(:get<ReturnOfDocumentIndicator>);
my %ImportControlIndicator_of :ATTR(:get<ImportControlIndicator>);
my %LabelMethod_of :ATTR(:get<LabelMethod>);
my %CommercialInvoiceRemovalIndicator_of :ATTR(:get<CommercialInvoiceRemovalIndicator>);
my %UPScarbonneutralIndicator_of :ATTR(:get<UPScarbonneutralIndicator>);

__PACKAGE__->_factory(
    [ qw(        SaturdayDeliveryIndicator
        OnCall
        COD
        Notification
        LabelDelivery
        InternationalForms
        DeliveryConfirmation
        ReturnOfDocumentIndicator
        ImportControlIndicator
        LabelMethod
        CommercialInvoiceRemovalIndicator
        UPScarbonneutralIndicator

    ) ],
    {
        'SaturdayDeliveryIndicator' => \%SaturdayDeliveryIndicator_of,
        'OnCall' => \%OnCall_of,
        'COD' => \%COD_of,
        'Notification' => \%Notification_of,
        'LabelDelivery' => \%LabelDelivery_of,
        'InternationalForms' => \%InternationalForms_of,
        'DeliveryConfirmation' => \%DeliveryConfirmation_of,
        'ReturnOfDocumentIndicator' => \%ReturnOfDocumentIndicator_of,
        'ImportControlIndicator' => \%ImportControlIndicator_of,
        'LabelMethod' => \%LabelMethod_of,
        'CommercialInvoiceRemovalIndicator' => \%CommercialInvoiceRemovalIndicator_of,
        'UPScarbonneutralIndicator' => \%UPScarbonneutralIndicator_of,
    },
    {
        'SaturdayDeliveryIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'OnCall' => 'Shipment::UPS::WSDL::ShipTypes::OnCallType',
        'COD' => 'Shipment::UPS::WSDL::ShipTypes::CODType',
        'Notification' => 'Shipment::UPS::WSDL::ShipTypes::NotificationType',
        'LabelDelivery' => 'Shipment::UPS::WSDL::ShipTypes::LabelDeliveryType',
        'InternationalForms' => 'Shipment::UPS::WSDL::ShipTypes::InternationalFormType',
        'DeliveryConfirmation' => 'Shipment::UPS::WSDL::ShipTypes::DeliveryConfirmationType',
        'ReturnOfDocumentIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ImportControlIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'LabelMethod' => 'Shipment::UPS::WSDL::ShipTypes::LabelMethodType',
        'CommercialInvoiceRemovalIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'UPScarbonneutralIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'SaturdayDeliveryIndicator' => 'SaturdayDeliveryIndicator',
        'OnCall' => 'OnCall',
        'COD' => 'COD',
        'Notification' => 'Notification',
        'LabelDelivery' => 'LabelDelivery',
        'InternationalForms' => 'InternationalForms',
        'DeliveryConfirmation' => 'DeliveryConfirmation',
        'ReturnOfDocumentIndicator' => 'ReturnOfDocumentIndicator',
        'ImportControlIndicator' => 'ImportControlIndicator',
        'LabelMethod' => 'LabelMethod',
        'CommercialInvoiceRemovalIndicator' => 'CommercialInvoiceRemovalIndicator',
        'UPScarbonneutralIndicator' => 'UPScarbonneutralIndicator',
    }
);

} # end BLOCK






}






1;


=pod

=head1 NAME

Shipment::UPS::WSDL::ShipTypes::ShipmentType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ShipmentType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Description (min/maxOccurs: 0/1)


=item * ReturnService (min/maxOccurs: 0/1)


=item * DocumentsOnlyIndicator (min/maxOccurs: 0/1)


=item * Shipper (min/maxOccurs: 1/1)


=item * ShipTo (min/maxOccurs: 1/1)


=item * ShipFrom (min/maxOccurs: 0/1)


=item * PaymentInformation (min/maxOccurs: 0/1)


=item * FRSPaymentInformation (min/maxOccurs: 0/1)


=item * GoodsNotInFreeCirculationIndicator (min/maxOccurs: 0/1)


=item * ShipmentRatingOptions (min/maxOccurs: 0/1)


=item * MovementReferenceNumber (min/maxOccurs: 0/1)


=item * ReferenceNumber (min/maxOccurs: 0/2)


=item * Service (min/maxOccurs: 1/1)


=item * InvoiceLineTotal (min/maxOccurs: 0/1)


=item * ShipmentServiceOptions (min/maxOccurs: 0/1)


=item * Package (min/maxOccurs: 1/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::ShipTypes::ShipmentType
   Description =>  $some_value, # string
   ReturnService =>  { # Shipment::UPS::WSDL::ShipTypes::ReturnServiceType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   DocumentsOnlyIndicator =>  $some_value, # string
   Shipper =>  { # Shipment::UPS::WSDL::ShipTypes::ShipperType
     ShipperNumber =>  $some_value, # string
     FaxNumber =>  $some_value, # string
     EMailAddress =>  $some_value, # string
     Address =>  { # Shipment::UPS::WSDL::ShipTypes::ShipAddressType
       AddressLine =>  $some_value, # string
       City =>  $some_value, # string
       StateProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
     },
   },
   ShipTo =>  { # Shipment::UPS::WSDL::ShipTypes::ShipToType
     FaxNumber =>  $some_value, # string
     EMailAddress =>  $some_value, # string
     Address =>  { # Shipment::UPS::WSDL::ShipTypes::ShipToAddressType
       ResidentialAddressIndicator =>  $some_value, # string
     },
     LocationID =>  $some_value, # string
   },
   ShipFrom =>  { # Shipment::UPS::WSDL::ShipTypes::ShipFromType
     FaxNumber =>  $some_value, # string
     Address => {}, # Shipment::UPS::WSDL::ShipTypes::ShipAddressType
   },
   PaymentInformation =>  { # Shipment::UPS::WSDL::ShipTypes::PaymentInfoType
     ShipmentCharge =>  { # Shipment::UPS::WSDL::ShipTypes::ShipmentChargeType
       Type =>  $some_value, # string
       BillShipper =>  { # Shipment::UPS::WSDL::ShipTypes::BillShipperType
         AccountNumber =>  $some_value, # string
         CreditCard =>  { # Shipment::UPS::WSDL::ShipTypes::CreditCardType
           Type =>  $some_value, # string
           Number =>  $some_value, # string
           ExpirationDate =>  $some_value, # string
           SecurityCode =>  $some_value, # string
           Address =>  { # Shipment::UPS::WSDL::ShipTypes::CreditCardAddressType
             AddressLine =>  $some_value, # string
             City =>  $some_value, # string
             StateProvinceCode =>  $some_value, # string
             PostalCode =>  $some_value, # string
             CountryCode =>  $some_value, # string
           },
         },
       },
       BillReceiver =>  { # Shipment::UPS::WSDL::ShipTypes::BillReceiverType
         AccountNumber =>  $some_value, # string
         Address =>  { # Shipment::UPS::WSDL::ShipTypes::BillReceiverAddressType
           PostalCode =>  $some_value, # string
         },
       },
       BillThirdParty =>  { # Shipment::UPS::WSDL::ShipTypes::BillThirdPartyChargeType
         AccountNumber =>  $some_value, # string
         Address =>  { # Shipment::UPS::WSDL::ShipTypes::AccountAddressType
           PostalCode =>  $some_value, # string
           CountryCode =>  $some_value, # string
         },
       },
       ConsigneeBilledIndicator =>  $some_value, # string
     },
     SplitDutyVATIndicator =>  $some_value, # string
   },
   FRSPaymentInformation =>  { # Shipment::UPS::WSDL::ShipTypes::FRSPaymentInfoType
     Type =>  { # Shipment::UPS::WSDL::ShipTypes::PaymentType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     AccountNumber =>  $some_value, # string
     Address => {}, # Shipment::UPS::WSDL::ShipTypes::AccountAddressType
   },
   GoodsNotInFreeCirculationIndicator =>  $some_value, # string
   ShipmentRatingOptions =>  { # Shipment::UPS::WSDL::ShipTypes::RateInfoType
     NegotiatedRatesIndicator =>  $some_value, # string
     FRSShipmentIndicator =>  $some_value, # string
   },
   MovementReferenceNumber =>  $some_value, # string
   ReferenceNumber =>  { # Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType
     BarCodeIndicator =>  $some_value, # string
     Code =>  $some_value, # string
     Value =>  $some_value, # string
   },
   Service =>  { # Shipment::UPS::WSDL::ShipTypes::ServiceType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   InvoiceLineTotal =>  { # Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType
     CurrencyCode =>  $some_value, # string
     MonetaryValue =>  $some_value, # string
   },
   ShipmentServiceOptions =>  {
   },
   Package =>  { # Shipment::UPS::WSDL::ShipTypes::PackageType
     Description =>  $some_value, # string
     Packaging =>  { # Shipment::UPS::WSDL::ShipTypes::PackagingType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Dimensions =>  { # Shipment::UPS::WSDL::ShipTypes::DimensionsType
       UnitOfMeasurement =>  { # Shipment::UPS::WSDL::ShipTypes::ShipUnitOfMeasurementType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       Length =>  $some_value, # string
       Width =>  $some_value, # string
       Height =>  $some_value, # string
     },
     PackageWeight =>  { # Shipment::UPS::WSDL::ShipTypes::PackageWeightType
       UnitOfMeasurement => {}, # Shipment::UPS::WSDL::ShipTypes::ShipUnitOfMeasurementType
       Weight =>  $some_value, # string
     },
     LargePackageIndicator =>  $some_value, # string
     ReferenceNumber => {}, # Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType
     AdditionalHandlingIndicator =>  $some_value, # string
     PackageServiceOptions =>  { # Shipment::UPS::WSDL::ShipTypes::PackageServiceOptionsType
       DeliveryConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::DeliveryConfirmationType
         DCISType =>  $some_value, # string
         DCISNumber =>  $some_value, # string
       },
       DeclaredValue =>  { # Shipment::UPS::WSDL::ShipTypes::PackageDeclaredValueType
         Type =>  { # Shipment::UPS::WSDL::ShipTypes::DeclaredValueType
           Code =>  $some_value, # string
           Description =>  $some_value, # string
         },
         CurrencyCode =>  $some_value, # string
         MonetaryValue =>  $some_value, # string
       },
       COD =>  { # Shipment::UPS::WSDL::ShipTypes::PSOCODType
         CODFundsCode =>  $some_value, # string
         CODAmount => {}, # Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType
       },
       VerbalConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::VerbalConfirmationType
         ContactInfo =>  { # Shipment::UPS::WSDL::ShipTypes::ContactInfoType
           Name =>  $some_value, # string
           Phone =>  { # Shipment::UPS::WSDL::ShipTypes::ShipPhoneType
             Number =>  $some_value, # string
             Extension =>  $some_value, # string
           },
         },
       },
       ShipperReleaseIndicator =>  $some_value, # string
       Notification =>  { # Shipment::UPS::WSDL::ShipTypes::PSONotificationType
         NotificationCode =>  $some_value, # string
         EMail =>  { # Shipment::UPS::WSDL::ShipTypes::EmailDetailsType
           EMailAddress =>  $some_value, # string
           UndeliverableEMailAddress =>  $some_value, # string
           FromEMailAddress =>  $some_value, # string
           FromName =>  $some_value, # string
           Memo =>  $some_value, # string
           Subject =>  $some_value, # string
           SubjectCode =>  $some_value, # string
         },
       },
       ReturnsFlexibleAccessIndicator =>  $some_value, # string
     },
     Commodity =>  { # Shipment::UPS::WSDL::ShipTypes::CommodityType
       FreightClass =>  $some_value, # string
       NMFC =>  { # Shipment::UPS::WSDL::ShipTypes::NMFCType
         PrimeCode =>  $some_value, # string
         SubCode =>  $some_value, # string
       },
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

