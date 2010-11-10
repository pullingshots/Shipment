use lib '../lib';
use lib '../example/lib';
use lib '../../Class-Std-Fast/lib';
use lib '../../SOAP-Lite-0.71/lib';
use lib '../../SOAP-WSDL_XS-local/blib/lib';
use lib '../../SOAP-WSDL_XS-local/blib/arch';
#use strict;

use Benchmark qw(cmpthese);

use XML::Compile::SOAP11;
use XML::Compile::Transport::SOAPHTTP();
use XML::Compile::Util;
use XML::Compile::WSDL11;
use XML::Simple;

use SOAP::Lite; # +trace;
use MyInterfaces::TestService::TestPort;

#use SOAP::WSDL::Deserializer::XSD_XS;
use SOAP::WSDL::Factory::Deserializer;

#
# register SOAP::WSDL's transport as default for SOAP::WSDL and SOAP::WSDL_XS
# - they use SOAP::Lite's SOAP::Transport::* if available
#
use SOAP::WSDL::Transport::HTTP;
use SOAP::WSDL::Factory::Transport;
#SOAP::WSDL::Factory::Transport->register('http', 'SOAP::WSDL::Transport::HTTP');

$XML::Simple::PREFERRED_PARSER = 'XML::Parser';

my $person = {
    PersonID =>         { # MyTypes::PersonID
          ID =>  1, # int
        },
        Salutation => 'Salutation0', # string
        Name =>  'Name0', # string
        GivenName =>  'Martin', # string
        DateOfBirth =>  '1970-01-01', # date
        HomeAddress =>         { # MyTypes::Address
          Street => 'Street 0', # string
          ZIP =>  '00000', # string
          City =>  'City0', # string
          Country =>  'Country0', # string
          PhoneNumber => '++499131123456', # PhoneNumber
          MobilePhoneNumber => '++49150123456', # PhoneNumber
        },
        WorkAddress =>         { # MyTypes::Address
          Street => 'Somestreet 23', # string
          ZIP =>  '12345', # string
          City =>  'SomeCity', # string
          Country =>  'Germany', # string
          PhoneNumber => '++499131123456', # PhoneNumber
          MobilePhoneNumber => '++49150123456', # PhoneNumber
        },
        Contracts =>         { # MyTypes::ArrayOfContract
          Contract => [
          { # MyTypes::Contract
            ContractID =>  100000, # long
            ContractName =>  'SomeContract0', # string
          },
          { # MyTypes::Contract
            ContractID =>  100001, # long
            ContractName =>  'SomeContract1', # string
          },
          { # MyTypes::Contract
            ContractID =>  100002, # long
            ContractName =>  'SomeContract2', # string
          },
          { # MyTypes::Contract
            ContractID =>  100003, # long
            ContractName =>  'SomeContract3', # string
          },
          ],
        },
}
;
#
# compile XML::Compile client with the options suggested by Mark Overmeer
# for maximum speedup
#
my $compile = XML::Compile::WSDL11->new('../example/wsdl/Person.wsdl',
    sloppy_integers => 1,
    check_values    => 0,
    validation      => 0,
    ignore_facets   => 1,
);

#
# Call all variants once to allow their first-time tasks to be done
#

my $call = $compile->compileClient('ListPerson');
#my ($result, $trace) = $call->({ in => undef });
#die $trace;

# Initialize SOAP::WSDL interface
my $soap = MyInterfaces::TestService::TestPort->new();
# Load all classes - XML::Compile has created everything before, too
$soap->ListPerson({});
my $lite = SOAP::Lite->new()->default_ns('http://www.example.org/benchmark/')
	->proxy('http://localhost:81/soap-wsdl-test/person.pl');
$lite->on_action( sub { 'http://www.example.org/benchmark/ListPerson' } );

$lite->ListPerson();

my $lite_xml = SOAP::Lite->new()->default_ns('http://www.example.org/benchmark/')
    ->proxy('http://localhost:81/soap-wsdl-test/person.pl');
