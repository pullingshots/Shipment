package Shipment::FedEx::WSDL::RateTypes::ShipmentSpecialServicesRequested;
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

my %SpecialServiceTypes_of :ATTR(:get<SpecialServiceTypes>);
my %CodDetail_of :ATTR(:get<CodDetail>);
my %HoldAtLocationDetail_of :ATTR(:get<HoldAtLocationDetail>);
my %EMailNotificationDetail_of :ATTR(:get<EMailNotificationDetail>);
my %ReturnShipmentDetail_of :ATTR(:get<ReturnShipmentDetail>);
my %PendingShipmentDetail_of :ATTR(:get<PendingShipmentDetail>);
my %ShipmentDryIceDetail_of :ATTR(:get<ShipmentDryIceDetail>);
my %HomeDeliveryPremiumDetail_of :ATTR(:get<HomeDeliveryPremiumDetail>);
my %FlatbedTrailerDetail_of :ATTR(:get<FlatbedTrailerDetail>);
my %FreightGuaranteeDetail_of :ATTR(:get<FreightGuaranteeDetail>);
my %EtdDetail_of :ATTR(:get<EtdDetail>);
my %CustomDeliveryWindowDetail_of :ATTR(:get<CustomDeliveryWindowDetail>);

__PACKAGE__->_factory(
    [ qw(        SpecialServiceTypes
        CodDetail
        HoldAtLocationDetail
        EMailNotificationDetail
        ReturnShipmentDetail
        PendingShipmentDetail
        ShipmentDryIceDetail
        HomeDeliveryPremiumDetail
        FlatbedTrailerDetail
        FreightGuaranteeDetail
        EtdDetail
        CustomDeliveryWindowDetail

    ) ],
    {
        'SpecialServiceTypes' => \%SpecialServiceTypes_of,
        'CodDetail' => \%CodDetail_of,
        'HoldAtLocationDetail' => \%HoldAtLocationDetail_of,
        'EMailNotificationDetail' => \%EMailNotificationDetail_of,
        'ReturnShipmentDetail' => \%ReturnShipmentDetail_of,
        'PendingShipmentDetail' => \%PendingShipmentDetail_of,
        'ShipmentDryIceDetail' => \%ShipmentDryIceDetail_of,
        'HomeDeliveryPremiumDetail' => \%HomeDeliveryPremiumDetail_of,
        'FlatbedTrailerDetail' => \%FlatbedTrailerDetail_of,
        'FreightGuaranteeDetail' => \%FreightGuaranteeDetail_of,
        'EtdDetail' => \%EtdDetail_of,
        'CustomDeliveryWindowDetail' => \%CustomDeliveryWindowDetail_of,
    },
    {
        'SpecialServiceTypes' => 'Shipment::FedEx::WSDL::RateTypes::ShipmentSpecialServiceType',
        'CodDetail' => 'Shipment::FedEx::WSDL::RateTypes::CodDetail',
        'HoldAtLocationDetail' => 'Shipment::FedEx::WSDL::RateTypes::HoldAtLocationDetail',
        'EMailNotificationDetail' => 'Shipment::FedEx::WSDL::RateTypes::EMailNotificationDetail',
        'ReturnShipmentDetail' => 'Shipment::FedEx::WSDL::RateTypes::ReturnShipmentDetail',
        'PendingShipmentDetail' => 'Shipment::FedEx::WSDL::RateTypes::PendingShipmentDetail',
        'ShipmentDryIceDetail' => 'Shipment::FedEx::WSDL::RateTypes::ShipmentDryIceDetail',
        'HomeDeliveryPremiumDetail' => 'Shipment::FedEx::WSDL::RateTypes::HomeDeliveryPremiumDetail',
        'FlatbedTrailerDetail' => 'Shipment::FedEx::WSDL::RateTypes::FlatbedTrailerDetail',
        'FreightGuaranteeDetail' => 'Shipment::FedEx::WSDL::RateTypes::FreightGuaranteeDetail',
        'EtdDetail' => 'Shipment::FedEx::WSDL::RateTypes::EtdDetail',
        'CustomDeliveryWindowDetail' => 'Shipment::FedEx::WSDL::RateTypes::CustomDeliveryWindowDetail',
    },
    {

        'SpecialServiceTypes' => 'SpecialServiceTypes',
        'CodDetail' => 'CodDetail',
        'HoldAtLocationDetail' => 'HoldAtLocationDetail',
        'EMailNotificationDetail' => 'EMailNotificationDetail',
        'ReturnShipmentDetail' => 'ReturnShipmentDetail',
        'PendingShipmentDetail' => 'PendingShipmentDetail',
        'ShipmentDryIceDetail' => 'ShipmentDryIceDetail',
        'HomeDeliveryPremiumDetail' => 'HomeDeliveryPremiumDetail',
        'FlatbedTrailerDetail' => 'FlatbedTrailerDetail',
        'FreightGuaranteeDetail' => 'FreightGuaranteeDetail',
        'EtdDetail' => 'EtdDetail',
        'CustomDeliveryWindowDetail' => 'CustomDeliveryWindowDetail',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::ShipmentSpecialServicesRequested

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ShipmentSpecialServicesRequested from the namespace http://fedex.com/ws/rate/v9.

These special services are available at the shipment level for some or all service types. If the shipper is requesting a special service which requires additional data (such as the COD amount), the shipment special service type must be present in the specialServiceTypes collection, and the supporting detail must be provided in the appropriate sub-object below.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * SpecialServiceTypes (min/maxOccurs: 0/unbounded)


=item * CodDetail (min/maxOccurs: 0/1)


=item * HoldAtLocationDetail (min/maxOccurs: 0/1)


=item * EMailNotificationDetail (min/maxOccurs: 0/1)


=item * ReturnShipmentDetail (min/maxOccurs: 0/1)


=item * PendingShipmentDetail (min/maxOccurs: 0/1)


=item * ShipmentDryIceDetail (min/maxOccurs: 0/1)


=item * HomeDeliveryPremiumDetail (min/maxOccurs: 0/1)


=item * FlatbedTrailerDetail (min/maxOccurs: 0/1)


=item * FreightGuaranteeDetail (min/maxOccurs: 0/1)


=item * EtdDetail (min/maxOccurs: 0/1)


=item * CustomDeliveryWindowDetail (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::ShipmentSpecialServicesRequested
   SpecialServiceTypes => $some_value, # ShipmentSpecialServiceType
   CodDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CodDetail
     CodCollectionAmount =>  { # Shipment::FedEx::WSDL::RateTypes::Money
       Currency =>  $some_value, # string
       Amount =>  $some_value, # decimal
     },
     AddTransportationCharges => $some_value, # CodAddTransportationChargesType
     CollectionType => $some_value, # CodCollectionType
     CodRecipient =>  { # Shipment::FedEx::WSDL::RateTypes::Party
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
     ReferenceIndicator => $some_value, # CodReturnReferenceIndicatorType
   },
   HoldAtLocationDetail =>  { # Shipment::FedEx::WSDL::RateTypes::HoldAtLocationDetail
     PhoneNumber =>  $some_value, # string
     LocationContactAndAddress =>  { # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
       Contact => {}, # Shipment::FedEx::WSDL::RateTypes::Contact
       Address => {}, # Shipment::FedEx::WSDL::RateTypes::Address
     },
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
       Localization =>  { # Shipment::FedEx::WSDL::RateTypes::Localization
         LanguageCode =>  $some_value, # string
         LocaleCode =>  $some_value, # string
       },
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
     TotalWeight =>  { # Shipment::FedEx::WSDL::RateTypes::Weight
       Units => $some_value, # WeightUnits
       Value =>  $some_value, # decimal
     },
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

