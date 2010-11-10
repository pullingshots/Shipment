use Test::More;

eval { require SOAP::Lite; 1; } or do {
    plan skip_all => 'SOAP::Lite not available';
    exit 0;
};

print "# Using SOAP::Lite $SOAP::Lite::VERSION\n";

use lib '../../../lib';
plan tests => 13;
use_ok qw(SOAP::WSDL::Deserializer::SOM);

ok my $deserializer = SOAP::WSDL::Deserializer::SOM->new();

ok my $som = $deserializer->deserialize(q{<a><b>1</b><b>2</b><c>3</c></a>});
my $data = $som->match('/a')->valueof;

is $data->{ c } , 3;

SKIP: {
    skip "SOAP::Lite > 0.69 required" , 2 if ($SOAP::Lite::VERSION lt '0.69');
    is $data->{ b }->[0] , 1, "array values - SOAP::Lite $SOAP::Lite::VERSION";;
    is $data->{ b }->[1] , 2, "array values - SOAP::Lite $SOAP::Lite::VERSION";;
}

eval { $deserializer->generate_fault({
    role => 'soap:Server',
    code => 'Test',
    message => 'Teststring'
});
};

my $fault = $@;

isa_ok $fault, 'SOAP::Fault';

is $fault->faultcode(),     'Test';
is $fault->faultactor(),    'soap:Server';
is $fault->faultstring(),   'Teststring';

$fault = $deserializer->deserialize('');

isa_ok $fault, 'SOAP::Fault';

is $fault->faultactor(),    'SOAP-ENV:Server';
like $fault->faultstring(), qr{no \s element \s found}x;

