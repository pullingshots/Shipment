package Shipment::FedEx::WSDL::ShipTypes::CustomerSpecifiedLabelDetail;
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

my %DocTabContent_of :ATTR(:get<DocTabContent>);
my %CustomContent_of :ATTR(:get<CustomContent>);
my %ConfigurableReferenceEntries_of :ATTR(:get<ConfigurableReferenceEntries>);
my %MaskedData_of :ATTR(:get<MaskedData>);
my %ScncOverride_of :ATTR(:get<ScncOverride>);
my %TermsAndConditionsLocalization_of :ATTR(:get<TermsAndConditionsLocalization>);
my %AdditionalLabels_of :ATTR(:get<AdditionalLabels>);
my %AirWaybillSuppressionCount_of :ATTR(:get<AirWaybillSuppressionCount>);

__PACKAGE__->_factory(
    [ qw(        DocTabContent
        CustomContent
        ConfigurableReferenceEntries
        MaskedData
        ScncOverride
        TermsAndConditionsLocalization
        AdditionalLabels
        AirWaybillSuppressionCount

    ) ],
    {
        'DocTabContent' => \%DocTabContent_of,
        'CustomContent' => \%CustomContent_of,
        'ConfigurableReferenceEntries' => \%ConfigurableReferenceEntries_of,
        'MaskedData' => \%MaskedData_of,
        'ScncOverride' => \%ScncOverride_of,
        'TermsAndConditionsLocalization' => \%TermsAndConditionsLocalization_of,
        'AdditionalLabels' => \%AdditionalLabels_of,
        'AirWaybillSuppressionCount' => \%AirWaybillSuppressionCount_of,
    },
    {
        'DocTabContent' => 'Shipment::FedEx::WSDL::ShipTypes::DocTabContent',
        'CustomContent' => 'Shipment::FedEx::WSDL::ShipTypes::CustomLabelDetail',
        'ConfigurableReferenceEntries' => 'Shipment::FedEx::WSDL::ShipTypes::ConfigurableLabelReferenceEntry',
        'MaskedData' => 'Shipment::FedEx::WSDL::ShipTypes::LabelMaskableDataType',
        'ScncOverride' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'TermsAndConditionsLocalization' => 'Shipment::FedEx::WSDL::ShipTypes::Localization',
        'AdditionalLabels' => 'Shipment::FedEx::WSDL::ShipTypes::AdditionalLabelsDetail',
        'AirWaybillSuppressionCount' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    },
    {

        'DocTabContent' => 'DocTabContent',
        'CustomContent' => 'CustomContent',
        'ConfigurableReferenceEntries' => 'ConfigurableReferenceEntries',
        'MaskedData' => 'MaskedData',
        'ScncOverride' => 'ScncOverride',
        'TermsAndConditionsLocalization' => 'TermsAndConditionsLocalization',
        'AdditionalLabels' => 'AdditionalLabels',
        'AirWaybillSuppressionCount' => 'AirWaybillSuppressionCount',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::CustomerSpecifiedLabelDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CustomerSpecifiedLabelDetail from the namespace http://fedex.com/ws/ship/v9.

Allows customer-specified control of label content.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * DocTabContent (min/maxOccurs: 0/1)


=item * CustomContent (min/maxOccurs: 0/1)


=item * ConfigurableReferenceEntries (min/maxOccurs: 0/unbounded)


=item * MaskedData (min/maxOccurs: 0/unbounded)


=item * ScncOverride (min/maxOccurs: 0/1)


=item * TermsAndConditionsLocalization (min/maxOccurs: 0/1)


=item * AdditionalLabels (min/maxOccurs: 0/unbounded)


=item * AirWaybillSuppressionCount (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::CustomerSpecifiedLabelDetail
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
   CustomContent =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelDetail
     CoordinateUnits => $some_value, # CustomLabelCoordinateUnits
     TextEntries =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelTextEntry
       Position =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelPosition
         X =>  $some_value, # nonNegativeInteger
         Y =>  $some_value, # nonNegativeInteger
       },
       Format =>  $some_value, # string
       DataFields =>  $some_value, # string
       ThermalFontId =>  $some_value, # string
       FontName =>  $some_value, # string
       FontSize =>  $some_value, # positiveInteger
     },
     GraphicEntries =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelGraphicEntry
       Position => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomLabelPosition
       PrinterGraphicId =>  $some_value, # string
       FileGraphicFullName =>  $some_value, # string
     },
     BoxEntries =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelBoxEntry
       TopLeftCorner => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomLabelPosition
       BottomRightCorner => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomLabelPosition
     },
     BarcodeEntries =>  { # Shipment::FedEx::WSDL::ShipTypes::CustomLabelBarcodeEntry
       Position => {}, # Shipment::FedEx::WSDL::ShipTypes::CustomLabelPosition
       Format =>  $some_value, # string
       DataFields =>  $some_value, # string
       BarHeight =>  $some_value, # int
       ThinBarWidth =>  $some_value, # int
       BarcodeSymbology => $some_value, # BarcodeSymbologyType
     },
   },
   ConfigurableReferenceEntries =>  { # Shipment::FedEx::WSDL::ShipTypes::ConfigurableLabelReferenceEntry
     ZoneNumber =>  $some_value, # positiveInteger
     Header =>  $some_value, # string
     DataField =>  $some_value, # string
     LiteralValue =>  $some_value, # string
   },
   MaskedData => $some_value, # LabelMaskableDataType
   ScncOverride =>  $some_value, # nonNegativeInteger
   TermsAndConditionsLocalization =>  { # Shipment::FedEx::WSDL::ShipTypes::Localization
     LanguageCode =>  $some_value, # string
     LocaleCode =>  $some_value, # string
   },
   AdditionalLabels =>  { # Shipment::FedEx::WSDL::ShipTypes::AdditionalLabelsDetail
     Type => $some_value, # AdditionalLabelsType
     Count =>  $some_value, # nonNegativeInteger
   },
   AirWaybillSuppressionCount =>  $some_value, # nonNegativeInteger
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

