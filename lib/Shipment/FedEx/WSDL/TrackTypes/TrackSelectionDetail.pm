package Shipment::FedEx::WSDL::TrackTypes::TrackSelectionDetail;
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

my %CarrierCode_of :ATTR(:get<CarrierCode>);
my %OperatingCompany_of :ATTR(:get<OperatingCompany>);
my %PackageIdentifier_of :ATTR(:get<PackageIdentifier>);
my %TrackingNumberUniqueIdentifier_of :ATTR(:get<TrackingNumberUniqueIdentifier>);
my %ShipDateRangeBegin_of :ATTR(:get<ShipDateRangeBegin>);
my %ShipDateRangeEnd_of :ATTR(:get<ShipDateRangeEnd>);
my %ShipmentAccountNumber_of :ATTR(:get<ShipmentAccountNumber>);
my %SecureSpodAccount_of :ATTR(:get<SecureSpodAccount>);
my %Destination_of :ATTR(:get<Destination>);
my %PagingDetail_of :ATTR(:get<PagingDetail>);
my %CustomerSpecifiedTimeOutValueInMilliseconds_of :ATTR(:get<CustomerSpecifiedTimeOutValueInMilliseconds>);

__PACKAGE__->_factory(
    [ qw(        CarrierCode
        OperatingCompany
        PackageIdentifier
        TrackingNumberUniqueIdentifier
        ShipDateRangeBegin
        ShipDateRangeEnd
        ShipmentAccountNumber
        SecureSpodAccount
        Destination
        PagingDetail
        CustomerSpecifiedTimeOutValueInMilliseconds

    ) ],
    {
        'CarrierCode' => \%CarrierCode_of,
        'OperatingCompany' => \%OperatingCompany_of,
        'PackageIdentifier' => \%PackageIdentifier_of,
        'TrackingNumberUniqueIdentifier' => \%TrackingNumberUniqueIdentifier_of,
        'ShipDateRangeBegin' => \%ShipDateRangeBegin_of,
        'ShipDateRangeEnd' => \%ShipDateRangeEnd_of,
        'ShipmentAccountNumber' => \%ShipmentAccountNumber_of,
        'SecureSpodAccount' => \%SecureSpodAccount_of,
        'Destination' => \%Destination_of,
        'PagingDetail' => \%PagingDetail_of,
        'CustomerSpecifiedTimeOutValueInMilliseconds' => \%CustomerSpecifiedTimeOutValueInMilliseconds_of,
    },
    {
        'CarrierCode' => 'Shipment::FedEx::WSDL::TrackTypes::CarrierCodeType',
        'OperatingCompany' => 'Shipment::FedEx::WSDL::TrackTypes::OperatingCompanyType',
        'PackageIdentifier' => 'Shipment::FedEx::WSDL::TrackTypes::TrackPackageIdentifier',
        'TrackingNumberUniqueIdentifier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ShipDateRangeBegin' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
        'ShipDateRangeEnd' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
        'ShipmentAccountNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'SecureSpodAccount' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Destination' => 'Shipment::FedEx::WSDL::TrackTypes::Address',
        'PagingDetail' => 'Shipment::FedEx::WSDL::TrackTypes::PagingDetail',
        'CustomerSpecifiedTimeOutValueInMilliseconds' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    },
    {

        'CarrierCode' => 'CarrierCode',
        'OperatingCompany' => 'OperatingCompany',
        'PackageIdentifier' => 'PackageIdentifier',
        'TrackingNumberUniqueIdentifier' => 'TrackingNumberUniqueIdentifier',
        'ShipDateRangeBegin' => 'ShipDateRangeBegin',
        'ShipDateRangeEnd' => 'ShipDateRangeEnd',
        'ShipmentAccountNumber' => 'ShipmentAccountNumber',
        'SecureSpodAccount' => 'SecureSpodAccount',
        'Destination' => 'Destination',
        'PagingDetail' => 'PagingDetail',
        'CustomerSpecifiedTimeOutValueInMilliseconds' => 'CustomerSpecifiedTimeOutValueInMilliseconds',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::TrackTypes::TrackSelectionDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
TrackSelectionDetail from the namespace http://fedex.com/ws/track/v9.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * CarrierCode


=item * OperatingCompany


=item * PackageIdentifier


=item * TrackingNumberUniqueIdentifier


=item * ShipDateRangeBegin


=item * ShipDateRangeEnd


=item * ShipmentAccountNumber


=item * SecureSpodAccount


=item * Destination


=item * PagingDetail


=item * CustomerSpecifiedTimeOutValueInMilliseconds




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::TrackTypes::TrackSelectionDetail
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

