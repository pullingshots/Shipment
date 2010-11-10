use Test::More tests => 2;
use File::Basename qw(dirname);
use File::Spec;

my $path = File::Spec->rel2abs( dirname __FILE__ );

use_ok qw(SOAP::WSDL::Generator::Template::XSD);

use SOAP::WSDL::Expat::WSDLParser;

my $parser = SOAP::WSDL::Expat::WSDLParser->new();
my $definitions = $parser->parse_file(
    "$path/../../../acceptance/wsdl/generator_unsupported_test.wsdl"
);

my $generator = SOAP::WSDL::Generator::Template::XSD->new({
    definitions => $definitions,
    silent => 1,
});

{
    # currently, there is no completely unsupported XML schema
    # idiom (at least none which is detected properly)
    # TODO update WSDL and add some (there sure are)
    my $code = "";
    $generator->set_output(\$code);
    eval { $generator->generate_typelib() };
    eval $code;
}
ok ! $@;
