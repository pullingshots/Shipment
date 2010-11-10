#!/usr/bin/perl -w
package main;
use strict;
use warnings;
use lib '../../lib';
use lib '../lib';
use MyServer::HelloWorld::HelloWorldSoap;

my $soap = MyServer::HelloWorld::HelloWorldSoap->new({
    dispatch_to => 'main',
});

$soap->handle();

sub sayHello {
    my ($self, $body, $header) = @_;
    my $name = $body->get_name();
    my $givenName = $body->get_givenName();

    return MyElements::sayHelloResponse->new({
        sayHelloResult => "Hello $givenName $name"
    })
}

=pod

=head1 NAME

helloworld.pl - a simple CGI-based SOAP server implementing the service from
in examples/wsdl/helloworld.wsdl

=head1 USAGE

Before using this script, you should secure your webserver. The easiest way
to do so is to let it listen to 127.0.0.1 only.

Then make a ScriptAlias named /soap-wsdl-test/ pointing at the directory
this file lies in.

For my apache, it looks like this:

 ScriptAlias /soap-wsdl-test/ /home/martin/workspace/SOAP-WSDL/example/cgi-bin/
 <Directory "/home/martin/workspace/SOAP-WSDL/example/cgi-bin">
    AllowOverride None
    Options +ExecCGI -MultiViews
    Order allow,deny
    Allow from all
 </Directory>

Then run the helloworld.pl from the examples directory. It should print

 Hello World

=head1 DESCRIPTION

=cut

