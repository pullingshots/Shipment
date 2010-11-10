package TestResolver;
use strict; use warnings;
use Class::Std::Fast;

use base qw(SOAP::WSDL::Generator::PrefixResolver);

sub resolve_prefix {
    my ($self, $type, $namespace, $node) = @_;
    my $name = defined($node) ? $node->get_name() : ();
    if (($type eq 'interface') && $name =~m{\.}x) {
        return "MySpacialPrufax::";
    }
    if ($type eq 'type') {
        return 'MySpatialTaipeeProfix::'
            if $namespace ne 'http://www.w3.org/2001/XMLSchema'
    }
    return $self->SUPER::resolve_prefix($type, $namespace, $node);
}


package main;
use Test::More tests => 14;
use File::Basename qw(dirname);
use File::Spec;
use File::Path;

my $path = File::Spec->rel2abs( dirname __FILE__ );

use_ok qw(SOAP::WSDL::Generator::Template::XSD);

use SOAP::WSDL::Expat::WSDLParser;

my $parser = SOAP::WSDL::Expat::WSDLParser->new();

my $definitions = $parser->parse_file(
     "$path/../../../acceptance/wsdl/generator_test_dot_names.wsdl"
    #"$path/../../../acceptance/wsdl/elementAtomicComplexType.xml"
);

my $generator = SOAP::WSDL::Generator::Template::XSD->new({
    definitions => $definitions,
    type_prefix => 'Foo',
    element_prefix => 'Foo',
    typemap_prefix => 'Foo',
    OUTPUT_PATH => "$path/testlib",
    prefix_resolver_class => 'TestResolver',
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
# print $code;


$generator->set_type_prefix('MySpatialTaipeeProfix');
$generator->set_element_prefix('MyElements');
$generator->set_typemap_prefix('MyTypemaps');
$generator->set_interface_prefix('MyInterfaces');

$generator->set_output(undef);
$generator->generate();
#$generator->generate_typelib();
#$generator->generate_typemap();

if (eval { require Test::Warn; }) {
   Test::Warn::warnings_like( sub { $generator->generate_interface() }, [
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

use_ok qw(MySpacialPrufax::My::SOAP::testService::testPort);
use_ok qw(MyServer::My::SOAP::testService::testPort);
use_ok qw(MySpatialTaipeeProfix::testComplexTypeRestriction);
use_ok qw(MySpatialTaipeeProfix::testComplexTypeAll);
SKIP: {
    eval { require Test::Pod::Content; }
        or skip 'Cannot test pod content without Test::Pod::Content', 6;
    Test::Pod::Content::pod_section_like(
        'MySpacialPrufax::My::SOAP::testService::testPort',
        'NAME',
        qr{^MySpacialPrufax::My::SOAP::testService::testPort \s - \s}xms,
        'Pod NAME section');
    Test::Pod::Content::pod_section_like(
        'MySpacialPrufax::My::SOAP::testService::testPort',
        'SYNOPSIS',
        qr{use \s MySpacialPrufax::My::SOAP::testService::testPort}xms,
        'Pod SYNOPSIS section');
    Test::Pod::Content::pod_section_like(
        'MySpacialPrufax::My::SOAP::testService::testPort',
        'SYNOPSIS',
        qr{\s MySpacialPrufax::My::SOAP::testService::testPort->new\(}xms,
        'Pod SYNOPSIS section');

    Test::Pod::Content::pod_section_like(
        'MyServer::My::SOAP::testService::testPort',
        'NAME',
        qr{^MyServer::My::SOAP::testService::testPort \s - \s}xms,
        'Pod NAME section');
    Test::Pod::Content::pod_section_like(
        'MyServer::My::SOAP::testService::testPort',
        'SYNOPSIS',
        qr{use \s MyServer::My::SOAP::testService::testPort}xms,
        'Pod SYNOPSIS section');
    Test::Pod::Content::pod_section_like(
        'MyServer::My::SOAP::testService::testPort',
        'SYNOPSIS',
        qr{\s MyServer::My::SOAP::testService::testPort->new\(}xms,
        'Pod SYNOPSIS section');
}

my $obj = MySpatialTaipeeProfix::testComplexTypeAll->new({
	Test_1 => 'Test1',
	Test_2 => 'Test2',
});

like $obj->serialize(), qr{<Test-1>Test1</Test-1>}xm, 'serialize altered name with original name';

rmtree "$path/testlib";
