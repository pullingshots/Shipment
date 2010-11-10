#!/usr/bin/perl
use Test::More tests => 10;
use strict;
use lib 'lib/';
use lib '../lib/';
use lib 't/lib';

use_ok qw(SOAP::WSDL::SOAP::Typelib::Fault11);
use_ok qw(SOAP::WSDL::XSD::Typelib::Element);
use_ok qw( MyElement );
use_ok qw( SOAP::WSDL::Client );
# simple type derived from builtin via restriction

my $obj = MyAtomicComplexTypeElement->new({ test=> 'Test', test2 => 'Test2'});
ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anyType')
    , 'inherited class';

# print $obj->get_test;

ok $obj->get_test->isa('SOAP::WSDL::XSD::Typelib::Builtin::string')
    , 'element isa';

is $obj, '<MyAtomicComplexTypeElement xmlns="urn:Test"><test>Test</test>'
    . '<test2>Test2</test2></MyAtomicComplexTypeElement>'
    , 'stringification';

my $soap = SOAP::WSDL::Client->new( {
    class_resolver => 'FakeResolver',
} )
    ->proxy('http://bla')
        ->no_dispatch(1);

# TODO: use Test::XML for testing and re-integrate

#  is $soap->call('Test', $obj), q{<SOAP-ENV:Envelope }
    #  . q{xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" }
    #  . q{xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >}
    #  . q{<SOAP-ENV:Body><MyAtomicComplexTypeElement xmlns="urn:Test" >}
    #  . q{<test >Test</test>}
    #  . q{<test2 >Test2</test2>}
    #  . q{</MyAtomicComplexTypeElement></SOAP-ENV:Body></SOAP-ENV:Envelope>}
    #  , 'SOAP Envelope generation with objects';

my $result = $soap->proxy('http://bla')
    ->no_dispatch(0)
        ->call('Test', $obj);
ok $result->isa('SOAP::WSDL::SOAP::Typelib::Fault11'),
    'return fault on impossible call';
ok ! $result, 'fault is false in boolean context';


# $soap->no_dispatch(1);
ok ! $soap->call('Test'), 'second call';

package FakeResolver;
my %class_list = (
        'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
        'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
        'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyType',
    );
sub get_class {
    
    return $class_list{ $_[1] };
}

sub get_typemap {
    return \%class_list;
}
