use strict;
use warnings;
use Test::More tests => 4;

use SOAP::WSDL::Factory::Deserializer;

eval { SOAP::WSDL::Factory::Deserializer->get_deserializer({
    soap_version => 'zumsl'
}) };
like $@, qr{^no deserializer};

ok my $serializer = SOAP::WSDL::Factory::Deserializer->get_deserializer({
    soap_version => '1.1'
});
ok $serializer = SOAP::WSDL::Factory::Deserializer->get_deserializer({});

SOAP::WSDL::Factory::Deserializer->register('1.1', 'Hope_You_Have_No_Such_Package_Installed');

eval { SOAP::WSDL::Factory::Deserializer->get_deserializer({
    soap_version => '1.1'
}) };
like $@, qr{^Cannot load};
