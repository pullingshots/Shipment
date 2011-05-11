package Shipment::Purolator::WSDL::Types::DocumentTypes;
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

my %DocumentType_of :ATTR(:get<DocumentType>);

__PACKAGE__->_factory(
    [ qw(        DocumentType

    ) ],
    {
        'DocumentType' => \%DocumentType_of,
    },
    {
        'DocumentType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'DocumentType' => 'DocumentType',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Purolator::WSDL::Types::DocumentTypes

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
DocumentTypes from the namespace http://purolator.com/pws/datatypes/v1.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * DocumentType (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDL::Types::DocumentTypes
   DocumentType =>  $some_value, # string
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut
