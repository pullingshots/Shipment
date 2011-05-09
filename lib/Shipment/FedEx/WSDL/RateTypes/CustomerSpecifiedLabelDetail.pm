package Shipment::FedEx::WSDL::RateTypes::CustomerSpecifiedLabelDetail;
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

my %DocTabContent_of :ATTR(:get<DocTabContent>);
my %CustomContent_of :ATTR(:get<CustomContent>);
my %ConfigurableReferenceEntries_of :ATTR(:get<ConfigurableReferenceEntries>);
my %MaskedData_of :ATTR(:get<MaskedData>);
my %TermsAndConditionsLocalization_of :ATTR(:get<TermsAndConditionsLocalization>);
my %AdditionalLabels_of :ATTR(:get<AdditionalLabels>);
my %AirWaybillSuppressionCount_of :ATTR(:get<AirWaybillSuppressionCount>);

__PACKAGE__->_factory(
    [ qw(        DocTabContent
        CustomContent
        ConfigurableReferenceEntries
        MaskedData
        TermsAndConditionsLocalization
        AdditionalLabels
        AirWaybillSuppressionCount

    ) ],
    {
        'DocTabContent' => \%DocTabContent_of,
        'CustomContent' => \%CustomContent_of,
        'ConfigurableReferenceEntries' => \%ConfigurableReferenceEntries_of,
        'MaskedData' => \%MaskedData_of,
        'TermsAndConditionsLocalization' => \%TermsAndConditionsLocalization_of,
        'AdditionalLabels' => \%AdditionalLabels_of,
        'AirWaybillSuppressionCount' => \%AirWaybillSuppressionCount_of,
    },
    {
        'DocTabContent' => 'Shipment::FedEx::WSDL::RateTypes::DocTabContent',
        'CustomContent' => 'Shipment::FedEx::WSDL::RateTypes::CustomLabelDetail',
        'ConfigurableReferenceEntries' => 'Shipment::FedEx::WSDL::RateTypes::ConfigurableLabelReferenceEntry',
        'MaskedData' => 'Shipment::FedEx::WSDL::RateTypes::LabelMaskableDataType',
        'TermsAndConditionsLocalization' => 'Shipment::FedEx::WSDL::RateTypes::Localization',
        'AdditionalLabels' => 'Shipment::FedEx::WSDL::RateTypes::AdditionalLabelsDetail',
        'AirWaybillSuppressionCount' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    },
    {

        'DocTabContent' => 'DocTabContent',
        'CustomContent' => 'CustomContent',
        'ConfigurableReferenceEntries' => 'ConfigurableReferenceEntries',
        'MaskedData' => 'MaskedData',
        'TermsAndConditionsLocalization' => 'TermsAndConditionsLocalization',
        'AdditionalLabels' => 'AdditionalLabels',
        'AirWaybillSuppressionCount' => 'AirWaybillSuppressionCount',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::CustomerSpecifiedLabelDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CustomerSpecifiedLabelDetail from the namespace http://fedex.com/ws/rate/v9.

Allows customer-specified control of label content.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * DocTabContent (min/maxOccurs: 0/1)


=item * CustomContent (min/maxOccurs: 0/1)


=item * ConfigurableReferenceEntries (min/maxOccurs: 0/unbounded)


=item * MaskedData (min/maxOccurs: 0/unbounded)


=item * TermsAndConditionsLocalization (min/maxOccurs: 0/1)


=item * AdditionalLabels (min/maxOccurs: 0/unbounded)


=item * AirWaybillSuppressionCount (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::CustomerSpecifiedLabelDetail
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

