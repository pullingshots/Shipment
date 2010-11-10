use Test::More tests => 29;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::boolean;

my $bool;
$bool = SOAP::WSDL::XSD::Typelib::Builtin::boolean->new();
ok defined $bool;

is "$bool", '', 'serialized undef to empty string';

$bool = SOAP::WSDL::XSD::Typelib::Builtin::boolean->new({});
ok defined $bool;

ok $bool = SOAP::WSDL::XSD::Typelib::Builtin::boolean->new({ value => 'true' });

is $bool * 1 , 1,  'numerification';
ok $bool, 'boolification';

is $bool->serialize(), 'true', 'serialization';

$bool->set_value('1');
is $bool->serialize(), 'true';
is "$bool", 1, 'stringification';
$bool ? pass 'boolification' : fail 'boolification';

$bool->set_value('0');
is $bool->serialize(), 'false';
! $bool ? pass 'boolification' : fail 'boolification';

$bool->set_value(undef);
is $bool->serialize(), 'false';
! $bool ? pass 'boolification' : fail 'boolification';


$bool->set_value('false');

if ($bool) {
    fail 'boolification';
}
else {
    pass 'boolification';
}

is "$bool", '0', 'stringification';

ok $bool->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';

is $bool->serialize({ name => 'test'}), '<test>false</test>';
is $bool->serialize(), 'false';

$bool->delete_value();
is $bool->serialize, '', 'serialized undef to empty string';
is "$bool", '', 'stringified undef to empty string';
$bool->set_value('');

is $bool->serialize, 'false', 'serialized empty string to false';
is "$bool", 0, 'stringified empty string to 0';

$SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType::___value->{ ${ $bool } } = 'true';
is $bool->serialize(), 'true', 'serialization';
is "$bool", 1, 'stringification';
is 3 * $bool, 3, 'numerification';

$SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType::___value->{ ${ $bool } } = 'false';
is $bool->serialize(), 'false', 'serialization';
is "$bool", 0, 'numerification';
is 3 * $bool, 0, 'stringification';