use strict;
use warnings;
use Test::More tests => 4;

use SOAP::WSDL::Factory::Serializer;

eval { SOAP::WSDL::Factory::Serializer->get_serializer({
    soap_version => 'zumsl'
}) };
like $@, qr{^no serializer};

ok my $serializer = SOAP::WSDL::Factory::Serializer->get_serializer({
    soap_version => '1.1'
});

ok $serializer = SOAP::WSDL::Factory::Serializer->get_serializer({});

SOAP::WSDL::Factory::Serializer->register('1.1', 'Hope_You_Have_No_Such_Package_Installed');

eval { SOAP::WSDL::Factory::Serializer->get_serializer({
    soap_version => '1.1'
}) };
like $@, qr{^Cannot load};
