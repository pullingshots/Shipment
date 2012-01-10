package Shipment::Temando::WSDL::Types::Inclusion;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(0);

sub get_xmlns { 'http://api.temando.com/schema/2009_06/common.xsd' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %summary_of :ATTR(:get<summary>);
my %details_of :ATTR(:get<details>);

__PACKAGE__->_factory(
    [ qw(        summary
        details

    ) ],
    {
        'summary' => \%summary_of,
        'details' => \%details_of,
    },
    {
        'summary' => 'Shipment::Temando::WSDL::Types::InclusionSummary',
        'details' => 'Shipment::Temando::WSDL::Types::InclusionDetails',
    },
    {

        'summary' => 'summary',
        'details' => 'details',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Types::Inclusion

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Inclusion from the namespace http://api.temando.com/schema/2009_06/common.xsd.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * summary (min/maxOccurs: 0/1)


=item * details (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Temando::WSDL::Types::Inclusion
   summary => $some_value, # InclusionSummary
   details => $some_value, # InclusionDetails
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut
