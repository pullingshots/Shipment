package element;
use strict; use warnings;
our $VERSION = 0.1;
use base qw(SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType);

sub get_xmlns { 'http://www.w3.org/XMLSchema2001' }
sub __get_attr_class { 'element::_ATTR' }
__PACKAGE__->__set_name('element');

__PACKAGE__->_factory();

package element::_ATTR;
use strict; use warnings;
our $VERSION = 0.1;
use base qw(SOAP::WSDL::XSD::Typelib::AttributeSet);

my %name_of :ATTR(:name<name> :default<()>);
my %type_of :ATTR(:name<type> :default<()>);
my %ref_of :ATTR(:name<ref> :default<()>);

__PACKAGE__->_factory(
    [ 'name' , 'type', 'ref' ],
    {
        'name' => \%name_of,
        'ref' => \%ref_of,
        'type' => \%type_of,
    },
    {
        'name' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'type' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ref' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {
        name => 'name',
        type => 'type',
        'ref' => 'ref'
    }
);

1;

1;