use lib '../lib';
use lib '../example/lib';
use lib '../../SOAP-WSDL_XS/blib/lib';
use lib '../../SOAP-WSDL_XS/blib/arch';
use strict;
# use Benchmark;
use SOAP::WSDL::Deserializer::XSD_XS;
use SOAP::WSDL::Factory::Deserializer;
# # register for SOAP 1.1
SOAP::WSDL::Factory::Deserializer->register('1.1' => 'SOAP::WSDL::Deserializer::XSD_XS' );

use MyInterfaces::TestService::TestPort;

my $soap = MyInterfaces::TestService::TestPort->new();
# Load all classes - XML::Compile has created everything before, too
if (@ARGV) { print $soap->ListPerson({}) }
else {
	 $soap->ListPerson({})
}
