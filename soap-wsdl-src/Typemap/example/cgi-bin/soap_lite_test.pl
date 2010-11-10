#!/usr/bin/perl
package main;
use SOAP::Transport::HTTP;
SOAP::Transport::HTTP::CGI->dispatch_to('webservices::Authenticate')->handle;

package webservices;
use vars qw(@ISA);
@ISA = qw(Exporter SOAP::Server::Parameters);
use SOAP::Lite;

sub Authenticate {
    my $self     = shift;
    my $envelope = pop;
    my $temp     = $envelope->dataof("//c2f/temperature");
               return SOAP::Data->name('param'=> 12);
}

