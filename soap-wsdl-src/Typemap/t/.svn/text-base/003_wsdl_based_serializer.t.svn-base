use Test::More tests => 11;
use lib '../lib';
use File::Basename qw(dirname);
use Cwd;

my $path = dirname __FILE__;

use_ok(qw/SOAP::WSDL::Expat::WSDLParser/);

my $filter;

my $parser;

ok($parser = SOAP::WSDL::Expat::WSDLParser->new() );

eval { $parser->parse_file( "$path/test.wsdl" ) };
if ($@)
{
	fail("parsing WSDL: $@");
	die "Can't test without parsed WSDL";
}
else
{
	pass("parsing XML");
}

my $wsdl;
ok( $wsdl = $parser->get_data() , "get object tree");

my $schema = $wsdl->first_types();

my $opt = {
	readable => 0,
	autotype => 1,
    namespace => $wsdl->get_xmlns(),
	indent => "\t",
	typelib => $schema,
};

is( $schema->find_type( 'urn:myNamespace', 'testSimpleType1' )->serialize(
	'test', 1 , $opt ),
	q{<test type="tns:testSimpleType1">1</test>} , "serialize simple type");

is( $schema->find_type( 'urn:myNamespace', 'testSimpleList' )->serialize(
	'testList', [ 1, 2, 3 ] , $opt),
	q{<testList type="tns:testSimpleList">1 2 3</testList>},
	"serialize simple list type"
);

is( $schema->find_element( 'urn:myNamespace', 'TestElement' )->serialize(
	undef, 1 , $opt),
	q{<TestElement type="xsd:int">1</TestElement>}, "Serialize element"
);

$opt->{ readable } = 0;

is( $schema->find_type( 'urn:myNamespace', 'length3')->serialize(
	'TestComplex', { size => -13, unit => 'BLA' } ,
	$opt ),
	q{<TestComplex type="tns:length3" >}
	. q{<size type="xsd:nonPositiveInteger">-13</size>}
	. q{<unit type="xsd:NMTOKEN">BLA</unit></TestComplex>}
	, "serialize complex type" );

is( $schema->find_element( 'urn:myNamespace', 'TestElementComplexType')->serialize(
	undef, { size => -13, unit => 'BLA' } ,
	$opt ),
	q{<TestElementComplexType type="tns:length3" >}
	. q{<size type="xsd:nonPositiveInteger">-13</size>}
	. q{<unit type="xsd:NMTOKEN">BLA</unit></TestElementComplexType>},
	"element with complex type"
);

is( $schema->find_type( 'urn:myNamespace', 'complex')->serialize(
	'complexComplex',
	{ 'length' => {  size => -13, unit => 'BLA' }, 'int' => 1 },
	$opt ),
	q{<complexComplex type="tns:complex" >}
	. q{<length type="tns:length3" >}
	. q{<size type="xsd:nonPositiveInteger">-13</size>}
	. q{<unit type="xsd:NMTOKEN">BLA</unit></length>}
	. q{<int type="xsd:int">1</int></complexComplex>},
	"nested complex type"
);

is( $wsdl->find_message('urn:myNamespace', 'testRequest')->first_part()->serialize(
	undef, { test => { length => {  size => -13, unit => 'BLA' } , int => 3 } },
	$opt ),
	q{<test type="tns:complex" >}
	. q{<length type="tns:length3" >}
	. q{<size type="xsd:nonPositiveInteger">-13</size>}
	. q{<unit type="xsd:NMTOKEN">BLA</unit>}
	. q{</length><int type="xsd:int">3</int></test>}
	, "Message part"
);

