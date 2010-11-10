use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::int;
my $int = SOAP::WSDL::XSD::Typelib::Builtin::int->new();
ok defined $int;
ok $int->set_value('127');
ok $int = SOAP::WSDL::XSD::Typelib::Builtin::int->new({ value => 127 });
is $int * 1, 127, 'numerification';
is "$int", "127", 'stringification';

ok $int->isa('SOAP::WSDL::XSD::Typelib::Builtin::long'), 'inheritance';