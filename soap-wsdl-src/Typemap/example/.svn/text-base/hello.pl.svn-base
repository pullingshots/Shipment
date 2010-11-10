#!/usr/bin/perl -w
use strict;
use warnings;
use lib 'lib';  # just needed because interface lies here

# I have to generate the interface using wsdl2perl.pl before
use MyInterfaces::HelloWorld::HelloWorldSoap;

# I instantiate a interface class.
my $soap = MyInterfaces::HelloWorld::HelloWorldSoap->new({
#	proxy => 'http://localhost:8080/JLearn/WS/sayHello'
});

# I have to lookup the method and synopsis from the interface's pod
my $result = $soap->sayHello({
    name => $ARGV[1] || '"Your name"',
    givenName => $ARGV[0] || '"Your given name"',
});

# SOAP::WSDL::SOAP::Typelib::Fault11 objects are false, but serialize to XML
die $result if not $result;

# I have to lookup the output parameter from the interface's POD - or try:
# Will die on bad method names with a list of available methods
print $result->get_sayHelloResult(), "\n";

