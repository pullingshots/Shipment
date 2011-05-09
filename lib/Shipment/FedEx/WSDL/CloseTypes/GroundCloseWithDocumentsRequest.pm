package Shipment::FedEx::WSDL::CloseTypes::GroundCloseWithDocumentsRequest;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/close/v2' };

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
my %CloseDate_of :ATTR(:get<CloseDate>);
my %CloseDocumentSpecification_of :ATTR(:get<CloseDocumentSpecification>);

__PACKAGE__->_factory(
    [ qw(        WebAuthenticationDetail
        ClientDetail
        TransactionDetail
        Version
        CloseDate
        CloseDocumentSpecification

    ) ],
    {
        'WebAuthenticationDetail' => \%WebAuthenticationDetail_of,
        'ClientDetail' => \%ClientDetail_of,
        'TransactionDetail' => \%TransactionDetail_of,
        'Version' => \%Version_of,
        'CloseDate' => \%CloseDate_of,
        'CloseDocumentSpecification' => \%CloseDocumentSpecification_of,
    },
    {
        'WebAuthenticationDetail' => 'Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationDetail',
        'ClientDetail' => 'Shipment::FedEx::WSDL::CloseTypes::ClientDetail',
        'TransactionDetail' => 'Shipment::FedEx::WSDL::CloseTypes::TransactionDetail',
        'Version' => 'Shipment::FedEx::WSDL::CloseTypes::VersionId',
        'CloseDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
        'CloseDocumentSpecification' => 'Shipment::FedEx::WSDL::CloseTypes::CloseDocumentSpecification',
    },
    {

        'WebAuthenticationDetail' => 'WebAuthenticationDetail',
        'ClientDetail' => 'ClientDetail',
        'TransactionDetail' => 'TransactionDetail',
        'Version' => 'Version',
        'CloseDate' => 'CloseDate',
        'CloseDocumentSpecification' => 'CloseDocumentSpecification',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::CloseTypes::GroundCloseWithDocumentsRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
GroundCloseWithDocumentsRequest from the namespace http://fedex.com/ws/close/v2.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * WebAuthenticationDetail (min/maxOccurs: 1/1)


=item * ClientDetail (min/maxOccurs: 1/1)


=item * TransactionDetail (min/maxOccurs: 0/1)


=item * Version (min/maxOccurs: 1/1)


=item * CloseDate (min/maxOccurs: 0/1)


=item * CloseDocumentSpecification (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::CloseTypes::GroundCloseWithDocumentsRequest
   WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationDetail
     UserCredential =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationCredential
       Key =>  $some_value, # string
       Password =>  $some_value, # string
     },
   },
   ClientDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ClientDetail
     AccountNumber =>  $some_value, # string
     MeterNumber =>  $some_value, # string
     IntegratorId =>  $some_value, # string
     Localization =>  { # Shipment::FedEx::WSDL::CloseTypes::Localization
       LanguageCode =>  $some_value, # string
       LocaleCode =>  $some_value, # string
     },
   },
   TransactionDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::TransactionDetail
     CustomerTransactionId =>  $some_value, # string
     Localization => {}, # Shipment::FedEx::WSDL::CloseTypes::Localization
   },
   Version =>  { # Shipment::FedEx::WSDL::CloseTypes::VersionId
     ServiceId =>  $some_value, # string
     Major =>  $some_value, # int
     Intermediate =>  $some_value, # int
     Minor =>  $some_value, # int
   },
   CloseDate =>  $some_value, # date
   CloseDocumentSpecification =>  { # Shipment::FedEx::WSDL::CloseTypes::CloseDocumentSpecification
     CloseDocumentTypes => $some_value, # CloseDocumentType
     Op950Detail =>  { # Shipment::FedEx::WSDL::CloseTypes::Op950Detail
       Format =>  { # Shipment::FedEx::WSDL::CloseTypes::CloseDocumentFormat
         Dispositions =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentDispositionDetail
           DispositionType => $some_value, # ShippingDocumentDispositionType
           Grouping => $some_value, # ShippingDocumentGroupingType
           StorageDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentStorageDetail
             FilePath =>  $some_value, # string
             FileNaming => $some_value, # ShippingDocumentNamingType
             FileSuffix =>  $some_value, # string
           },
           EMailDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentEMailDetail
             EMailRecipients =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentEMailRecipient
               RecipientType => $some_value, # EMailNotificationRecipientType
               Address =>  $some_value, # string
             },
             Grouping => $some_value, # ShippingDocumentEMailGroupingType
           },
           PrintDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentPrintDetail
             PrinterId =>  $some_value, # string
           },
         },
         TopOfPageOffset =>  { # Shipment::FedEx::WSDL::CloseTypes::LinearMeasure
           Value =>  $some_value, # decimal
           Units => $some_value, # LinearUnits
         },
         ImageType => $some_value, # ShippingDocumentImageType
         StockType => $some_value, # ShippingDocumentStockType
         ProvideInstructions =>  $some_value, # boolean
         Localization => {}, # Shipment::FedEx::WSDL::CloseTypes::Localization
       },
       CustomerImageUsages =>  { # Shipment::FedEx::WSDL::CloseTypes::CustomerImageUsage
         Type => $some_value, # CustomerImageUsageType
         Id => $some_value, # ImageId
         InternalId =>  $some_value, # string
         InternalImageType => $some_value, # InternalImageType
       },
       SignatureName =>  $some_value, # string
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

