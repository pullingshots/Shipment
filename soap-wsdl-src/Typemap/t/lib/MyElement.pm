#!/usr/bin/perl
package MyElement;
use strict;
use SOAP::WSDL::XSD::Typelib::Element;
use SOAP::WSDL::XSD::Typelib::Builtin;
use base (
   'SOAP::WSDL::XSD::Typelib::Element',
   'SOAP::WSDL::XSD::Typelib::Builtin::string',
);

__PACKAGE__->__set_name('MyElementName');
sub get_xmlns { 'urn:Test' };

package MyComplexTypeElement;
use strict;
use SOAP::WSDL::XSD::Typelib::Element;
use MyComplexType;
use base (
   'SOAP::WSDL::XSD::Typelib::Element',
   'MyComplexType',
);

__PACKAGE__->__set_name('MyComplexTypeElement');
sub get_xmlns { 'urn:Test' };

package MyTestElement;
use strict;
use SOAP::WSDL::XSD::Typelib::Element;
use SOAP::WSDL::XSD::Typelib::Builtin::string;
use base (
   'SOAP::WSDL::XSD::Typelib::Element',
   'SOAP::WSDL::XSD::Typelib::Builtin::string',
);

__PACKAGE__->__set_name('MyTestElement');

sub get_xmlns { 'urn:Test' };

package MyTestElement2;
use strict;
use SOAP::WSDL::XSD::Typelib::Element;
use SOAP::WSDL::XSD::Typelib::Builtin;
use base (
   'SOAP::WSDL::XSD::Typelib::Element',
   'SOAP::WSDL::XSD::Typelib::Builtin::string',
);

__PACKAGE__->__set_name('MyTestElement2');
__PACKAGE__->__set_nillable(1);

sub get_xmlns { 'urn:Test' };


package MyAtomicComplexTypeElement;

use strict;
use SOAP::WSDL::XSD::Typelib::Element;
use SOAP::WSDL::XSD::Typelib::ComplexType;
use SOAP::WSDL::XSD::Typelib::Builtin;
use base (
   'SOAP::WSDL::XSD::Typelib::Element',
   'SOAP::WSDL::XSD::Typelib::ComplexType',
);

my %test_of :ATTR(:get<test>);
my %test2_of :ATTR(:get<test2>);

sub get_xmlns { 'urn:Test' };

__PACKAGE__->_factory(
    [ qw(test test2) ],
    {
        test => \%test_of,
        test2 => \%test2_of,
    },
    {
        # this is the <element ref="" variant....
        test =>  'MyTestElement',
        test2 => 'MyTestElement2',
    },
);

__PACKAGE__->__set_name('MyAtomicComplexTypeElement');

package MyTestAttr;
use base qw(SOAP::WSDL::XSD::Typelib::Attribute
    SOAP::WSDL::XSD::Typelib::Builtin::string
);

package MyElementAttrs;

use strict;
use SOAP::WSDL::XSD::Typelib::Element;
use SOAP::WSDL::XSD::Typelib::ComplexType;
use SOAP::WSDL::XSD::Typelib::Builtin;
use base (
   'SOAP::WSDL::XSD::Typelib::Element',
   'SOAP::WSDL::XSD::Typelib::ComplexType',
);
{
    my %test_of :ATTR(:get<test>);
    my %test2_of :ATTR(:get<test2>);

    sub get_xmlns { 'urn:Test' };

    __PACKAGE__->_factory(
        [ qw(test test2) ],
        {
            test => \%test_of,
            test2 => \%test2_of,
        },
        {
            # this is the <element ref="" variant....
            test =>  'MyTestElement',
            test2 => 'MyTestElement2',
        },
    );
}
__PACKAGE__->__set_name('MyElementAttrs');

sub __get_attr_class { 'MyElementAttrs::_ATTR' };

package MyElementAttrs::_ATTR;

use strict;
use SOAP::WSDL::XSD::Typelib::ComplexType;
use SOAP::WSDL::XSD::Typelib::Builtin;
use base qw(
    SOAP::WSDL::XSD::Typelib::AttributeSet
);
{
    my %test_of :ATTR(:get<test>);
    my %test2_of :ATTR(:get<test2>);

    sub get_xmlns { 'urn:Test' };

    __PACKAGE__->_factory(
        [ qw(test test2) ],
        {
            test => \%test_of,
            test2 => \%test2_of,
        },
        {
            # this is the <element ref="" variant....
            test =>  'MyTestAttr',
            test2 => 'MyTestAttr',
        },
    );
}

1;
