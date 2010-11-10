use strict;
use Test::More tests => 2;
use File::Basename qw(dirname);
use File::Spec;
use File::Path;
use diagnostics;

my $path;

$path = File::Spec->rel2abs( dirname __FILE__ );
my ( $volume, $dir ) = File::Spec->splitpath( $path, 1 );
my @dir_from = File::Spec->splitdir($dir);
unshift @dir_from, $volume if $volume;
$path = join '/', @dir_from;
my $HAVE_TEST_XML = eval {
    require Test::XML;
    import Test::XML;
    1;
};

use_ok qw(SOAP::WSDL::Generator::Template::XSD);

use SOAP::WSDL::Expat::WSDLParser;

my $parser = SOAP::WSDL::Expat::WSDLParser->new();

my $definitions = $parser->parse_uri(
    "file://$path/../../../../../acceptance/wsdl/MultipleNamespaces.wsdl" );

my $generator = SOAP::WSDL::Generator::Template::XSD->new( {
        definitions => $definitions,
        OUTPUT_PATH => "$path/testlib",
        silent      => 1,
} );

my $code = "";
$generator->generate_typelib();

eval qq{use lib "$path/testlib";};

require MyElements::TestOperation;

my $testElement = MyElements::TestOperation->new({
   LocalElement =>  "LocalElement", # string
   NamespacedElement =>  { # MyTypes::complexTest
        test =>  "Namespaced element", # string
   },
});

my $xml = q{<TestOperation xmlns="http://www.example.org/ComplexTypeNamespaces/">
    <LocalElement>LocalElement</LocalElement>
    <NamespacedElement>
        <test xmlns="http://www.example.org/ElementNamespaces/">Namespaced element</test>
    </NamespacedElement>
  </TestOperation>};

SKIP: {
    skip( "Cannot test XML content without Test::XML", 1 )
      if not $HAVE_TEST_XML;
    is_xml( "$testElement", $xml, "XML content" );
}

rmtree "$path/testlib";
