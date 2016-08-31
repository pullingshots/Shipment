package Shipment::FedEx::WSDL::TrackTypes::SendNotificationsRequest;
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
my %TrackingNumber_of :ATTR(:get<TrackingNumber>);
my %MultiPiece_of :ATTR(:get<MultiPiece>);
my %PagingToken_of :ATTR(:get<PagingToken>);
my %TrackingNumberUniqueId_of :ATTR(:get<TrackingNumberUniqueId>);
my %ShipDateRangeBegin_of :ATTR(:get<ShipDateRangeBegin>);
my %ShipDateRangeEnd_of :ATTR(:get<ShipDateRangeEnd>);
my %SenderEMailAddress_of :ATTR(:get<SenderEMailAddress>);
my %SenderContactName_of :ATTR(:get<SenderContactName>);
my %NotificationDetail_of :ATTR(:get<NotificationDetail>);

__PACKAGE__->_factory(
    [ qw(        WebAuthenticationDetail
        ClientDetail
        TransactionDetail
        Version
        TrackingNumber
        MultiPiece
        PagingToken
        TrackingNumberUniqueId
        ShipDateRangeBegin
        ShipDateRangeEnd
        SenderEMailAddress
        SenderContactName
        NotificationDetail

    ) ],
    {
        'WebAuthenticationDetail' => \%WebAuthenticationDetail_of,
        'ClientDetail' => \%ClientDetail_of,
        'TransactionDetail' => \%TransactionDetail_of,
        'Version' => \%Version_of,
        'TrackingNumber' => \%TrackingNumber_of,
        'MultiPiece' => \%MultiPiece_of,
        'PagingToken' => \%PagingToken_of,
        'TrackingNumberUniqueId' => \%TrackingNumberUniqueId_of,
        'ShipDateRangeBegin' => \%ShipDateRangeBegin_of,
        'ShipDateRangeEnd' => \%ShipDateRangeEnd_of,
        'SenderEMailAddress' => \%SenderEMailAddress_of,
        'SenderContactName' => \%SenderContactName_of,
        'NotificationDetail' => \%NotificationDetail_of,
    },
    {
        'WebAuthenticationDetail' => 'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail',
        'ClientDetail' => 'Shipment::FedEx::WSDL::TrackTypes::ClientDetail',
        'TransactionDetail' => 'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
        'Version' => 'Shipment::FedEx::WSDL::TrackTypes::VersionId',
        'TrackingNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'MultiPiece' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'PagingToken' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'TrackingNumberUniqueId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ShipDateRangeBegin' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
        'ShipDateRangeEnd' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
        'SenderEMailAddress' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'SenderContactName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'NotificationDetail' => 'Shipment::FedEx::WSDL::TrackTypes::EMailNotificationDetail',
    },
    {

        'WebAuthenticationDetail' => 'WebAuthenticationDetail',
        'ClientDetail' => 'ClientDetail',
        'TransactionDetail' => 'TransactionDetail',
        'Version' => 'Version',
        'TrackingNumber' => 'TrackingNumber',
        'MultiPiece' => 'MultiPiece',
        'PagingToken' => 'PagingToken',
        'TrackingNumberUniqueId' => 'TrackingNumberUniqueId',
        'ShipDateRangeBegin' => 'ShipDateRangeBegin',
        'ShipDateRangeEnd' => 'ShipDateRangeEnd',
        'SenderEMailAddress' => 'SenderEMailAddress',
        'SenderContactName' => 'SenderContactName',
        'NotificationDetail' => 'NotificationDetail',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::TrackTypes::SendNotificationsRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
SendNotificationsRequest from the namespace http://fedex.com/ws/track/v9.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * WebAuthenticationDetail


=item * ClientDetail


=item * TransactionDetail


=item * Version


=item * TrackingNumber


=item * MultiPiece


=item * PagingToken


=item * TrackingNumberUniqueId


=item * ShipDateRangeBegin


=item * ShipDateRangeEnd


=item * SenderEMailAddress


=item * SenderContactName


=item * NotificationDetail




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::TrackTypes::SendNotificationsRequest
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
   TrackingNumber =>  $some_value, # string
   MultiPiece =>  $some_value, # boolean
   PagingToken =>  $some_value, # string
   TrackingNumberUniqueId =>  $some_value, # string
   ShipDateRangeBegin =>  $some_value, # date
   ShipDateRangeEnd =>  $some_value, # date
   SenderEMailAddress =>  $some_value, # string
   SenderContactName =>  $some_value, # string
   NotificationDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::EMailNotificationDetail
     PersonalMessage =>  $some_value, # string
     Recipients =>  { # Shipment::FedEx::WSDL::TrackTypes::EMailNotificationRecipient
       EMailNotificationRecipientType => $some_value, # EMailNotificationRecipientType
       EMailAddress =>  $some_value, # string
       NotificationEventsRequested => $some_value, # EMailNotificationEventType
       Format => $some_value, # EMailNotificationFormatType
       Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
         LanguageCode =>  $some_value, # string
         LocaleCode =>  $some_value, # string
       },
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

