
package Shipment::Purolator::WSDLV2::Elements::DutyInformation;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://purolator.com/pws/datatypes/v2' }

__PACKAGE__->__set_name('DutyInformation');
__PACKAGE__->__set_nillable(1);
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();
use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    Shipment::Purolator::WSDLV2::Types::DutyInformation
);

}

1;


=pod

=head1 NAME

Shipment::Purolator::WSDLV2::Elements::DutyInformation

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
DutyInformation from the namespace http://purolator.com/pws/datatypes/v2.







=head1 METHODS

=head2 new

 my $element = Shipment::Purolator::WSDLV2::Elements::DutyInformation->new($data);

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDLV2::Types::DutyInformation
   BillDutiesToParty => $some_value, # BillDutiesToParty
   BusinessRelationship => $some_value, # BusinessRelationship
   Currency => $some_value, # DutyCurrency
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

