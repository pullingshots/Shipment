#!/usr/bin/perl -w
package main;
use strict;
use warnings;
use lib qw(../lib ../../lib);
use MyElements::ListPersonResponse;
use MyServer::TestService::TestPort;
my $server = MyServer::TestService::TestPort->new({
   dispatch_to => 'main',
   transport_class => 'SOAP::WSDL::Server::CGI',   # optional, default
});
$server->handle();

sub ListPerson {
    my ($self, $body, $header) = @_;
    # body is a ??? object - sorry, POD not implemented yet
    # header is a ??? object - sorry, POD not implemented yet
    
    # do something with body and header...

    my %person = (
        PersonID =>         { # MyTypes::PersonID
          ID =>  1, # int
        },
        Salutation => 'Salutation0', # string
        Name =>  'Name0', # string
        GivenName =>  'Martin', # string
        DateOfBirth =>  '1970-01-01', # date
        HomeAddress =>         { # MyTypes::Address
          Street => 'Street 0', # string
          ZIP =>  '00000', # string
          City =>  'City0', # string
          Country =>  'Country0', # string
          PhoneNumber => '++499131123456', # PhoneNumber
          MobilePhoneNumber => '++49150123456', # PhoneNumber
        },
        WorkAddress =>         { # MyTypes::Address
          Street => 'Somestreet 23', # string
          ZIP =>  '12345', # string
          City =>  'SomeCity', # string
          Country =>  'Germany', # string
          PhoneNumber => '++499131123456', # PhoneNumber
          MobilePhoneNumber => '++49150123456', # PhoneNumber
        },
        Contracts =>         { # MyTypes::ArrayOfContract
          Contract => [          
          { # MyTypes::Contract
            ContractID =>  100000, # long
            ContractName =>  'SomeContract0', # string
          },
          { # MyTypes::Contract
            ContractID =>  100001, # long
            ContractName =>  'SomeContract1', # string
          },
          { # MyTypes::Contract
            ContractID =>  100002, # long
            ContractName =>  'SomeContract2', # string
          },
          { # MyTypes::Contract
            ContractID =>  100003, # long
            ContractName =>  'SomeContract3', # string
          },
          ],
        },
    );

    return  MyElements::ListPersonResponse->new(  {
    out => { # MyTypes::ArrayOfPerson
            NewElement => [
                { %person },
                { %person },
                { %person },
                { %person },
                { %person },
                { %person },
                { %person },
                { %person },
                { %person },
                { %person },
            ],
        },
    }
 );
 }
