#!/usr/bin/perl
use Test::More qw(no_plan);
use strict;
use lib 'lib/';
use lib '../lib/';
use lib 't/lib';

use_ok qw(SOAP::WSDL::XSD::Typelib::ComplexType);
use_ok qw( MyComplexType );
# simple type derived from builtin via restriction
my $obj = MyComplexType->new({ MyTestName => 'test' });
ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anyType')
    , 'inherited class';
is $obj, '<MyTestName>test</MyTestName>', 'stringification';

$obj = MyComplexType->new({ MyTestName => [ 'test', 'test2' ] });
ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anyType')
    , 'inherited class';
is $obj, '<MyTestName>test</MyTestName><MyTestName>test2</MyTestName>',
    'stringification';

# try on the fly factory
@MyComplexType2::ISA = ('SOAP::WSDL::XSD::Typelib::ComplexType');
{
    use Class::Std::Fast::Storable;
    my %MyTestName_of;

    MyComplexType2->_factory(
        [ qw(MyTestName) ],                # order
        { MyTestName => \%MyTestName_of },  # attribute lookup map
        { MyTestName => 'MyElement' }       # class name lookup map
    );
}

$obj = MyComplexType2->new({ MyTestName => [ 'test', 'test2' ] });
ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anyType')
    , 'inherited class (on the fly-factory object)';
is $obj, '<MyTestName xmlns="urn:Test">test</MyTestName><MyTestName xmlns="urn:Test">test2</MyTestName>',
    'stringification (on the fly-factory object)';

# TODO factor out into complexType test

eval { $obj->get_ZUMSL };
like $@, qr{Valid\smethods}xm, 'error message (invalid method)';

__END__

