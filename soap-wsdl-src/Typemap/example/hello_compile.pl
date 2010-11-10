#!/usr/bin/perl -w
use strict;
use warnings;
use XML::Compile::SOAP11;
use XML::Compile::WSDL11;
use XML::Compile::Transport::SOAPHTTP;

# I need access to the WSDL around - or use Data::Dumper::Streamer
# for serializing the generated closures into (big) perl files
my $wsdl = XML::Compile::WSDL11->new('wsdl/11_helloworld.wsdl');

# I compile a interface method for a single SOAP method from the WSDL
# I have to lookup the method names from the WSDL
# or use the provided script examining the WSDL
my $call = $wsdl->compileClient('sayHello');

# I have to lookup the parameters from the WSDL - can be quite tricky
# XML::Compile provides a script creating examples, so I can use that, too.
my $result = $call->(
    name => $ARGV[1] || '"Your name"',
    givenName => $ARGV[0] || '"Your given name"',
);

# XML::Compile::SOAP's client just returns undef in case of failure
die "Error calling soap method" if not defined $result;

# I have to lookup the output parameters from the WSDL - or try Data::Dumper
# XML::Compile provides a script creating examples, so I can use that, too.
print $result->{ parameters }->{ sayHelloResult }, "\n";
