package sequence;
use strict; use warnings;
our $VERSION = 0.1;

use base qw(SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType);

sub get_xmlns { 'http://www.w3.org/XMLSchema2001' }

__PACKAGE__->__set_name('sequence');

my %element_of :ATTR(:name<element> :default<()>);

__PACKAGE__->_factory(
    ['element'],
    {
        element => \%element_of,
    },
    {
        element => 'element',
    },
    {
        element => 'element',
    }

);

1;