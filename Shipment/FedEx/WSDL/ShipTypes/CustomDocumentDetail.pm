package Shipment::FedEx::WSDL::ShipTypes::CustomDocumentDetail;
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

my %Format_of :ATTR(:get<Format>);
my %LabelPrintingOrientation_of :ATTR(:get<LabelPrintingOrientation>);
my %LabelRotation_of :ATTR(:get<LabelRotation>);
my %SpecificationId_of :ATTR(:get<SpecificationId>);
my %CustomDocumentIdentifier_of :ATTR(:get<CustomDocumentIdentifier>);
my %DocTabContent_of :ATTR(:get<DocTabContent>);

__PACKAGE__->_factory(
    [ qw(        Format
        LabelPrintingOrientation
        LabelRotation
        SpecificationId
        CustomDocumentIdentifier
        DocTabContent

    ) ],
    {
        'Format' => \%Format_of,
        'LabelPrintingOrientation' => \%LabelPrintingOrientation_of,
        'LabelRotation' => \%LabelRotation_of,
        'SpecificationId' => \%SpecificationId_of,
        'CustomDocumentIdentifier' => \%CustomDocumentIdentifier_of,
        'DocTabContent' => \%DocTabContent_of,
    },
    {
        'Format' => 'Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentFormat',
        'LabelPrintingOrientation' => 'Shipment::FedEx::WSDL::ShipTypes::LabelPrintingOrientationType',
        'LabelRotation' => 'Shipment::FedEx::WSDL::ShipTypes::LabelRotationType',
        'SpecificationId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CustomDocumentIdentifier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DocTabContent' => 'Shipment::FedEx::WSDL::ShipTypes::DocTabContent',
    },
    {

        'Format' => 'Format',
        'LabelPrintingOrientation' => 'LabelPrintingOrientation',
        'LabelRotation' => 'LabelRotation',
        'SpecificationId' => 'SpecificationId',
        'CustomDocumentIdentifier' => 'CustomDocumentIdentifier',
        'DocTabContent' => 'DocTabContent',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::CustomDocumentDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CustomDocumentDetail from the namespace http://fedex.com/ws/ship/v9.

Data required to produce a custom-specified document, either at shipment or package level.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Format (min/maxOccurs: 0/1)


=item * LabelPrintingOrientation (min/maxOccurs: 0/1)


=item * LabelRotation (min/maxOccurs: 0/1)


=item * SpecificationId (min/maxOccurs: 0/1)


=item * CustomDocumentIdentifier (min/maxOccurs: 0/1)


=item * DocTabContent (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::CustomDocumentDetail
   Format =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentFormat
     Dispositions =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentDispositionDetail
       DispositionType => $some_value, # ShippingDocumentDispositionType
       Grouping => $some_value, # ShippingDocumentGroupingType
       EMailDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentEMailDetail
         EMailRecipients =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentEMailRecipient
           RecipientType => $some_value, # EMailNotificationRecipientType
           Address =>  $some_value, # string
         },
         Grouping => $some_value, # ShippingDocumentEMailGroupingType
       },
       PrintDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::ShippingDocumentPrintDetail
         PrinterId =>  $some_value, # string
       },
     },
     TopOfPageOffset =>  { # Shipment::FedEx::WSDL::ShipTypes::LinearMeasure
       Value =>  $some_value, # decimal
       Units => $some_value, # LinearUnits
     },
     ImageType => $some_value, # ShippingDocumentImageType
     StockType => $some_value, # ShippingDocumentStockType
     ProvideInstructions =>  $some_value, # boolean
     Localization =>  { # Shipment::FedEx::WSDL::ShipTypes::Localization
       LanguageCode =>  $some_value, # string
       LocaleCode =>  $some_value, # string
     },
     CustomDocumentIdentifier =>  $some_value, # string
   },
   LabelPrintingOrientation => $some_value, # LabelPrintingOrientationType
   LabelRotation => $some_value, # LabelRotationType
   SpecificationId =>  $some_value, # string
   CustomDocumentIdentifier =>  $some_value, # string
   DocTabContent =>  { # Shipment::FedEx::WSDL::ShipTypes::DocTabContent
     DocTabContentType => $some_value, # DocTabContentType
     Zone001 =>  { # Shipment::FedEx::WSDL::ShipTypes::DocTabContentZone001
       DocTabZoneSpecifications =>  { # Shipment::FedEx::WSDL::ShipTypes::DocTabZoneSpecification
         ZoneNumber =>  $some_value, # positiveInteger
         Header =>  $some_value, # string
         DataField =>  $some_value, # string
         LiteralValue =>  $some_value, # string
         Justification => $some_value, # DocTabZoneJustificationType
       },
     },
     Barcoded =>  { # Shipment::FedEx::WSDL::ShipTypes::DocTabContentBarcoded
       Symbology => $some_value, # BarcodeSymbologyType
       Specification => {}, # Shipment::FedEx::WSDL::ShipTypes::DocTabZoneSpecification
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

