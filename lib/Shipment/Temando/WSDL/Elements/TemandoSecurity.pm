
package Shipment::Temando::WSDL::Elements::TemandoSecurity;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://schemas.xmlsoap.org/ws/2002/04/secext' }

__PACKAGE__->__set_name('Security');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %UsernameToken_of :ATTR(:get<UsernameToken>);

__PACKAGE__->_factory(
    [ qw(        UsernameToken

    ) ],
    {
        'UsernameToken' => \%UsernameToken_of,
    },
    {

        'UsernameToken' => 'Shipment::Temando::WSDL::Elements::TemandoSecurity::_UsernameToken',

    },
    {

        'UsernameToken' => 'UsernameToken',
    }
);

} # end BLOCK


package Shipment::Temando::WSDL::Elements::TemandoSecurity::_UsernameToken;
use strict;
use warnings;
{
our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

sub get_xmlns { 'http://schemas.xmlsoap.org/ws/2002/04/secext' }

my %Username_of :ATTR(:get<Username>);
my %Password_of :ATTR(:get<Password>);

__PACKAGE__->_factory(
    [ qw(        Username
        Password

    ) ],
    {
        'Username' => \%Username_of,
        'Password' => \%Password_of,
    },
    {
        'Username' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Password' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'Username' => 'Username',
        'Password' => 'Password',
    }
);

} # end BLOCK






}





} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Elements::TemandoSecurity

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * UsernameToken

 $element->set_UsernameToken($data);
 $element->get_UsernameToken();




=back


=head1 METHODS

=head2 new

 my $element = Shipment::Temando::WSDL::Elements::TemandoSecurity->new($data);

Constructor. The following data structure may be passed to new():

 {
   UsernameToken =>  {
     Username =>  $some_value, # string
     Password =>  $some_value, # string
   },
 },

=head1 AUTHOR

Andrew Baerg

=cut

