#!perl -w
use strict;
use warnings;

use SOAP::WSDL::Build;

my $build = SOAP::WSDL::Build->new(
    dist_name => 'Person',
    dist_version => 0.1,
    wsdl2perl => [
    {
        location => 'wsdl/Person.wsdl',
        prefix => 'Person::',
    }
    ]
);

$build->create_build_script();