#!/usr/bin/perl -w
use strict;
use warnings;
use Test::More;
use lib '../lib';
use SOAP::WSDL::SAX::WSDLHandler;
use SOAP::WSDL::SAX::MessageHandler;
use File::Path;
use File::Basename;

if (eval "require XML::LibXML") {
     plan tests => 1;
}
else {
    plan skip_all => "Cannot test without XML::LibXML";
}

my $path = dirname __FILE__;

my $filter = SOAP::WSDL::SAX::WSDLHandler->new();
my $parser = XML::LibXML->new();
$parser->set_handler( $filter );
$parser->parse_file( "$path/../example/wsdl/globalweather.xml" );

my $wsdl;
ok( $wsdl = $filter->get_data() , "get object tree");

$wsdl->create({
  base_path => "$path/testlib",
  typemap_prefix => "Test::Typemap::",
  type_prefix => "Test::Type::",
  element_prefix => "Test::Element::",
  interface_prefix => "Test::Interface::",
});

rmtree "$path/testlib";