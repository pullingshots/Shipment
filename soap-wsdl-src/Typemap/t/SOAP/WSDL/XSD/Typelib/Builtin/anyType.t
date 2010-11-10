
use strict;
use warnings;
use Test::More tests => 4;
use Scalar::Util qw(blessed);
use_ok qw(SOAP::WSDL::XSD::Typelib::Builtin::anyType);

is SOAP::WSDL::XSD::Typelib::Builtin::anyType->get_xmlns(), 'http://www.w3.org/2001/XMLSchema', 'get_xmlns';
#is SOAP::WSDL::XSD::Typelib::Builtin::anyType->serialize(), q{}, 'serialize to empty';
is SOAP::WSDL::XSD::Typelib::Builtin::anyType->start_tag(), q{}, 'serialize to empty';
is SOAP::WSDL::XSD::Typelib::Builtin::anyType->start_tag({ name => 'foo'}), q{<foo>}, 'serialize with name';
exit 0;

__END__

# cannot instantiate abstract type...

my $obj = SOAP::WSDL::XSD::Typelib::Builtin::anyType->new();

ok blessed $obj, 'constructor returned blessed reference';

$obj = SOAP::WSDL::XSD::Typelib::Builtin::anyType->new({
    xmlns => 'urn:Siemens.mosaic'
});

ok blessed $obj, 'constructor returned blessed reference';

is $obj->get_xmlns(), 'http://www.w3.org/2001/XMLSchema', 'get_xmlns';

is $obj->start_tag({ name => 'test' }), '<test >', 'start_tag';
is $obj->end_tag({ name => 'test' }), '</test >', 'end_tag';

is "$obj", q{}, 'serialize overloading';