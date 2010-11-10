use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::base64Binary;
my $obj = SOAP::WSDL::XSD::Typelib::Builtin::base64Binary->new();
{
    no warnings qw(uninitialized);
    is "$obj", '', 'stringification';
}
ok defined $obj;
ok $obj->set_value('AAAA==');
ok $obj = SOAP::WSDL::XSD::Typelib::Builtin::base64Binary->new({ value => 'AAAA==' });
is "$obj", 'AAAA==', 'stringification';

ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';