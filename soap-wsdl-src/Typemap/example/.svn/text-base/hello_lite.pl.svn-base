#!/usr/bin/perl -w
#use strict;
use warnings;
use SOAP::Lite; # +trace;

# I have to lookup the URL from the WSDL
my $soap = SOAP::Lite->new(
    proxy => 'http://localhost:81/soap-wsdl-test/helloworld.pl'
);

# I have to lookup the SOAPAction from the WSDL
$soap->on_action( sub { "urn:HelloWorld#sayHello" });
$soap->autotype(0);

# I have to lookup the top level element's namespace from the WSDL
$soap->default_ns('urn:HelloWorld');

# I have to encode all parameters as SOAP::Data objects
# I have to know the order of parameters
my $som = $soap->call(
    "sayHello",
    SOAP::Data->name('name')->value( $ARGV[1] || '"Your name"'),
    SOAP::Data->name('givenName')->value( $ARGV[0] || '"Your given name"'),
);

die $som->fault->{ faultstring } if ($som->fault);

print $som->result(), "\n";

