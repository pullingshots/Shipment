
package Shipment::Purolator::WSDLV2::Elements::Piece;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://purolator.com/pws/datatypes/v2' }

__PACKAGE__->__set_name('Piece');
__PACKAGE__->__set_nillable(1);
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();
use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    Shipment::Purolator::WSDLV2::Types::Piece
);

}

1;


=pod

=head1 NAME

Shipment::Purolator::WSDLV2::Elements::Piece

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
Piece from the namespace http://purolator.com/pws/datatypes/v2.







=head1 METHODS

=head2 new

 my $element = Shipment::Purolator::WSDLV2::Elements::Piece->new($data);

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDLV2::Types::Piece
   Weight =>  { # Shipment::Purolator::WSDLV2::Types::Weight
     Value =>  $some_value, # decimal
     WeightUnit => $some_value, # WeightUnit
   },
   Length =>  { # Shipment::Purolator::WSDLV2::Types::Dimension
     Value =>  $some_value, # decimal
     DimensionUnit => $some_value, # DimensionUnit
   },
   Width => {}, # Shipment::Purolator::WSDLV2::Types::Dimension
   Height => {}, # Shipment::Purolator::WSDLV2::Types::Dimension
   Options =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair
     OptionIDValuePair =>  { # Shipment::Purolator::WSDLV2::Types::OptionIDValuePair
       ID =>  $some_value, # string
       Value =>  $some_value, # string
     },
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

