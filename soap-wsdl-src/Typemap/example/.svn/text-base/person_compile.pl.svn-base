#!/usr/bin/perl -w
use strict;
use warnings;
use XML::Compile::SOAP11;
use XML::Compile::WSDL11;
use XML::Compile::Transport::SOAPHTTP;

my $wsdl = XML::Compile::WSDL11->new('wsdl/Person.wsdl');

# I have to lookup the methods from the WSDL
my $call = $wsdl->compileClient('ListPerson');

# I have to lookup the parameters from the WSDL
my $result = $call->({ in => undef});

die "Error calling soap method" if not defined $result;

# I have to lookup the output parameters from the WSDL - or try Dumper
#use Data::Dumper;
#print Dumper $result;

print "Found ", scalar @{ $result->{ parameters }->{ out }->{ seq_NewElement }->[0]->{ NewElement } } , " persons\n";
