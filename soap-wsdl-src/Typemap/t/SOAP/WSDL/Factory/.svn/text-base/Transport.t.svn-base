use strict;
use warnings;
use Test::More tests => 15;
use Scalar::Util qw(blessed);
use SOAP::WSDL::Factory::Transport;

eval { SOAP::WSDL::Factory::Transport->get_transport('') };
like $@, qr{^no transport};

eval { SOAP::WSDL::Factory::Transport->get_transport('zumsl') };
like $@, qr{^no transport};

my $obj;

SKIP: {
    # fake absence of SOAP::Lite
    eval q{ use Test::Without::Module qw(SOAP::Transport::HTTP); 1; }
        or skip "cannot fake absence of modules without Test::Without::Module", 7;

    # fake absence of SOAP::WSDL::Transport::HTTP - must throw error
    eval q{ use Test::Without::Module qw(SOAP::WSDL::Transport::HTTP); };
    eval { SOAP::WSDL::Factory::Transport->get_transport('http') };
    like $@, qr{Cannot \s load \s transport \s class \s SOAP::WSDL::Transport::HTTP}x;

    # try again - but now allow to load
    eval q{ no Test::Without::Module qw(SOAP::WSDL::Transport::HTTP); };
    ok $obj = SOAP::WSDL::Factory::Transport->get_transport('http'), 'load backend';
    ok $obj->isa('SOAP::WSDL::Transport::HTTP'), 'load SOAP::WSDL::Transport::HTTP';

    # Play it again to test what happens when it's loaded
    # make loading fail (with Test::Without::Module), to make sure we
    # don't load it again
    eval q{ use Test::Without::Module qw(SOAP::WSDL::Transport::HTTP); };
    ok $obj = SOAP::WSDL::Factory::Transport->get_transport('http'), 'get backend without loading';
    ok $obj->isa('SOAP::WSDL::Transport::HTTP'), 'load SOAP::WSDL::Transport::HTTP';

    eval q{ no Test::Without::Module qw(SOAP::WSDL::Transport::HTTP); };
    eval q{ no Test::Without::Module qw(SOAP::Transport::HTTP); };

    eval q{ require SOAP::Lite }
        or skip q{Cannot test loading SOAP::Lite's transport backend without SOAP::Lite}, 2;

    # try to load with SOAP::Lite install
    ok $obj = SOAP::WSDL::Factory::Transport->get_transport('http'), 'load backend';
    ok $obj->isa('SOAP::Transport::HTTP::Client'), 'load SOAP::Transport::HTTP::Client backend';
}

ok $obj = SOAP::WSDL::Factory::Transport->get_transport('http');
ok blessed $obj;


SOAP::WSDL::Factory::Transport->register('zumsl', 'Hope_You_Have_No_Such_Package_Installed');

eval { SOAP::WSDL::Factory::Transport->get_transport('zumsl:foo') };
like $@, qr{^Cannot load};

eval { SOAP::WSDL::Factory::Transport->register( \'zumsl', 'Foo') };
like $@, qr{^Cannot use reference};

# register and load a previously loaded backend
SOAP::WSDL::Factory::Transport->register( 'zumsl', 'SOAP::WSDL::Transport::HTTP');
isa_ok( SOAP::WSDL::Factory::Transport->get_transport('zumsl:foo'), 'SOAP::WSDL::Transport::HTTP');

# register and load a previously unloaded backend
SOAP::WSDL::Factory::Transport->register( 'zumsl', 'SOAP::WSDL::Transport::Loopback');
isa_ok(SOAP::WSDL::Factory::Transport->get_transport('zumsl:foo'), 'SOAP::WSDL::Transport::Loopback');
