package Shipment::Purolator::WSDLV2::Types::InternationalInformation;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://purolator.com/pws/datatypes/v2' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %DocumentsOnlyIndicator_of :ATTR(:get<DocumentsOnlyIndicator>);
my %ContentDetails_of :ATTR(:get<ContentDetails>);
my %BuyerInformation_of :ATTR(:get<BuyerInformation>);
my %PreferredCustomsBroker_of :ATTR(:get<PreferredCustomsBroker>);
my %DutyInformation_of :ATTR(:get<DutyInformation>);
my %ImportExportType_of :ATTR(:get<ImportExportType>);
my %CustomsInvoiceDocumentIndicator_of :ATTR(:get<CustomsInvoiceDocumentIndicator>);

__PACKAGE__->_factory(
    [ qw(        DocumentsOnlyIndicator
        ContentDetails
        BuyerInformation
        PreferredCustomsBroker
        DutyInformation
        ImportExportType
        CustomsInvoiceDocumentIndicator

    ) ],
    {
        'DocumentsOnlyIndicator' => \%DocumentsOnlyIndicator_of,
        'ContentDetails' => \%ContentDetails_of,
        'BuyerInformation' => \%BuyerInformation_of,
        'PreferredCustomsBroker' => \%PreferredCustomsBroker_of,
        'DutyInformation' => \%DutyInformation_of,
        'ImportExportType' => \%ImportExportType_of,
        'CustomsInvoiceDocumentIndicator' => \%CustomsInvoiceDocumentIndicator_of,
    },
    {
        'DocumentsOnlyIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'ContentDetails' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfContentDetail',
        'BuyerInformation' => 'Shipment::Purolator::WSDLV2::Types::BuyerInformation',
        'PreferredCustomsBroker' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DutyInformation' => 'Shipment::Purolator::WSDLV2::Types::DutyInformation',
        'ImportExportType' => 'Shipment::Purolator::WSDLV2::Types::ImportExportType',
        'CustomsInvoiceDocumentIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    },
    {

        'DocumentsOnlyIndicator' => 'DocumentsOnlyIndicator',
        'ContentDetails' => 'ContentDetails',
        'BuyerInformation' => 'BuyerInformation',
        'PreferredCustomsBroker' => 'PreferredCustomsBroker',
        'DutyInformation' => 'DutyInformation',
        'ImportExportType' => 'ImportExportType',
        'CustomsInvoiceDocumentIndicator' => 'CustomsInvoiceDocumentIndicator',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Purolator::WSDLV2::Types::InternationalInformation

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
InternationalInformation from the namespace http://purolator.com/pws/datatypes/v2.

InternationalInformation




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * DocumentsOnlyIndicator (min/maxOccurs: 1/1)


=item * ContentDetails (min/maxOccurs: 0/1)


=item * BuyerInformation (min/maxOccurs: 0/1)


=item * PreferredCustomsBroker (min/maxOccurs: 0/1)


=item * DutyInformation (min/maxOccurs: 0/1)


=item * ImportExportType (min/maxOccurs: 0/1)


=item * CustomsInvoiceDocumentIndicator (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDLV2::Types::InternationalInformation
   DocumentsOnlyIndicator =>  $some_value, # boolean
   ContentDetails =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfContentDetail
     ContentDetail =>  { # Shipment::Purolator::WSDLV2::Types::ContentDetail
       Description =>  $some_value, # string
       HarmonizedCode =>  $some_value, # string
       CountryOfManufacture =>  $some_value, # string
       ProductCode =>  $some_value, # string
       UnitValue =>  $some_value, # decimal
       Quantity =>  $some_value, # int
       NAFTADocumentIndicator =>  $some_value, # boolean
       FDADocumentIndicator =>  $some_value, # boolean
       FCCDocumentIndicator =>  $some_value, # boolean
       SenderIsProducerIndicator =>  $some_value, # boolean
       TextileIndicator =>  $some_value, # boolean
       TextileManufacturer =>  $some_value, # string
     },
   },
   BuyerInformation =>  { # Shipment::Purolator::WSDLV2::Types::BuyerInformation
     Address =>  { # Shipment::Purolator::WSDLV2::Types::Address
       Name =>  $some_value, # string
       Company =>  $some_value, # string
       Department =>  $some_value, # string
       StreetNumber =>  $some_value, # string
       StreetSuffix =>  $some_value, # string
       StreetName =>  $some_value, # string
       StreetType =>  $some_value, # string
       StreetDirection =>  $some_value, # string
       Suite =>  $some_value, # string
       Floor =>  $some_value, # string
       StreetAddress2 =>  $some_value, # string
       StreetAddress3 =>  $some_value, # string
       City =>  $some_value, # string
       Province =>  $some_value, # string
       Country =>  $some_value, # string
       PostalCode =>  $some_value, # string
       PhoneNumber =>  { # Shipment::Purolator::WSDLV2::Types::PhoneNumber
         CountryCode =>  $some_value, # string
         AreaCode =>  $some_value, # string
         Phone =>  $some_value, # string
         Extension =>  $some_value, # string
       },
       FaxNumber => {}, # Shipment::Purolator::WSDLV2::Types::PhoneNumber
     },
     TaxNumber =>  $some_value, # string
   },
   PreferredCustomsBroker =>  $some_value, # string
   DutyInformation =>  { # Shipment::Purolator::WSDLV2::Types::DutyInformation
     BillDutiesToParty => $some_value, # BillDutiesToParty
     BusinessRelationship => $some_value, # BusinessRelationship
     Currency => $some_value, # DutyCurrency
   },
   ImportExportType => $some_value, # ImportExportType
   CustomsInvoiceDocumentIndicator =>  $some_value, # boolean
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

