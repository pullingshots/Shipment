package Shipment::FedEx::WSDL::TrackTypes::TrackRequest;
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
my %SelectionDetails_of :ATTR(:get<SelectionDetails>);
my %TransactionTimeOutValueInMilliseconds_of :ATTR(:get<TransactionTimeOutValueInMilliseconds>);
my %ProcessingOptions_of :ATTR(:get<ProcessingOptions>);

__PACKAGE__->_factory(
    [ qw(        WebAuthenticationDetail
        ClientDetail
        TransactionDetail
        Version
        SelectionDetails
        TransactionTimeOutValueInMilliseconds
        ProcessingOptions

    ) ],
    {
        'WebAuthenticationDetail' => \%WebAuthenticationDetail_of,
        'ClientDetail' => \%ClientDetail_of,
        'TransactionDetail' => \%TransactionDetail_of,
        'Version' => \%Version_of,
        'SelectionDetails' => \%SelectionDetails_of,
        'TransactionTimeOutValueInMilliseconds' => \%TransactionTimeOutValueInMilliseconds_of,
        'ProcessingOptions' => \%ProcessingOptions_of,
    },
    {
        'WebAuthenticationDetail' => 'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail',
        'ClientDetail' => 'Shipment::FedEx::WSDL::TrackTypes::ClientDetail',
        'TransactionDetail' => 'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
        'Version' => 'Shipment::FedEx::WSDL::TrackTypes::VersionId',
        'SelectionDetails' => 'Shipment::FedEx::WSDL::TrackTypes::TrackSelectionDetail',
        'TransactionTimeOutValueInMilliseconds' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'ProcessingOptions' => 'Shipment::FedEx::WSDL::TrackTypes::TrackRequestProcessingOptionType',
    },
    {

        'WebAuthenticationDetail' => 'WebAuthenticationDetail',
        'ClientDetail' => 'ClientDetail',
        'TransactionDetail' => 'TransactionDetail',
        'Version' => 'Version',
        'SelectionDetails' => 'SelectionDetails',
        'TransactionTimeOutValueInMilliseconds' => 'TransactionTimeOutValueInMilliseconds',
        'ProcessingOptions' => 'ProcessingOptions',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::TrackTypes::TrackRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
TrackRequest from the namespace http://fedex.com/ws/track/v9.

The descriptive data sent by a client to track a FedEx package.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * WebAuthenticationDetail


=item * ClientDetail


=item * TransactionDetail


=item * Version


=item * SelectionDetails


=item * TransactionTimeOutValueInMilliseconds


=item * ProcessingOptions




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::TrackTypes::TrackRequest
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
   SelectionDetails =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackSelectionDetail
     CarrierCode => $some_value, # CarrierCodeType
     OperatingCompany => $some_value, # OperatingCompanyType
     PackageIdentifier =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackPackageIdentifier
       Type => $some_value, # TrackIdentifierType
       Value =>  $some_value, # string
     },
     TrackingNumberUniqueIdentifier =>  $some_value, # string
     ShipDateRangeBegin =>  $some_value, # date
     ShipDateRangeEnd =>  $some_value, # date
     ShipmentAccountNumber =>  $some_value, # string
     SecureSpodAccount =>  $some_value, # string
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
     PagingDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::PagingDetail
       PagingToken =>  $some_value, # string
       NumberOfResultsPerPage =>  $some_value, # nonNegativeInteger
     },
     CustomerSpecifiedTimeOutValueInMilliseconds =>  $some_value, # nonNegativeInteger
   },
   TransactionTimeOutValueInMilliseconds =>  $some_value, # nonNegativeInteger
   ProcessingOptions => $some_value, # TrackRequestProcessingOptionType
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

