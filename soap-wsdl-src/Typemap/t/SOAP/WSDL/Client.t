package FaultDeserializer;
use strict;
use warnings;
use SOAP::WSDL::SOAP::Typelib::Fault11;

sub new { bless {}, shift }

sub deserialize {
    die SOAP::WSDL::SOAP::Typelib::Fault11->new( {} );
}

package main;
use strict;
use warnings;
use Test::More tests => 16;
use SOAP::WSDL::Transport::Loopback;
use Scalar::Util qw(blessed);

use_ok qw(SOAP::WSDL::Client);

{
    no warnings qw(redefine once);
    *SOAP::WSDL::Factory::Transport::get_transport = sub {
        my ( $self, $url, %args_of ) = @_;
        if (%args_of) {
            is $args_of{foo}, 'bar';
        }
    };
}

sub test_client_basics {
    ok my $client = SOAP::WSDL::Client->new();
    ok $client = SOAP::WSDL::Client->new( {proxy => 'http://localhost',} );
    is $client->get_content_type(), 'text/xml; charset=utf-8';
    is $client->get_endpoint(),     'http://localhost';
    $client->set_proxy( 'http://localhost', foo => 'bar', );

   #TODO is this behaviour still required? declare as deprecated and remove...
    $client->set_proxy( ['http://localhost', foo => 'bar',] );

    is $client->get_proxy(), $client->get_transport(),
      'get_proxy returns same as get_transport';

    ok $client->set_soap_version('1.1');
    is $client->get_soap_version(), '1.1';

    $client->set_deserializer_args( {strict => 0} );
    is $client->get_deserializer_args()->{strict}, 0;
}

sub test_call {
    my $client = SOAP::WSDL::Client->new();
    $client->no_dispatch(1);
    $client->set_serializer('main');
    my $serialize = $client->call(
        {operation => 'testMethod'},
        {foo       => 'bar'},
        {bar       => 'baz'} );
    is $serialize->{body}->{foo},   'bar';
    is $serialize->{header}->{bar}, 'baz';

    #   Old calling style compatibility test - foo => bar is body...
    $serialize = $client->call( {operation => 'testMethod'}, foo => 'bar' );
    is $serialize->{body}->{foo}, 'bar';

    # Old calling style compatibility test - foo => bar is body...
    $serialize = $client->call( 'testMethod', foo => 'bar' );
    is $serialize->{body}->{foo}, 'bar';
}

sub serialize {
    my $self = shift;
    return shift;
}


sub test_deserializer_fault {

    my $client = SOAP::WSDL::Client->new();
    $client->set_deserializer( FaultDeserializer->new() );
    $client->set_transport( SOAP::WSDL::Transport::Loopback->new() );

    my $fault = $client->call(
        {operation => 'testMethod'},
        {foo       => 'bar'},
        {bar       => 'baz'} );

    ok( (blessed $fault and $fault->isa('SOAP::WSDL::SOAP::Typelib::Fault11')),
      'Return fault on throwing during deserialization ' . $@);

}

test_client_basics();
test_call();
test_deserializer_fault();

