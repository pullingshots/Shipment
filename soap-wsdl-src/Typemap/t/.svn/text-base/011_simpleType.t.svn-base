#!/usr/bin/perl
use Test::More qw(no_plan);
use strict;
use lib 'lib/';
use lib 't/lib/';
use lib '../lib/';

use_ok qw(MySimpleType);

# simple type derived from builtin via restriction
my $obj = MySimpleType->new({ value => 'test'});
ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType')
    , 'inherited class';
is $obj, 'test', 'stringification';

# simple type derived from builtin via list
$obj = MySimpleListType->new({ value => [ 'test', 'test2' ]});
ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType')
    , 'inherited class';
ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::list')
    , 'inherited class';
is $obj->serialize(), 'test test2', 'stringification';

# simple type derived from atomic simple type (restriction)
$obj = MyAtomicSimpleType->new({ value => 'test' });
ok $obj->isa('MySimpleType') , 'inherited class';
ok $obj->isa('SOAP::WSDL::XSD::Typelib::SimpleType::restriction')
    , 'inherited class';
is $obj, 'test', 'stringification';

# simple type derived from atomic simple type (list)
$obj = MyAtomicSimpleListType->new({ value => [ 'test', 'test2' ] });
ok $obj->isa('MySimpleListType') , 'inherited class';
ok $obj->isa('SOAP::WSDL::XSD::Typelib::SimpleType::restriction')
    , 'inherited class';
is $obj->serialize(), 'test test2', 'stringification';
