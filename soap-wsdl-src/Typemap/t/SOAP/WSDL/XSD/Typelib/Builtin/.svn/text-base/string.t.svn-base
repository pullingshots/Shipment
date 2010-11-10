use Test::More tests => 6;
use strict;
use warnings;
use lib '../lib';

use_ok('SOAP::WSDL::XSD::Typelib::Builtin::string');
my $obj;
$obj = SOAP::WSDL::XSD::Typelib::Builtin::string->new({ value => '& "Aber" <test>'});

is $obj->serialize, '&amp; &quot;Aber&quot; &lt;test&gt;'
    , 'escape text on serialization';

$obj = SOAP::WSDL::XSD::Typelib::Builtin::string->new();
$obj = SOAP::WSDL::XSD::Typelib::Builtin::string->new({});
$obj->set_value( '& "Aber" <test>');
is $obj->get_value() , '& "Aber" <test>';
is $obj, '& "Aber" <test>';
is $obj->serialize(), '&amp; &quot;Aber&quot; &lt;test&gt;'
    , 'escape text on serialization';
    
is $obj->serialize({ name => 'test'})
    , '<test>&amp; &quot;Aber&quot; &lt;test&gt;</test>'
    , 'Serialization with name';