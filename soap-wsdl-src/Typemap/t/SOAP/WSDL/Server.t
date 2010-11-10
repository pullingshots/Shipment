use diagnostics;
package MyDeserializer;
use Class::Std::Fast;
require Test::More;
my %class_resolver_of :ATTR(:name<class_resolver> :default<()>);
sub generate_fault {
    Test::More::pass("generate fault on $_[1]->{ message }");
    return $_[1]->{ message };
}
sub deserialize {
    return ('Body', 'Header');
}

package MyDeserializer2;
use Class::Std::Fast;

sub deserialize {
    die "Deserialize";
}
sub generate_fault {
    Test::More::like($_[1]->{ message }, qr{\A Error \s deserializing }x, 'Generate fault on deserialize error' );
    return $_[1]->{ message };
}

package MyHandler;

sub test {
    return 'Test';
}

package main;
use strict;
use warnings;
use HTTP::Request;
use Test::More tests => 12;
use_ok qw(SOAP::WSDL::Server);

my $server = SOAP::WSDL::Server->new();
$server->set_deserializer( MyDeserializer->new() );
eval { $server->handle(HTTP::Request->new()) };
like $@, qr{\A No \s handler}x, 'No handler fault caught';

$server->set_dispatch_to('MyHandler');
eval { $server->handle(HTTP::Request->new()) };
like $@, qr{\A Not \s found: \sNo \s SOAPAction \s given}x, 'No SOAPAction fault caught';

my $request = HTTP::Request->new();
$request->header('SOAPAction', 'Test');
$server->set_dispatch_to('MyHandler');
eval { $server->handle($request) };
like $@, qr{\A Not \s found: \sNo \s method \s found \s for \s the \s SOAPAction \s 'Test'}x, 'No SOAPAction fault caught';

$server->set_action_map_ref({ Test => 'test2'});
eval { $server->handle($request) };
like $@, qr{\A Not \s implemented:}x, 'Not implemented fault caught';


$server->set_action_map_ref({ Test => 'test'});
ok $server->handle($request);

$server->set_deserializer( MyDeserializer2->new() );
eval { $server->handle($request) };
like $@, qr{\A Error \s deserializing}x, 'Error deserializing caught';

sub test {
    return;
}
