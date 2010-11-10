package MyTypelib;
use strict;
use warnings;


sub find_element {};
sub find_type {};

package main;

use strict;
use warnings;
use Test::More tests => 5;

use_ok qw(SOAP::WSDL::Part);

my $typelib = {};

eval { SOAP::WSDL::Part->serialize() };
like $@, qr{No typelib};

my $opt = {
    typelib => 'MyTypelib',
    namespace => { foo => 'bar'}
};

my $data = {};

my $part = SOAP::WSDL::Part->new();

eval { $part->serialize('name', $data, $opt ) };
like $@, qr{Neither type nor element};

$part->set_type('foo:Foo');

eval { $part->serialize('name', $data, $opt ) };
like $@, qr{type foo:Foo};

$part->set_type(undef);

$part->set_element('foo:Foo');

eval { $part->serialize('name', $data, $opt ) };
like $@, qr{element foo:Foo};
