use Test::More tests => 16;
use File::Basename qw(dirname);
use File::Spec;
use File::Path;

my $path = File::Spec->rel2abs( dirname __FILE__ );

use SOAP::WSDL::Expat::MessageParser;

use_ok qw(SOAP::WSDL::Generator::Template::XSD);

use SOAP::WSDL::Expat::WSDLParser;

my $parser = SOAP::WSDL::Expat::WSDLParser->new();

my $definitions = $parser->parse_file(
     "$path/../../../acceptance/wsdl/nested_complextype.wsdl"
);

ok my $element = $definitions->get_types()->[0]->find_element("urn:HelloWorld", "sayHello")
    , 'got element';
ok my $sub_element = $element->get_complexType->[0]->find_element("urn:HelloWorld", "givenName"),
    , 'atomic type element';
ok $sub_element->get_complexType->[0]->find_element("urn:HelloWorld", "givenName"),
    'element in subtype';


my $generator = SOAP::WSDL::Generator::Template::XSD->new({
    definitions => $definitions,
    type_prefix => 'Bar',
    element_prefix => 'BarElem',
    typemap_prefix => 'Bar',
    OUTPUT_PATH => "$path/testlib",
    silent => 1,
});


my $code = "";
$generator->set_output(\$code);
$generator->generate_typelib();
{
    eval $code;
    ok !$@, 'eval generated code';
    print $@ if $@;
}
# print $code;

my %prefix_of = (
    type => 'FooType',
    element => 'FooElement',
    typemap => 'FooMap',
);

while (my ($name, $value) = each %prefix_of ) {
    $generator->can("set_$name\_prefix")->($generator, $value);
}

$generator->set_output(undef);
$generator->generate();
#$generator->generate_typelib();
$generator->generate_typemap();
$generator->generate_server();

eval "use lib '$path/testlib'";

use_ok qw(FooElement::sayHello);
eval {
    FooElement::sayHello::_givenName->new({
        givenName => 'Foo',
        middleInitial => 'Bar',
    });
};
ok !$@, 'instantiate subpackage FooElement::sayHello::_givenName';

eval {
    FooElement::sayHello::_givenName::XmlAttr->new({
        testAttr => 'Bar'
    });
};
ok !$@, 'instantiate subpackage attribute class FooElement::sayHello::_givenName::XmlAttr';


SKIP: {
    eval { require Test::Pod::Content; }
        or skip 'Cannot test pod content without Test::Pod::Content', 1;
    Test::Pod::Content::pod_section_is(
        'FooElement::sayHello',
        'NAME',
        'FooElement::sayHello',
        'Pod NAME section');
}

require FooMap::Service1;
my $message_parser = SOAP::WSDL::Expat::MessageParser->new({
    class_resolver => 'FooMap::Service1',
});

my $result = $message_parser->parse_string( xml() );
is $result->get_name(), 'Kutter', 'content';
is $result->get_givenName()->get_givenName, 'Martin', 'nested complexType content';
is $result->get_givenName()->get_givenName, 'Martin', 'nested complexType content';
is $result->get_givenName()->attr()->get_testAttr, 'Bar', 'nested complexType attr';

sub xml {
    return q{<SOAP-ENV:Envelope
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body >
        <sayHello xmlns="urn:HelloWorld" testAttr="Foo">
            <name>Kutter</name>
            <givenName testAttr="Bar">
                <givenName>Martin</givenName>
                <middleInitial>A.</middleInitial>
            </givenName>
        </sayHello>
    </SOAP-ENV:Body></SOAP-ENV:Envelope>};
}

require FooType::testAbstractGrandChild;

ok(FooType::testAbstractGrandChild->can('get_abstractGrandChild'), 'attribute');
ok(FooType::testAbstractGrandChild->can('get_abstractChild'), 'parent attribute');
ok(FooType::testAbstractGrandChild->can('get_abstract'), 'grandparent attribute');

rmtree "$path/testlib";