$lite_xml->on_action( sub { 'http://www.example.org/benchmark/ListPerson' } );
$lite_xml->outputxml(1);

$lite_xml->ListPerson();

# # register for SOAP 1.1
#SOAP::WSDL::Factory::Deserializer->register('1.1' => 'SOAP::WSDL::Deserializer::XSD_XS' );
#my $wsdl_xs = MyInterfaces::TestService::TestPort->new();

$wsdl_xs->ListPerson({}) eq $soap->ListPerson()
    or die "SOAP::WSDL_XS and SOAP::WSDL return different content";
$wsdl_xs->ListPerson({}) !~m{Fault}
    or die "SOAP::WSDL_XS returns a fault:" , $wsdl_xs->ListPerson({});
# exit;

my $count = 70;
my @data = ();
my $n = 0;
print "Benchmark conducted with
SOAP::Lite - $SOAP::Lite::VERSION
SOAP::WSDL - $SOAP::WSDL::Client::VERSION
SOAP::WSDL_XS - $SOAP::WSDL::Deserializer::XSD_XS::VERSION;
XML::Compile::SOAP - $XML::Compile::SOAP::VERSION
XML::Simple - $XML::Simple::VERSION

XML::Simple uses XML::Parser as backend and SOAP::Lite with 
outputxml(1) set as SOAP client.
XML::Parser - $XML::Parser::VERSION

XML::Simple is not benchmarked in run 3ff, as it is expected
do deliver the same result.

Benchmark $n: Store result in private variable and destroy it
";
$n++;
cmpthese $count, {
	'SOAP::Lite'	=> sub { my $som = $lite->call('ListPerson') },
    'SOAP::WSDL' => sub { my $result = $soap->ListPerson({}) },
#    'SOAP::WSDL_XS' => sub { my $result = $wsdl_xs->ListPerson({}) },
#    'XML::Compile' => sub { my $result = $call->() },
	'XML::Simple'   => sub { my $result = XMLin( $lite_xml->call('ListPerson')) },
};

print "\nBenchmark $n: Push result on list\n";
$n++;
cmpthese $count, {
    'SOAP::Lite'    => sub { push @data, $lite->call('ListPerson') },
    'SOAP::WSDL'    => sub { push @data, $soap->ListPerson({}) },
#    'SOAP::WSDL_XS' => sub { push @data, $wsdl_xs->ListPerson({}) },
#    'XML::Compile'  => sub { push @data, $call->() },
	'XML::Simple'   => sub { push @data, XMLin( $lite_xml->call('ListPerson')) },
};

@data = ();
print "\nBenchmark $n: Play it, please play it again, Sam\n";
$n++;
cmpthese $count, {

    'SOAP::WSDL'    => sub { push @data, $soap->ListPerson({}) },
#    'SOAP::WSDL_XS' => sub { push @data, $wsdl_xs->ListPerson({}) },
#    'XML::Compile'  => sub { push @data, $call->() },
#    'SOAP::Lite'    => sub { push @data, $lite->call('ListPerson') },
};

print "\nBenchmark $n: ca. 1kB request - result destroyed immediately\n";
$n++;
cmpthese $count, {
    'SOAP::WSDL'    => sub { my $result = $soap->ListPerson({ in => $person }) },
#    'SOAP::WSDL_XS' => sub { my $result = $wsdl_xs->ListPerson({ in => $person }) },
#    'XML::Compile'  => sub { my $result = $call->({ in => $person }) },
};

print "\nBenchmark $n: ca. 1kB request - push result on list\n";
$n++;
cmpthese $count, {
    'SOAP::WSDL'    => sub { push @data, $soap->ListPerson({ in => $person }) },
#    'SOAP::WSDL_XS' => sub { push @data, $wsdl_xs->ListPerson({ in => $person }) },
#    'XML::Compile'  => sub { push @data, $call->({ in => $person }) },
};

