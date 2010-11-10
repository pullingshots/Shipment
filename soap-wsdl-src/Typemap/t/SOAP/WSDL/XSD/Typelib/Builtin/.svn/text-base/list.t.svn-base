package ListTest;
use base qw(SOAP::WSDL::XSD::Typelib::Builtin::list
SOAP::WSDL::XSD::Typelib::Builtin::string);

package main;
use Test::More tests => 11;
use strict;
use warnings;
my $obj = ListTest->new();
is $obj->get_value(), undef;
$obj = ListTest->new({});
is $obj->get_value(), undef;
ok $obj = ListTest->new({ value => 'Test' });
is "$obj", 'Test', 'stringification';

ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::string'), 'inheritance';

$obj->set_value(undef);
is $obj->get_value, undef;
is $obj->serialize(), '', 'serialize undef to empty string';
is $obj->serialize({ empty => 1 }), '', 'serialize undef to empty string';

$obj->set_value(42);
is $obj->get_value, 42;
is $obj->serialize(), '42', 'serialize undef to empty string';

$obj->set_value([1,2,3]);
is $obj->serialize(), '1 2 3', 'list serialization';