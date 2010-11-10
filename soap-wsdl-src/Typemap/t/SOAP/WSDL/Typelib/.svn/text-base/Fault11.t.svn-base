use Test::More tests => 6;
use strict;
use warnings;

# use_ok fails to trigger Class::Std's overloading attributes
use SOAP::WSDL::SOAP::Typelib::Fault11;

my $fault = SOAP::WSDL::SOAP::Typelib::Fault11->new({
    faultcode => 'soap:Server',
    faultstring => 'Fault message',
});

ok "$fault", 'stringification'; 

if ($fault)  { fail 'boolify' } else { pass 'boolify' }

ok ! $fault->as_bool() , 'as_bool';

is $fault->get_xmlns(), 'http://schemas.xmlsoap.org/soap/envelope/';

is $fault->get_faultcode(), 'soap:Server', 'content';
is $fault->get_faultstring(), 'Fault message', 'content';