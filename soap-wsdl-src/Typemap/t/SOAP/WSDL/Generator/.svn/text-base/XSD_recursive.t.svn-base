use Test::More tests => 3;
use File::Basename qw(dirname);
use File::Spec;
use File::Path;

my $path = File::Spec->rel2abs( dirname __FILE__ );

use SOAP::WSDL::Expat::MessageParser;

use_ok qw(SOAP::WSDL::Generator::Template::XSD);

use SOAP::WSDL::Expat::WSDLParser;

my $parser = SOAP::WSDL::Expat::WSDLParser->new();

my $definitions = $parser->parse_file(
     "$path/../../../acceptance/wsdl/recursive.wsdl"
);

ok($definitions, 'parsed file');

my $generator = SOAP::WSDL::Generator::Template::XSD->new({
    definitions => $definitions,
    type_prefix => 'Bar',
    element_prefix => 'BarElem',
    typemap_prefix => 'Bar',
    OUTPUT_PATH => "$path/testlib",
});


my $code = "";
$generator->set_output(\$code);
$generator->generate_typelib();
{
    eval $code;
    ok !$@, 'eval generated code';
    print $@ if $@;
}

rmtree "$path/testlib";
