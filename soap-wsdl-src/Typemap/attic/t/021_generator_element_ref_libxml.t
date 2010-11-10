#!/usr/bin/perl -w
use strict;
use warnings;
use Test::More;
use File::Path;
use File::Basename;
use lib '../lib';

if (eval "require XML::LibXML") {
     plan tests => 11;
}
else {
    plan skip_all => "Cannot test without XML::LibXML";
}

my $path = dirname __FILE__;


use_ok(qw/SOAP::WSDL::SAX::WSDLHandler/);

my $filter;
my $parser = XML::LibXML->new();
ok($filter = SOAP::WSDL::SAX::WSDLHandler->new(), "Object creation");
$parser->set_handler( $filter );

eval { $parser->parse_file( "$path/acceptance/wsdl/03_complexType-element-ref.wsdl" ) };
if ($@)
{
	fail("parsing WSDL");
	die "Can't test without parsed WSDL: $@";
}
else
{
	pass("parsing XML");
}

my $definitions = $filter->get_data();
my $type = $definitions->first_types()->find_type('urn:Test', 'testComplexTypeRef');

my $element = $definitions->first_types()->find_element('urn:Test', 'TestElement');

my $output;

ok $element->to_class({ wsdl => $definitions, prefix => 'Test::', output => \$output })
  , 'generate element code';

ok eval $output, 'eval generated code';

$output = '';

ok $type->to_class({ wsdl => $definitions, prefix => 'Test::', output => \$output })
  , 'generate complexType code with element ref=""';

ok eval $output, 'eval generated code';

my $obj = Test::testComplexTypeRef->new({
  TestRef => 'test_ref',
  Test2 => 'test2',
});

is $obj, '<TestRef >test_ref</TestRef><Test2 >test2</Test2 >', 'serialization';

$element = $definitions->first_types()->find_element('urn:Test', 'TestRef');

$output = '';

ok $element->to_class({ wsdl => $definitions, prefix => 'Test::', output => \$output })
  , 'generate top level element ref code';
  
ok eval $output, 'eval generated code' . $@;

# print $output;

$obj = Test::TestRef->new({ value => 'test_ref' });

is $obj, '<TestRef xmlns="urn:Test" >test_ref</TestRef>', 'serialization';