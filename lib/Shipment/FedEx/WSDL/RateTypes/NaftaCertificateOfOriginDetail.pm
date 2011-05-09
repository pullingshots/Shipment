package Shipment::FedEx::WSDL::RateTypes::NaftaCertificateOfOriginDetail;
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

my %Format_of :ATTR(:get<Format>);
my %BlanketPeriod_of :ATTR(:get<BlanketPeriod>);
my %ImporterSpecification_of :ATTR(:get<ImporterSpecification>);
my %SignatureContact_of :ATTR(:get<SignatureContact>);
my %ProducerSpecification_of :ATTR(:get<ProducerSpecification>);
my %Producers_of :ATTR(:get<Producers>);
my %CustomerImageUsages_of :ATTR(:get<CustomerImageUsages>);

__PACKAGE__->_factory(
    [ qw(        Format
        BlanketPeriod
        ImporterSpecification
        SignatureContact
        ProducerSpecification
        Producers
        CustomerImageUsages

    ) ],
    {
        'Format' => \%Format_of,
        'BlanketPeriod' => \%BlanketPeriod_of,
        'ImporterSpecification' => \%ImporterSpecification_of,
        'SignatureContact' => \%SignatureContact_of,
        'ProducerSpecification' => \%ProducerSpecification_of,
        'Producers' => \%Producers_of,
        'CustomerImageUsages' => \%CustomerImageUsages_of,
    },
    {
        'Format' => 'Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat',
        'BlanketPeriod' => 'Shipment::FedEx::WSDL::RateTypes::DateRange',
        'ImporterSpecification' => 'Shipment::FedEx::WSDL::RateTypes::NaftaImporterSpecificationType',
        'SignatureContact' => 'Shipment::FedEx::WSDL::RateTypes::Contact',
        'ProducerSpecification' => 'Shipment::FedEx::WSDL::RateTypes::NaftaProducerSpecificationType',
        'Producers' => 'Shipment::FedEx::WSDL::RateTypes::NaftaProducer',
        'CustomerImageUsages' => 'Shipment::FedEx::WSDL::RateTypes::CustomerImageUsage',
    },
    {

        'Format' => 'Format',
        'BlanketPeriod' => 'BlanketPeriod',
        'ImporterSpecification' => 'ImporterSpecification',
        'SignatureContact' => 'SignatureContact',
        'ProducerSpecification' => 'ProducerSpecification',
        'Producers' => 'Producers',
        'CustomerImageUsages' => 'CustomerImageUsages',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::NaftaCertificateOfOriginDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
NaftaCertificateOfOriginDetail from the namespace http://fedex.com/ws/rate/v9.

Data required to produce a Certificate of Origin document.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Format (min/maxOccurs: 0/1)


=item * BlanketPeriod (min/maxOccurs: 0/1)


=item * ImporterSpecification (min/maxOccurs: 0/1)


=item * SignatureContact (min/maxOccurs: 0/1)


=item * ProducerSpecification (min/maxOccurs: 0/1)


=item * Producers (min/maxOccurs: 0/unbounded)


=item * CustomerImageUsages (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::NaftaCertificateOfOriginDetail
   Format =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
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
   CustomerImageUsages =>  { # Shipment::FedEx::WSDL::RateTypes::CustomerImageUsage
     Type => $some_value, # CustomerImageUsageType
     Id => $some_value, # ImageId
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

