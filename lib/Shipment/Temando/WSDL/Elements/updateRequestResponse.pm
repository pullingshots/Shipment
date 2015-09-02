
package Shipment::Temando::WSDL::Elements::updateRequestResponse;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/server.xsd' }

__PACKAGE__->__set_name('updateRequestResponse');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %requestId_of :ATTR(:get<requestId>);
my %quote_of :ATTR(:get<quote>);

__PACKAGE__->_factory(
    [ qw(        requestId
        quote

    ) ],
    {
        'requestId' => \%requestId_of,
        'quote' => \%quote_of,
    },
    {
        'requestId' => 'SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger',
        'quote' => 'Shipment::Temando::WSDL::Types::AvailableQuote',
    },
    {

        'requestId' => 'requestId',
        'quote' => 'quote',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Elements::updateRequestResponse

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
updateRequestResponse from the namespace http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/server.xsd.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * requestId

 $element->set_requestId($data);
 $element->get_requestId();




=item * quote

 $element->set_quote($data);
 $element->get_quote();





=back


=head1 METHODS

=head2 new

 my $element = Shipment::Temando::WSDL::Elements::updateRequestResponse->new($data);

Constructor. The following data structure may be passed to new():

 {
   requestId =>  $some_value, # positiveInteger
   quote =>  { # Shipment::Temando::WSDL::Types::AvailableQuote
     generated => $some_value, # GeneratedType
     accepted => $some_value, # YesNoOption
     bookingNumber => $some_value, # BookingNumber
     consignmentNumber => $some_value, # ConsignmentNumber
     consignmentDocument => $some_value, # ConsignmentDocument
     consignmentDocumentType => $some_value, # ConsignmentDocumentType
     labelDocument => $some_value, # LabelDocument
     labelDocumentType => $some_value, # LabelDocumentType
     manifestNumber => $some_value, # ManifestNumber
     articles =>  {
       article =>  { # Shipment::Temando::WSDL::Types::Article
         anythingIndex => $some_value, # AnythingIndex
         articleNumber => $some_value, # ArticleNumber
         labelDocument => $some_value, # LabelDocument
         labelDocumentType => $some_value, # LabelDocumentType
       },
     },
     trackingStatus => $some_value, # TrackingStatus
     trackingStatusOccurred => $some_value, # Datetime
     trackingLastChecked => $some_value, # Datetime
     trackingFurtherDetails => $some_value, # TrackingFurtherDetails
     totalPrice => $some_value, # CurrencyAmount
     basePrice => $some_value, # CurrencyAmount
     tax => $some_value, # CurrencyAmount
     currency => $some_value, # CurrencyType
     deliveryMethod => $some_value, # DeliveryMethod
     usingGeneralRail => $some_value, # YesNoOption
     usingGeneralRoad => $some_value, # YesNoOption
     usingGeneralSea => $some_value, # YesNoOption
     usingExpressAir => $some_value, # YesNoOption
     usingExpressRoad => $some_value, # YesNoOption
     etaFrom => $some_value, # Eta
     etaTo => $some_value, # Eta
     guaranteedEta => $some_value, # YesNoOption
     adjustments =>  {
       adjustment =>  { # Shipment::Temando::WSDL::Types::Adjustment
         description => $some_value, # AdjustmentDescription
         amount => $some_value, # CurrencyAmount
         tax => $some_value, # CurrencyAmount
       },
     },
     inclusions =>  {
       inclusion =>  { # Shipment::Temando::WSDL::Types::Inclusion
         summary => $some_value, # InclusionSummary
         details => $some_value, # InclusionDetails
       },
     },
     extras =>  {
       extra =>  { # Shipment::Temando::WSDL::Types::Extra
         summary => $some_value, # ExtraSummary
         details => $some_value, # ExtraDetails
         totalPrice => $some_value, # CurrencyAmount
         basePrice => $some_value, # CurrencyAmount
         tax => $some_value, # CurrencyAmount
         adjustments =>  {
           adjustment => {}, # Shipment::Temando::WSDL::Types::Adjustment
         },
       },
     },
     carrier =>  { # Shipment::Temando::WSDL::Types::Carrier
       id => $some_value, # CarrierId
       companyName => $some_value, # CompanyName
       companyContact => $some_value, # ContactName
       streetAddress => $some_value, # Address
       streetSuburb => $some_value, # Suburb
       streetCity => $some_value, # City
       streetState => $some_value, # State
       streetCode => $some_value, # PostalCode
       streetCountry => $some_value, # CountryCode
       postalAddress => $some_value, # Address
       postalSuburb => $some_value, # Suburb
       postalCity => $some_value, # City
       postalState => $some_value, # State
       postalCode => $some_value, # PostalCode
       postalCountry => $some_value, # CountryCode
       phone1 => $some_value, # Phone
       phone2 => $some_value, # Phone
       email => $some_value, # Email
       website => $some_value, # Website
       conditions => $some_value, # CarrierConditions
     },
     originatingDepot =>  { # Shipment::Temando::WSDL::Types::Depot
       name => $some_value, # DepotName
       street => $some_value, # Address
       suburb => $some_value, # Suburb
       city => $some_value, # City
       state => $some_value, # State
       code => $some_value, # PostalCode
       country => $some_value, # CountryCode
       phone1 => $some_value, # Phone
       phone2 => $some_value, # Phone
       fax => $some_value, # Fax
       instructions => $some_value, # DepotInstructions
     },
     destinationDepot => {}, # Shipment::Temando::WSDL::Types::Depot
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

