package Shipment::Purolator::WSDLV2::Types::ArrayOfSurcharge;
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

my %Surcharge_of :ATTR(:get<Surcharge>);

__PACKAGE__->_factory(
    [ qw(        Surcharge

    ) ],
    {
        'Surcharge' => \%Surcharge_of,
    },
    {
        'Surcharge' => 'Shipment::Purolator::WSDLV2::Types::Surcharge',
    },
    {

        'Surcharge' => 'Surcharge',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Purolator::WSDLV2::Types::ArrayOfSurcharge

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ArrayOfSurcharge from the namespace http://purolator.com/pws/datatypes/v2.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Surcharge (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDLV2::Types::ArrayOfSurcharge
   Surcharge =>  { # Shipment::Purolator::WSDLV2::Types::Surcharge
     Amount =>  $some_value, # decimal
     Type =>  $some_value, # string
     Description =>  $some_value, # string
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut
