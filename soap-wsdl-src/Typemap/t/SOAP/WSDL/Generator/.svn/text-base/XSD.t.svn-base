use Test::More tests => 60;
use File::Basename qw(dirname);
use File::Spec;
use File::Path;
use SOAP::WSDL::Expat::MessageParser;
my $path = File::Spec->rel2abs( dirname __FILE__ );

use_ok qw(SOAP::WSDL::Generator::Template::XSD);

use SOAP::WSDL::Expat::WSDLParser;

my $parser = SOAP::WSDL::Expat::WSDLParser->new();

#
# the next test is a bit odd: on parsing the WSDL, we test whether the
# parser can cope with unknown (anyAttribute) attributes.
# The default is to issue a warning.
#
# But if Test::Warn isn't there, we have to skip the test, but parse the
# file, too, so in this case we skip a zero-length block, set no warnings
# and parse the WSDL...
#

my $definitions;
if ( eval 'use Test::Warn; 1;' ) {
    Test::Warn::warning_like(
        sub {
            $definitions = $parser->parse_file(
                "$path/../../../acceptance/wsdl/generator_test.wsdl"
            );
        },
        qr{\Afound \s unrecognised \s attribute \s {http://foo.bar}Action \s \(ignored\)}xms,
        'warning on unrecognized attribute',
    );
}
else {
    SKIP: {
        skip "cannot test warnings without Test::Warn", 1
    }
    no warnings;
    $definitions = $parser->parse_file(
        "$path/../../../acceptance/wsdl/generator_test.wsdl"
    );
}

my $generator = SOAP::WSDL::Generator::Template::XSD->new({
    definitions => $definitions,
    type_prefix => 'Foo',
    element_prefix => 'Foo',
    typemap_prefix => 'Foo',
    OUTPUT_PATH => "$path/testlib",
    silent => 1
});

my $code = "";
$generator->set_output(\$code);

$generator->generate_typelib();
{
    eval $code;
    ok !$@;
    print $@ if $@;
}

$generator->set_type_prefix('MyTypes');
$generator->set_element_prefix('MyElements');
$generator->set_typemap_prefix('MyTypemaps');
$generator->set_interface_prefix('MyInterfaces');

$generator->set_output(undef);
$generator->generate();

if (eval { require Test::Warn; }) {
   Test::Warn::warnings_like( sub { $generator->generate_interface() },
    [
        qr{\A Multiple \s parts \s detected \s in \s message \s testMultiPartWarning}xms,
        qr{\A Multiple \s parts \s detected \s in \s message \s testMultiPartWarning}xms
    ]);
}
else {
    $generator->generate_interface();
    SKIP: { skip 'Cannot test warnings without Test::Warn', 1 };
}

$generator->generate_server();

eval "use lib '$path/testlib'";
use_ok qw( MyInterfaces::testService::testPort );

my $interface;

ok $interface = MyInterfaces::testService::testPort->new(), 'instanciate interface';
$interface->set_no_dispatch(1);
$interface->outputxml(1);

my $message;

ok $message = $interface->testHeader(
    { Test1 => 'Test1', Test2 => 'Test2'},
    { Test1 => 'Header1', Test2 => 'Header2'},
), 'call soap method (no_dispatch)';

# print $message;
# __END__
# use_ok qw(SOAP::WSDL::Expat::MessageParser);
# use_ok qw(MyTypemaps::testService);

$parser = SOAP::WSDL::Expat::MessageParser->new({
    body_parts      => [ 'MyElements::testHeader' ],
    header_parts    => [ 'MyElements::Header' ],
});

ok $parser->parse_string($message), 'parse message with header';
ok $parser->get_header()->get_Test1(), 'Header1';
ok $message = $interface->testChoice( { Test1 => 'Test1' }  ), 'call soap method (no_dispatch)';
ok $parser->get_header()->get_Test2(), 'Header2';

ok $parser->get_data()->get_Test1(), 'Test1';
ok $parser->get_data()->get_Test2(), 'Test2';


use_ok qw(SOAP::WSDL::Transport::Loopback);

$interface->set_no_dispatch(undef);
$interface->set_transport(undef);
$interface->set_proxy('http://127.0.0.1/Test');

for (1..2) {
    my ($body, $header) = $interface->testHeader( { Test1 => 'Test1', Test2 => 'Test2'} , { Test1 => 'Header1', Test2 => 'Header2'});
# warn $body, $header;
#    is $header->get_Test1(), 'Header1', 'Header content';
#    is $header->get_Test2(), 'Header2', 'Header content';
}

# complexType choice test
ok $message = $interface->testChoice( { Test1 => 'Test1' }  ), 'call soap method (no_dispatch)';
ok $message = $interface->testChoice( { Test2 => 'Test2' }  ), 'call soap method (no_dispatch)';

TODO: {
    local $TODO = 'implement content check';
    eval { $interface->testChoice( { Test1 => 'Test1', Test2 => 'Test2' }  ) };
    ok $@, 'fail on both choice options';
}
#

ok eval { require MyTypes::testComplexTypeRestriction };
my $complexRestriction = MyTypes::testComplexTypeRestriction->new();
$complexRestriction->set_Test1('Test');
is $complexRestriction->get_Test1(), 'Test';

$complexRestriction = MyTypes::testComplexTypeRestriction->new({
    Test1 => 'test1',
    Test2 => 'test2',
});
is $complexRestriction->get_Test1(), 'test1';
is $complexRestriction->get_Test2(), 'test2';

ok eval { require MyTypes::testComplexTypeExtension };
$complexExtension = MyTypes::testComplexTypeExtension->new({
    Test1 => 'test1',
    Test2 => 'test2',
    Test3 => 'test3',
});
is $complexExtension->get_Test1(), 'test1';
is $complexExtension->get_Test2(), 'test2';
is $complexExtension->get_Test3(), 'test3';

ok eval { require MyTypes::testComplexNestedExtension };
my $nestedExtension = MyTypes::testComplexNestedExtension->new();
ok $nestedExtension->can('get_Test1');
ok $nestedExtension->can('get_Test2');
ok $nestedExtension->can('get_Test3');
ok $nestedExtension->can('get_Test4');

ok eval { require MyTypes::testComplexTypeElementAtomicSimpleType; };
my $ct_east = MyTypes::testComplexTypeElementAtomicSimpleType->new({
    testString => 'Just some test',
    testAtomicSimpleTypeElement => 42,
    testAtomicSimpleTypeElement2 => 23,
});

is $ct_east->get_testAtomicSimpleTypeElement, 42;
is $ct_east->get_testAtomicSimpleTypeElement->get_value(), 42;
isa_ok($ct_east->get_testAtomicSimpleTypeElement,
    'MyTypes::testComplexTypeElementAtomicSimpleType::_testAtomicSimpleTypeElement');


is $ct_east->get_testAtomicSimpleTypeElement2, 23;
is $ct_east->get_testAtomicSimpleTypeElement2->get_value(), 23;
isa_ok($ct_east->get_testAtomicSimpleTypeElement2,
    'MyTypes::testComplexTypeElementAtomicSimpleType::_testAtomicSimpleTypeElement2');

ok eval { require MyElements::testElementCompletelyEmptyComplex; }
    , 'load MyElements::testElementCompletelyEmptyComplex';
ok my $empty = MyElements::testElementCompletelyEmptyComplex->new();

is $empty->serialize_qualified(), '<testElementCompletelyEmptyComplex xmlns="urn:Test"/>'
    , 'serialize empty';

ok eval { require MyTypes::testComplexTypeSimpleRestriction; }
    , 'load MyTypes::testComplexTypeSimpleRestriction';

ok eval { require MyTypes::testComplexTypeSequenceWithAttribute; }
    , 'load MyTypes::testComplexTypeSequenceWithAttribute';

use_ok qw(MyElements::testElementComplexTypeSequenceWithAttribute);

my $obj = MyElements::testElementComplexTypeSequenceWithAttribute->new({
    Test1 => 'foo',
    Test2 => 'bar',
});
$obj->attr({ testAttr => 'foobar' });

is $obj, q{<testElementComplexTypeSequenceWithAttribute xmlns="urn:Test" }
    . q{testAttr="foobar"><Test1>foo</Test1><Test2>bar</Test2>}
    . q{</testElementComplexTypeSequenceWithAttribute>}
    , 'seralize complexType sequence with attribute';

use_ok qw(MyTypes::testSimpleContentExtension);

ok $obj = MyTypes::testSimpleContentExtension->new({ value => 'foo' });
$obj->attr({ testAttr => 'bar' });

is $obj->serialize({ name => 'baz'}), q{<baz testAttr="bar">foo</baz>};

use_ok qw(MyAttributes::TestAttribute);
ok $obj = MyAttributes::TestAttribute->new({ value => 'foo' });

use_ok qw(MyElements::testRef);
ok $obj = MyElements::testRef->new({ testElementString => 'foo'});
is q{<testRef xmlns="urn:Test"><testElementString>foo</testElementString></testRef>}
    , $obj->serialize_qualified()
    , 'serialize element ref';

use_ok qw(MyElements::testAtomicRef);
ok $obj = MyElements::testAtomicRef->new({ in => 'foo'});
is q{<testAtomicRef xmlns="urn:Test"><in>foo</in></testAtomicRef>}
    , $obj->serialize_qualified()
    , 'serialize element with atomic complexType / all with element ref';


SKIP: {
    eval { require Test::Pod::Content; }
        or skip 'Cannot test pod content without Test::Pod::Content', 3;
    Test::Pod::Content::pod_section_like(
        'MyTypes::testComplexTypeSequenceWithAttribute',
        'attr',
        qr{Test \s Attribute \s good \s for \s nothing}x,
        'Attribute POD');

    Test::Pod::Content::pod_section_like(
        'MyInterfaces::testService::testPort',
        'testChoice',
        qr{Returns \s a \s MyElements::testComplexTypeRestriction \s object\.}x,
        'Interface POD contains response class name');

    Test::Pod::Content::pod_section_like(
        'MyElements::testElementAtomicComplexTypeAll',
        'PROPERTIES',
        qr{\$element->set_test1\(\$data\);}x,
        'Included element accessor pod');
}

use_ok qw(MyTypes::finalComplexType);
{
    no warnings qw(once);
    ok *MyTypes::finalComplexType::get_Name, 'complexType inheritance flattened out';
}


#rmtree "$path/testlib";
