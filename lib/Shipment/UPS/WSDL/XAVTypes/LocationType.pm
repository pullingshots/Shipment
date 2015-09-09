package Shipment::UPS::WSDL::XAVTypes::LocationType;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Error/v1.1' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %LocationElementName_of :ATTR(:get<LocationElementName>);
my %XPathOfElement_of :ATTR(:get<XPathOfElement>);
my %OriginalValue_of :ATTR(:get<OriginalValue>);

__PACKAGE__->_factory(
    [ qw(        LocationElementName
        XPathOfElement
        OriginalValue

    ) ],
    {
        'LocationElementName' => \%LocationElementName_of,
        'XPathOfElement' => \%XPathOfElement_of,
        'OriginalValue' => \%OriginalValue_of,
    },
    {
        'LocationElementName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'XPathOfElement' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'OriginalValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'LocationElementName' => 'LocationElementName',
        'XPathOfElement' => 'XPathOfElement',
        'OriginalValue' => 'OriginalValue',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::XAVTypes::LocationType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
LocationType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Error/v1.1.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * LocationElementName (min/maxOccurs: 0/1)


=item * XPathOfElement (min/maxOccurs: 0/1)


=item * OriginalValue (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::XAVTypes::LocationType
   LocationElementName =>  $some_value, # string
   XPathOfElement =>  $some_value, # string
   OriginalValue =>  $some_value, # string
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

