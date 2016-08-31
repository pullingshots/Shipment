package Shipment::FedEx::WSDL::TrackTypes::SignatureProofOfDeliveryLetterRequest;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/track/v9' };

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
my %QualifiedTrackingNumber_of :ATTR(:get<QualifiedTrackingNumber>);
my %AdditionalComments_of :ATTR(:get<AdditionalComments>);
my %LetterFormat_of :ATTR(:get<LetterFormat>);
my %Consignee_of :ATTR(:get<Consignee>);

__PACKAGE__->_factory(
    [ qw(        WebAuthenticationDetail
        ClientDetail
        TransactionDetail
        Version
        QualifiedTrackingNumber
        AdditionalComments
        LetterFormat
        Consignee

    ) ],
    {
        'WebAuthenticationDetail' => \%WebAuthenticationDetail_of,
        'ClientDetail' => \%ClientDetail_of,
        'TransactionDetail' => \%TransactionDetail_of,
        'Version' => \%Version_of,
        'QualifiedTrackingNumber' => \%QualifiedTrackingNumber_of,
        'AdditionalComments' => \%AdditionalComments_of,
        'LetterFormat' => \%LetterFormat_of,
        'Consignee' => \%Consignee_of,
    },
    {
        'WebAuthenticationDetail' => 'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail',
        'ClientDetail' => 'Shipment::FedEx::WSDL::TrackTypes::ClientDetail',
        'TransactionDetail' => 'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
        'Version' => 'Shipment::FedEx::WSDL::TrackTypes::VersionId',
        'QualifiedTrackingNumber' => 'Shipment::FedEx::WSDL::TrackTypes::QualifiedTrackingNumber',
        'AdditionalComments' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'LetterFormat' => 'Shipment::FedEx::WSDL::TrackTypes::SignatureProofOfDeliveryImageType',
        'Consignee' => 'Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress',
    },
    {

        'WebAuthenticationDetail' => 'WebAuthenticationDetail',
        'ClientDetail' => 'ClientDetail',
        'TransactionDetail' => 'TransactionDetail',
        'Version' => 'Version',
        'QualifiedTrackingNumber' => 'QualifiedTrackingNumber',
        'AdditionalComments' => 'AdditionalComments',
        'LetterFormat' => 'LetterFormat',
        'Consignee' => 'Consignee',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::TrackTypes::SignatureProofOfDeliveryLetterRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
SignatureProofOfDeliveryLetterRequest from the namespace http://fedex.com/ws/track/v9.

FedEx Signature Proof Of Delivery Letter request.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * WebAuthenticationDetail


=item * ClientDetail


=item * TransactionDetail


=item * Version


=item * QualifiedTrackingNumber


=item * AdditionalComments


=item * LetterFormat


=item * Consignee




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::TrackTypes::SignatureProofOfDeliveryLetterRequest
   WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail
     UserCredential =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationCredential
       Key =>  $some_value, # string
       Password =>  $some_value, # string
     },
   },
   ClientDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::ClientDetail
     AccountNumber =>  $some_value, # string
     MeterNumber =>  $some_value, # string
     IntegratorId =>  $some_value, # string
     Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
       LanguageCode =>  $some_value, # string
       LocaleCode =>  $some_value, # string
     },
   },
   TransactionDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::TransactionDetail
     CustomerTransactionId =>  $some_value, # string
     Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
       LanguageCode =>  $some_value, # string
       LocaleCode =>  $some_value, # string
     },
   },
   Version =>  { # Shipment::FedEx::WSDL::TrackTypes::VersionId
     ServiceId =>  $some_value, # string
     Major =>  $some_value, # int
     Intermediate =>  $some_value, # int
     Minor =>  $some_value, # int
   },
   QualifiedTrackingNumber =>  { # Shipment::FedEx::WSDL::TrackTypes::QualifiedTrackingNumber
     TrackingNumber =>  $some_value, # string
     ShipDate =>  $some_value, # date
     AccountNumber =>  $some_value, # string
     Carrier => $some_value, # CarrierCodeType
     Destination =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
   },
   AdditionalComments =>  $some_value, # string
   LetterFormat => $some_value, # SignatureProofOfDeliveryImageType
   Consignee =>  { # Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress
     Contact =>  { # Shipment::FedEx::WSDL::TrackTypes::Contact
       PersonName =>  $some_value, # string
       Title =>  $some_value, # string
       CompanyName =>  $some_value, # string
       PhoneNumber =>  $some_value, # string
       PhoneExtension =>  $some_value, # string
       TollFreePhoneNumber =>  $some_value, # string
       PagerNumber =>  $some_value, # string
       FaxNumber =>  $some_value, # string
       EMailAddress =>  $some_value, # string
     },
     Address =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

