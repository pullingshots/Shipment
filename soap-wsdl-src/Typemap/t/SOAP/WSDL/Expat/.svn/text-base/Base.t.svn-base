use strict;
use warnings;
use Test::More tests => 5;
use_ok qw(SOAP::WSDL::Expat::Base);

my $parser = SOAP::WSDL::Expat::Base->new();

eval { $parser->parse('Foobar')};
ok $@;

eval { $parser->parsefile('Foobar')};
ok $@;


$parser = SOAP::WSDL::Expat::Base->new({
    user_agent => 'foo',
});

is $parser->get_user_agent(), 'foo';
$parser->set_user_agent('bar');
is $parser->get_user_agent(), 'bar';
