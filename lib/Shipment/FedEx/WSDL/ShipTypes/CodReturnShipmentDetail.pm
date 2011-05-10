package Shipment::FedEx::WSDL::ShipTypes::CodReturnShipmentDetail;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/ship/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %CollectionAmount_of :ATTR(:get<CollectionAmount>);
my %Handling_of :ATTR(:get<Handling>);
my %ServiceTypeDescription_of :ATTR(:get<ServiceTypeDescription>);
my %PackagingDescription_of :ATTR(:get<PackagingDescription>);
my %SecuredDescription_of :ATTR(:get<SecuredDescription>);
my %Remitter_of :ATTR(:get<Remitter>);
my %CodRecipient_of :ATTR(:get<CodRecipient>);
my %CodRoutingDetail_of :ATTR(:get<CodRoutingDetail>);
my %Barcodes_of :ATTR(:get<Barcodes>);
my %Label_of :ATTR(:get<Label>);

__PACKAGE__->_factory(
    [ qw(        CollectionAmount
        Handling
        ServiceTypeDescription
        PackagingDescription
        SecuredDescription
        Remitter
        CodRecipient
        CodRoutingDetail
        Barcodes
        Label

    ) ],
    {
        'CollectionAmount' => \%CollectionAmount_of,
        'Handling' => \%Handling_of,
        'ServiceTypeDescription' => \%ServiceTypeDescription_of,
        'PackagingDescription' => \%PackagingDescription_of,
        'SecuredDescription' => \%SecuredDescription_of,
        'Remitter' => \%Remitter_of,
        'CodRecipient' => \%CodRecipient_of,
        'CodRoutingDetail' => \%CodRoutingDetail_of,
        'Barcodes' => \%Barcodes_of,
        'Label' => \%Label_of,
    },
    {
        'CollectionAmount' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'Handling' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ServiceTypeDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PackagingDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'SecuredDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Remitter' => 'Shipment::FedEx::WSDL::ShipTypes::Party',
        'CodRecipient' => 'Shipment::FedEx::WSDL::ShipTypes::Party',
        'CodRoutingDetail' => 'Shipment::FedEx::WSDL::ShipTypes::RoutingDetail',
        'Barcodes' => 'Shipment::FedEx::WSDL::ShipTypes::PackageBarcodes',
        'Label' => 'Shipment::FedEx::WSDL::ShipTypes::ShippingDocument',
    },
    {

        'CollectionAmount' => 'CollectionAmount',
        'Handling' => 'Handling',
        'ServiceTypeDescription' => 'ServiceTypeDescription',
        'PackagingDescription' => 'PackagingDescription',
        'SecuredDescription' => 'SecuredDescription',
        'Remitter' => 'Remitter',
        'CodRecipient' => 'CodRecipient',
        'CodRoutingDetail' => 'CodRoutingDetail',
        'Barcodes' => 'Barcodes',
        'Label' => 'Label',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::CodReturnShipmentDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CodReturnShipmentDetail from the namespace http://fedex.com/ws/ship/v9.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * CollectionAmount (min/maxOccurs: 0/1)


=item * Handling (min/maxOccurs: 0/1)


=item * ServiceTypeDescription (min/maxOccurs: 0/1)


=item * PackagingDescription (min/maxOccurs: 0/1)


=item * SecuredDescription (min/maxOccurs: 0/1)


=item * Remitter (min/maxOccurs: 0/1)


=item * CodRecipient (min/maxOccurs: 0/1)


=item * CodRoutingDetail (min/maxOccurs: 0/1)


=item * Barcodes (min/maxOccurs: 0/1)


=item * Label (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::CodReturnShipmentDetail
   CollectionAmount =>  { # Shipment::FedEx::WSDL::ShipTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   Handling =>  $some_value, # string
   ServiceTypeDescription =>  $some_value, # string
   PackagingDescription =>  $some_value, # string
   SecuredDescription =>  $some_value, # string
   Remitter =>  { # Shipment::FedEx::WSDL::ShipTypes::Party
     AccountNumber =>  $some_value, # string
     Tins =>  { # Shipment::FedEx::WSDL::ShipTypes::TaxpayerIdentification
       TinType => $some_value, # TinType
       Number =>  $some_value, # string
       Usage =>  $some_value, # string
     },
     Contact =>  { # Shipment::FedEx::WSDL::ShipTypes::Contact
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
     Address =>  { # Shipment::FedEx::WSDL::ShipTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
   },
   CodRecipient => {}, # Shipment::FedEx::WSDL::ShipTypes::Party
   CodRoutingDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::RoutingDetail
     ShipmentRoutingDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ShipmentRoutingDetail
       UrsaPrefixCode =>  $some_value, # string
       UrsaSuffixCode =>  $some_value, # string
       OriginLocationId =>  $some_value, # string
       OriginServiceArea =>  $some_value, # string
       DestinationLocationId =>  $some_value, # string
       DestinationServiceArea =>  $some_value, # string
       DestinationLocationStateOrProvinceCode =>  $some_value, # string
       DeliveryDate =>  $some_value, # date
       DeliveryDay => $some_value, # DayOfWeekType
       CommitDate =>  $some_value, # date
       CommitDay => $some_value, # DayOfWeekType
       TransitTime => $some_value, # TransitTimeType
       MaximumTransitTime => $some_value, # TransitTimeType
       AstraPlannedServiceLevel =>  $some_value, # string
       AstraDescription =>  $some_value, # string
       PostalCode =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       AirportId =>  $some_value, # string
     },
     AstraDetails =>  { # Shipment::FedEx::WSDL::ShipTypes::RoutingAstraDetail
       TrackingId =>  { # Shipment::FedEx::WSDL::ShipTypes::TrackingId
         TrackingIdType => $some_value, # TrackingIdType
         FormId =>  $some_value, # string
         UspsApplicationId =>  $some_value, # string
         TrackingNumber =>  $some_value, # string
       },
       Barcode =>  { # Shipment::FedEx::WSDL::ShipTypes::StringBarcode
         Type => $some_value, # StringBarcodeType
         Value =>  $some_value, # string
       },
       AstraHandlingText =>  $some_value, # string
       AstraLabelElements =>  { # Shipment::FedEx::WSDL::ShipTypes::AstraLabelElement
         Number =>  $some_value, # int
         Content =>  $some_value, # string
       },
     },
   },
   Barcodes =>  { # Shipment::FedEx::WSDL::ShipTypes::PackageBarcodes
     BinaryBarcodes =>  { # Shipment::FedEx::WSDL::ShipTypes::BinaryBarcode
       Type => $some_value, # BinaryBarcodeType
       Value =>  $some_value, # base64Binary
     },
     StringBarcodes => {}, # Shipment::FedEx::WSDL::ShipTypes::StringBarcode
   },
   Label =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocument
     Type => $some_value, # ReturnedShippingDocumentType
     Grouping => $some_value, # ShippingDocumentGroupingType
     ShippingDocumentDisposition => $some_value, # ShippingDocumentDispositionType
     AccessReference =>  $some_value, # string
     Resolution =>  $some_value, # nonNegativeInteger
     CopiesToPrint =>  $some_value, # nonNegativeInteger
     Parts =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentPart
       DocumentPartSequenceNumber =>  $some_value, # positiveInteger
       Image =>  $some_value, # base64Binary
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

