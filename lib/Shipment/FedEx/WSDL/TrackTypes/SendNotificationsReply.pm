package Shipment::FedEx::WSDL::TrackTypes::SendNotificationsReply;
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

my %HighestSeverity_of :ATTR(:get<HighestSeverity>);
my %Notifications_of :ATTR(:get<Notifications>);
my %TransactionDetail_of :ATTR(:get<TransactionDetail>);
my %Version_of :ATTR(:get<Version>);
my %DuplicateWaybill_of :ATTR(:get<DuplicateWaybill>);
my %MoreDataAvailable_of :ATTR(:get<MoreDataAvailable>);
my %PagingToken_of :ATTR(:get<PagingToken>);
my %Packages_of :ATTR(:get<Packages>);

__PACKAGE__->_factory(
    [ qw(        HighestSeverity
        Notifications
        TransactionDetail
        Version
        DuplicateWaybill
        MoreDataAvailable
        PagingToken
        Packages

    ) ],
    {
        'HighestSeverity' => \%HighestSeverity_of,
        'Notifications' => \%Notifications_of,
        'TransactionDetail' => \%TransactionDetail_of,
        'Version' => \%Version_of,
        'DuplicateWaybill' => \%DuplicateWaybill_of,
        'MoreDataAvailable' => \%MoreDataAvailable_of,
        'PagingToken' => \%PagingToken_of,
        'Packages' => \%Packages_of,
    },
    {
        'HighestSeverity' => 'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
        'Notifications' => 'Shipment::FedEx::WSDL::TrackTypes::Notification',
        'TransactionDetail' => 'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
        'Version' => 'Shipment::FedEx::WSDL::TrackTypes::VersionId',
        'DuplicateWaybill' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'MoreDataAvailable' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'PagingToken' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Packages' => 'Shipment::FedEx::WSDL::TrackTypes::TrackNotificationPackage',
    },
    {

        'HighestSeverity' => 'HighestSeverity',
        'Notifications' => 'Notifications',
        'TransactionDetail' => 'TransactionDetail',
        'Version' => 'Version',
        'DuplicateWaybill' => 'DuplicateWaybill',
        'MoreDataAvailable' => 'MoreDataAvailable',
        'PagingToken' => 'PagingToken',
        'Packages' => 'Packages',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::TrackTypes::SendNotificationsReply

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
SendNotificationsReply from the namespace http://fedex.com/ws/track/v9.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * HighestSeverity


=item * Notifications


=item * TransactionDetail


=item * Version


=item * DuplicateWaybill


=item * MoreDataAvailable


=item * PagingToken


=item * Packages




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::TrackTypes::SendNotificationsReply
   HighestSeverity => $some_value, # NotificationSeverityType
   Notifications =>  { # Shipment::FedEx::WSDL::TrackTypes::Notification
     Severity => $some_value, # NotificationSeverityType
     Source =>  $some_value, # string
     Code =>  $some_value, # string
     Message =>  $some_value, # string
     LocalizedMessage =>  $some_value, # string
     MessageParameters =>  { # Shipment::FedEx::WSDL::TrackTypes::NotificationParameter
       Id =>  $some_value, # string
       Value =>  $some_value, # string
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
   DuplicateWaybill =>  $some_value, # boolean
   MoreDataAvailable =>  $some_value, # boolean
   PagingToken =>  $some_value, # string
   Packages =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackNotificationPackage
     TrackingNumber =>  $some_value, # string
     TrackingNumberUniqueIdentifiers =>  $some_value, # string
     CarrierCode => $some_value, # CarrierCodeType
     ShipDate =>  $some_value, # date
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
     RecipientDetails =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackNotificationRecipientDetail
       NotificationEventsAvailable => $some_value, # EMailNotificationEventType
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

