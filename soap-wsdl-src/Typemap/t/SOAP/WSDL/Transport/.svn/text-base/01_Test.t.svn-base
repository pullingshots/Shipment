use Test::More tests => 9;
use strict;
use warnings;
use File::Basename;
use SOAP::WSDL::Client;

my $soap;
my $base_dir = dirname( __FILE__ );
use_ok(qw/SOAP::WSDL::Transport::Test/);

$soap = SOAP::WSDL::Client->new();
$soap->set_proxy('http://somewhere.over.the.rainbow');

$soap->get_transport->set_base_dir( join '/', $base_dir, 'acceptance' );
ok $soap->get_transport->get_base_dir();

{
    local $SIG{__WARN__} = sub {};
    my $response = $soap->call({ operation => 'test', soap_action => 'http://test' }, {});
    ok ! $response, 'Returned fault on error';
    is $response->get_faultcode(), 'soap:Server', 'faultcode';
    is $response->get_faultactor(), 'urn:localhost', 'faultactor';
    
    $soap->outputxml(1);
    $response = $soap->call({ operation => 'test', soap_action => 'http://test2' }, {});
    is $response, 'test2', 'Returned file content';

}

SKIP: {
    eval { require SOAP::WSDL::Deserializer::SOM; }
      or skip 'SOAP::WSDL::Deserializer::SOM required', 3;
    # requre SOAP::WSDL::Factory::Deserializer;
    SOAP::WSDL::Factory::Deserializer->register('1.1', 'SOAP::WSDL::Deserializer::SOM');
  
    my $soap_som = SOAP::WSDL::Client->new();
    $soap_som->set_proxy('http://somewhere.over.the.rainbow');
    $soap_som->get_transport->set_base_dir( join '/', $base_dir, 'acceptance' );
    
    my $som;
    ok $som = $soap_som->call({ operation => 'test', soap_action => 'http://test3' }, {}) 
      , 'Call with SOAP::WSDL::Deserializer::SOM';

    # In the somewhat weird logic of SOAP::Lite, the first node inside the root element
    # is the reault, all others are output parameters (and may be accessed via "paramsout")
    is $som->result(), 'Munich', 'Result match';
    is $som->paramsout(), 'Germany' , 'Output parameter match';
}
    
