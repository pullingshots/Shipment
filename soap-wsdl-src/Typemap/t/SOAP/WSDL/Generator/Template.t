use strict;
use warnings;
use Test::More tests => 2;
use Template;
use File::Basename;
use File::Spec;
use SOAP::WSDL::Expat::WSDLParser;
use SOAP::WSDL::Generator::Template::XSD;

my $path = dirname __FILE__;

my $parser = SOAP::WSDL::Expat::WSDLParser->new();

$parser->parse_file("$path/../../../acceptance/wsdl/006_sax_client.wsdl");
#"$path/../../../../example/wsdl/globalweather.xml");
my $definitions = $parser->get_data();

my $generator = SOAP::WSDL::Generator::Template::XSD->new({
    definitions => $definitions,
});
my $output = q{};


$generator->generate_typemap({
    NO_POD => 1,
    output => \$output,
});

ok eval $output;
print $@ if $@;

#print $output;

$output = q{};
$generator->generate_interface({
    NO_POD => 1,
    output => \$output,
});

ok eval $output;
print $@ if $@;
