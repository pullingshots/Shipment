use strict;
use Test::More tests => 3;
use File::Basename qw(dirname);
use File::Spec;
use File::Path;
use diagnostics;

my $path = File::Spec->rel2abs( dirname __FILE__ );
my ($volume, $dir) = File::Spec->splitpath($path, 1);
my @dir_from = File::Spec->splitdir($dir);
unshift @dir_from, $volume if $volume;
my $url = join '/', @dir_from;

my $HAVE_TEST_WARN = eval { require Test::Warn; };

use_ok qw(SOAP::WSDL::Generator::Template::XSD);

use SOAP::WSDL::Expat::WSDLParser;

my $parser = SOAP::WSDL::Expat::WSDLParser->new();

my $definitions;

if ($HAVE_TEST_WARN) {
    Test::Warn::warning_like(sub {
        $definitions = $parser->parse_uri(
                "file://$url/../../../../../acceptance/wsdl/WSDLParser-import.wsdl"
            );
        }
        , qr{already \s imported}x
    );
}
else {
    local $SIG{__WARN__} = sub {};
    SKIP: { skip 'Cannot test warning without Test::Warn', 1; }
    $definitions = $parser->parse_uri(
        "file://$url/../../../../../acceptance/wsdl/WSDLParser-import.wsdl"
    );
}
my $generator = SOAP::WSDL::Generator::Template::XSD->new({
    definitions => $definitions,
    type_prefix => 'Foo',
    element_prefix => 'Foo',
    typemap_prefix => 'Foo',
    OUTPUT_PATH => "$path/testlib",
    silent => 1,
});

my $code = "";
$generator->set_output(\$code);
$generator->generate_typelib();
{
    eval $code;
    ok !$@;
    print $@ if $@;
}

rmtree "$path/testlib";
