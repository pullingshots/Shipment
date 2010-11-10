package Shipment::FedEx::WSDL::RateTypes::LabelSpecification;
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

my %LabelFormatType_of :ATTR(:get<LabelFormatType>);
my %ImageType_of :ATTR(:get<ImageType>);
my %LabelStockType_of :ATTR(:get<LabelStockType>);
my %LabelPrintingOrientation_of :ATTR(:get<LabelPrintingOrientation>);
my %LabelRotation_of :ATTR(:get<LabelRotation>);
my %PrintedLabelOrigin_of :ATTR(:get<PrintedLabelOrigin>);
my %CustomerSpecifiedDetail_of :ATTR(:get<CustomerSpecifiedDetail>);

__PACKAGE__->_factory(
    [ qw(        LabelFormatType
        ImageType
        LabelStockType
        LabelPrintingOrientation
        LabelRotation
        PrintedLabelOrigin
        CustomerSpecifiedDetail

    ) ],
    {
        'LabelFormatType' => \%LabelFormatType_of,
        'ImageType' => \%ImageType_of,
        'LabelStockType' => \%LabelStockType_of,
        'LabelPrintingOrientation' => \%LabelPrintingOrientation_of,
        'LabelRotation' => \%LabelRotation_of,
        'PrintedLabelOrigin' => \%PrintedLabelOrigin_of,
        'CustomerSpecifiedDetail' => \%CustomerSpecifiedDetail_of,
    },
    {
        'LabelFormatType' => 'Shipment::FedEx::WSDL::RateTypes::LabelFormatType',
        'ImageType' => 'Shipment::FedEx::WSDL::RateTypes::ShippingDocumentImageType',
        'LabelStockType' => 'Shipment::FedEx::WSDL::RateTypes::LabelStockType',
        'LabelPrintingOrientation' => 'Shipment::FedEx::WSDL::RateTypes::LabelPrintingOrientationType',
        'LabelRotation' => 'Shipment::FedEx::WSDL::RateTypes::LabelRotationType',
        'PrintedLabelOrigin' => 'Shipment::FedEx::WSDL::RateTypes::ContactAndAddress',
        'CustomerSpecifiedDetail' => 'Shipment::FedEx::WSDL::RateTypes::CustomerSpecifiedLabelDetail',
    },
    {

        'LabelFormatType' => 'LabelFormatType',
        'ImageType' => 'ImageType',
        'LabelStockType' => 'LabelStockType',
        'LabelPrintingOrientation' => 'LabelPrintingOrientation',
        'LabelRotation' => 'LabelRotation',
        'PrintedLabelOrigin' => 'PrintedLabelOrigin',
        'CustomerSpecifiedDetail' => 'CustomerSpecifiedDetail',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::LabelSpecification

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
LabelSpecification from the namespace http://fedex.com/ws/rate/v9.

Description of shipping label to be returned in the reply




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * LabelFormatType (min/maxOccurs: 0/1)


=item * ImageType (min/maxOccurs: 0/1)


=item * LabelStockType (min/maxOccurs: 0/1)


=item * LabelPrintingOrientation (min/maxOccurs: 0/1)


=item * LabelRotation (min/maxOccurs: 0/1)


=item * PrintedLabelOrigin (min/maxOccurs: 0/1)


=item * CustomerSpecifiedDetail (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::LabelSpecification
   LabelFormatType => $some_value, # LabelFormatType
   ImageType => $some_value, # ShippingDocumentImageType
   LabelStockType => $some_value, # LabelStockType
   LabelPrintingOrientation => $some_value, # LabelPrintingOrientationType
   LabelRotation => $some_value, # LabelRotationType
   PrintedLabelOrigin =>  { # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
     Contact =>  { # Shipment::FedEx::WSDL::RateTypes::Contact
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
   CustomerSpecifiedDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CustomerSpecifiedLabelDetail
     DocTabContent =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabContent
       DocTabContentType => $some_value, # DocTabContentType
       Zone001 =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabContentZone001
         DocTabZoneSpecifications =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabZoneSpecification
           ZoneNumber =>  $some_value, # positiveInteger
           Header =>  $some_value, # string
           DataField =>  $some_value, # string
           LiteralValue =>  $some_value, # string
           Justification => $some_value, # DocTabZoneJustificationType
         },
       },
       Barcoded =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabContentBarcoded
         Symbology => $some_value, # BarcodeSymbologyType
         Specification => {}, # Shipment::FedEx::WSDL::RateTypes::DocTabZoneSpecification
       },
     },
     CustomContent =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelDetail
       CoordinateUnits => $some_value, # CustomLabelCoordinateUnits
       TextEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelTextEntry
         Position =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
           X =>  $some_value, # nonNegativeInteger
           Y =>  $some_value, # nonNegativeInteger
         },
         Format =>  $some_value, # string
         DataFields =>  $some_value, # string
         ThermalFontId =>  $some_value, # string
         FontName =>  $some_value, # string
         FontSize =>  $some_value, # positiveInteger
       },
       GraphicEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelGraphicEntry
         Position => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
         PrinterGraphicId =>  $some_value, # string
         FileGraphicFullName =>  $some_value, # string
       },
       BoxEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelBoxEntry
         TopLeftCorner => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
         BottomRightCorner => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
       },
       BarcodeEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelBarcodeEntry
         Position => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
         Format =>  $some_value, # string
         DataFields =>  $some_value, # string
         BarHeight =>  $some_value, # int
         ThinBarWidth =>  $some_value, # int
         BarcodeSymbology => $some_value, # BarcodeSymbologyType
       },
     },
     ConfigurableReferenceEntries =>  { # Shipment::FedEx::WSDL::RateTypes::ConfigurableLabelReferenceEntry
       ZoneNumber =>  $some_value, # positiveInteger
       Header =>  $some_value, # string
       DataField =>  $some_value, # string
       LiteralValue =>  $some_value, # string
     },
     MaskedData => $some_value, # LabelMaskableDataType
     TermsAndConditionsLocalization =>  { # Shipment::FedEx::WSDL::RateTypes::Localization
       LanguageCode =>  $some_value, # string
       LocaleCode =>  $some_value, # string
     },
     AdditionalLabels =>  { # Shipment::FedEx::WSDL::RateTypes::AdditionalLabelsDetail
       Type => $some_value, # AdditionalLabelsType
       Count =>  $some_value, # nonNegativeInteger
     },
     AirWaybillSuppressionCount =>  $some_value, # nonNegativeInteger
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

