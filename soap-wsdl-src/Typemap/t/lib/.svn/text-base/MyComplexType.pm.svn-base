#!/usr/bin/perl
package MyComplexType;
use strict;
use Class::Std::Fast::Storable constructor => 'none';
use lib '../../lib';
use base ('SOAP::WSDL::XSD::Typelib::ComplexType');

Class::Std::initialize();

my %MyTestName_of :ATTR(:get<MyTestName>);

__PACKAGE__->_factory(
    [ qw(MyTestName) ],                # order
    { MyTestName => \%MyTestName_of },  # attribute lookup map
    { MyTestName => 'SOAP::WSDL::XSD::Typelib::Builtin::string' }       # class name lookup map
);

sub get_xmlns { 'urn:Test' };

package My::MyFooBar;
use strict;
use Class::Std::Fast::Storable constructor => 'none';
use lib '../../lib';
use base ('SOAP::WSDL::XSD::Typelib::ComplexType');

my %foo_of :ATTR(:get<foo>);
my %bar_of :ATTR(:get<bar>);

__PACKAGE__->_factory(
    [ qw(bar foo) ],                # order
    {
        bar => \%bar_of,
        foo => \%foo_of,
    },  # attribute lookup map
    {
        bar => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        foo => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    }       # class name lookup map
);

sub get_xmlns { 'urn:Test' };

Class::Std::initialize();

1;
