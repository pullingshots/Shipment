package Shipment::UPS::WSDL::TrackTypes::AddressRequestType;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Track/v2.0' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %PostalCode_of :ATTR(:get<PostalCode>);
my %CountryCode_of :ATTR(:get<CountryCode>);

__PACKAGE__->_factory(
    [ qw(        PostalCode
        CountryCode

    ) ],
    {
        'PostalCode' => \%PostalCode_of,
        'CountryCode' => \%CountryCode_of,
    },
    {
        'PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CountryCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'PostalCode' => 'PostalCode',
        'CountryCode' => 'CountryCode',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::TrackTypes::AddressRequestType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
AddressRequestType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Track/v2.0.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * PostalCode


=item * CountryCode




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::TrackTypes::AddressRequestType
   PostalCode =>  $some_value, # string
   CountryCode =>  $some_value, # string
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

