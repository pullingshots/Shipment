package Shipment::FedEx::WSDL::RateTypes::ShippingDocumentSpecification;
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

my %ShippingDocumentTypes_of :ATTR(:get<ShippingDocumentTypes>);
my %CertificateOfOrigin_of :ATTR(:get<CertificateOfOrigin>);
my %CommercialInvoiceDetail_of :ATTR(:get<CommercialInvoiceDetail>);
my %CustomPackageDocumentDetail_of :ATTR(:get<CustomPackageDocumentDetail>);
my %CustomShipmentDocumentDetail_of :ATTR(:get<CustomShipmentDocumentDetail>);
my %GeneralAgencyAgreementDetail_of :ATTR(:get<GeneralAgencyAgreementDetail>);
my %NaftaCertificateOfOriginDetail_of :ATTR(:get<NaftaCertificateOfOriginDetail>);
my %Op900Detail_of :ATTR(:get<Op900Detail>);

__PACKAGE__->_factory(
    [ qw(        ShippingDocumentTypes
        CertificateOfOrigin
        CommercialInvoiceDetail
        CustomPackageDocumentDetail
        CustomShipmentDocumentDetail
        GeneralAgencyAgreementDetail
        NaftaCertificateOfOriginDetail
        Op900Detail

    ) ],
    {
        'ShippingDocumentTypes' => \%ShippingDocumentTypes_of,
        'CertificateOfOrigin' => \%CertificateOfOrigin_of,
        'CommercialInvoiceDetail' => \%CommercialInvoiceDetail_of,
        'CustomPackageDocumentDetail' => \%CustomPackageDocumentDetail_of,
        'CustomShipmentDocumentDetail' => \%CustomShipmentDocumentDetail_of,
        'GeneralAgencyAgreementDetail' => \%GeneralAgencyAgreementDetail_of,
        'NaftaCertificateOfOriginDetail' => \%NaftaCertificateOfOriginDetail_of,
        'Op900Detail' => \%Op900Detail_of,
    },
    {
        'ShippingDocumentTypes' => 'Shipment::FedEx::WSDL::RateTypes::RequestedShippingDocumentType',
        'CertificateOfOrigin' => 'Shipment::FedEx::WSDL::RateTypes::CertificateOfOriginDetail',
        'CommercialInvoiceDetail' => 'Shipment::FedEx::WSDL::RateTypes::CommercialInvoiceDetail',
        'CustomPackageDocumentDetail' => 'Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail',
        'CustomShipmentDocumentDetail' => 'Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail',
        'GeneralAgencyAgreementDetail' => 'Shipment::FedEx::WSDL::RateTypes::GeneralAgencyAgreementDetail',
        'NaftaCertificateOfOriginDetail' => 'Shipment::FedEx::WSDL::RateTypes::NaftaCertificateOfOriginDetail',
        'Op900Detail' => 'Shipment::FedEx::WSDL::RateTypes::Op900Detail',
    },
    {

        'ShippingDocumentTypes' => 'ShippingDocumentTypes',
        'CertificateOfOrigin' => 'CertificateOfOrigin',
        'CommercialInvoiceDetail' => 'CommercialInvoiceDetail',
        'CustomPackageDocumentDetail' => 'CustomPackageDocumentDetail',
        'CustomShipmentDocumentDetail' => 'CustomShipmentDocumentDetail',
        'GeneralAgencyAgreementDetail' => 'GeneralAgencyAgreementDetail',
        'NaftaCertificateOfOriginDetail' => 'NaftaCertificateOfOriginDetail',
        'Op900Detail' => 'Op900Detail',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::ShippingDocumentSpecification

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ShippingDocumentSpecification from the namespace http://fedex.com/ws/rate/v9.

Contains all data required for additional (non-label) shipping documents to be produced in conjunction with a specific shipment.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ShippingDocumentTypes (min/maxOccurs: 0/unbounded)


=item * CertificateOfOrigin (min/maxOccurs: 0/1)


=item * CommercialInvoiceDetail (min/maxOccurs: 0/1)


=item * CustomPackageDocumentDetail (min/maxOccurs: 0/1)


=item * CustomShipmentDocumentDetail (min/maxOccurs: 0/1)


=item * GeneralAgencyAgreementDetail (min/maxOccurs: 0/1)


=item * NaftaCertificateOfOriginDetail (min/maxOccurs: 0/1)


=item * Op900Detail (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentSpecification
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
       Localization =>  { # Shipment::FedEx::WSDL::RateTypes::Localization
         LanguageCode =>  $some_value, # string
         LocaleCode =>  $some_value, # string
       },
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
     BlanketPeriod =>  { # Shipment::FedEx::WSDL::RateTypes::DateRange
       Begins =>  $some_value, # date
       Ends =>  $some_value, # date
     },
     ImporterSpecification => $some_value, # NaftaImporterSpecificationType
     SignatureContact =>  { # Shipment::FedEx::WSDL::RateTypes::Contact
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
     ProducerSpecification => $some_value, # NaftaProducerSpecificationType
     Producers =>  { # Shipment::FedEx::WSDL::RateTypes::NaftaProducer
       Id =>  $some_value, # string
       Producer =>  { # Shipment::FedEx::WSDL::RateTypes::Party
         AccountNumber =>  $some_value, # string
         Tins =>  { # Shipment::FedEx::WSDL::RateTypes::TaxpayerIdentification
           TinType => $some_value, # TinType
           Number =>  $some_value, # string
           Usage =>  $some_value, # string
         },
         Contact => {}, # Shipment::FedEx::WSDL::RateTypes::Contact
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

