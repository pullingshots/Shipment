package Shipment::Purolator::WSDL::Types::ContentDetail;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://purolator.com/pws/datatypes/v1' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Description_of :ATTR(:get<Description>);
my %HarmonizedCode_of :ATTR(:get<HarmonizedCode>);
my %CountryOfManufacture_of :ATTR(:get<CountryOfManufacture>);
my %ProductCode_of :ATTR(:get<ProductCode>);
my %UnitValue_of :ATTR(:get<UnitValue>);
my %Quantity_of :ATTR(:get<Quantity>);
my %NAFTADocumentIndicator_of :ATTR(:get<NAFTADocumentIndicator>);
my %FDADocumentIndicator_of :ATTR(:get<FDADocumentIndicator>);
my %FCCDocumentIndicator_of :ATTR(:get<FCCDocumentIndicator>);
my %SenderIsProducerIndicator_of :ATTR(:get<SenderIsProducerIndicator>);
my %TextileIndicator_of :ATTR(:get<TextileIndicator>);
my %TextileManufacturer_of :ATTR(:get<TextileManufacturer>);

__PACKAGE__->_factory(
    [ qw(        Description
        HarmonizedCode
        CountryOfManufacture
        ProductCode
        UnitValue
        Quantity
        NAFTADocumentIndicator
        FDADocumentIndicator
        FCCDocumentIndicator
        SenderIsProducerIndicator
        TextileIndicator
        TextileManufacturer

    ) ],
    {
        'Description' => \%Description_of,
        'HarmonizedCode' => \%HarmonizedCode_of,
        'CountryOfManufacture' => \%CountryOfManufacture_of,
        'ProductCode' => \%ProductCode_of,
        'UnitValue' => \%UnitValue_of,
        'Quantity' => \%Quantity_of,
        'NAFTADocumentIndicator' => \%NAFTADocumentIndicator_of,
        'FDADocumentIndicator' => \%FDADocumentIndicator_of,
        'FCCDocumentIndicator' => \%FCCDocumentIndicator_of,
        'SenderIsProducerIndicator' => \%SenderIsProducerIndicator_of,
        'TextileIndicator' => \%TextileIndicator_of,
        'TextileManufacturer' => \%TextileManufacturer_of,
    },
    {
        'Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'HarmonizedCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CountryOfManufacture' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ProductCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'UnitValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
        'Quantity' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
        'NAFTADocumentIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'FDADocumentIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'FCCDocumentIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'SenderIsProducerIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'TextileIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'TextileManufacturer' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'Description' => 'Description',
        'HarmonizedCode' => 'HarmonizedCode',
        'CountryOfManufacture' => 'CountryOfManufacture',
        'ProductCode' => 'ProductCode',
        'UnitValue' => 'UnitValue',
        'Quantity' => 'Quantity',
        'NAFTADocumentIndicator' => 'NAFTADocumentIndicator',
        'FDADocumentIndicator' => 'FDADocumentIndicator',
        'FCCDocumentIndicator' => 'FCCDocumentIndicator',
        'SenderIsProducerIndicator' => 'SenderIsProducerIndicator',
        'TextileIndicator' => 'TextileIndicator',
        'TextileManufacturer' => 'TextileManufacturer',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Purolator::WSDL::Types::ContentDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ContentDetail from the namespace http://purolator.com/pws/datatypes/v1.

ContentDetail




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Description (min/maxOccurs: 1/1)


=item * HarmonizedCode (min/maxOccurs: 1/1)


=item * CountryOfManufacture (min/maxOccurs: 1/1)


=item * ProductCode (min/maxOccurs: 1/1)


=item * UnitValue (min/maxOccurs: 1/1)


=item * Quantity (min/maxOccurs: 1/1)


=item * NAFTADocumentIndicator (min/maxOccurs: 0/1)


=item * FDADocumentIndicator (min/maxOccurs: 0/1)


=item * FCCDocumentIndicator (min/maxOccurs: 0/1)


=item * SenderIsProducerIndicator (min/maxOccurs: 0/1)


=item * TextileIndicator (min/maxOccurs: 0/1)


=item * TextileManufacturer (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDL::Types::ContentDetail
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

