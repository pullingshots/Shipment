use strict;
use warnings;
use Test::More qw(no_plan);

use File::Basename;
use File::Path;
use SOAP::WSDL::Expat::WSDLParser;

my $path = dirname __FILE__;

use_ok qw(SOAP::WSDL::Generator::XSD);

my $parser = SOAP::WSDL::Expat::WSDLParser->new();
my $generator = SOAP::WSDL::Generator::XSD->new({});

$parser->parse_file("$path/../../../../example/wsdl/globalweather.xml");
    
    my $definitions = $parser->get_data();
    $generator->set_definitions( $definitions );   
    
for my $service (@{ $definitions->get_service() }) {
      my $file = $generator->create_typemap( $service );
      ok eval { require $file }, "loaded generated file $file";
      $generator->create_interface( $service ); 
 }



