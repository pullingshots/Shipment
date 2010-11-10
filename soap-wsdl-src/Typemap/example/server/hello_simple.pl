use lib '../../lib';
use lib '../lib';
use SOAP::WSDL::Server::Simple;

use base qw(HTTP::Server::Simple::CGI);

use MyServer::HelloWorld::HelloWorldSoap;

sub handle_request {
     my ($self, $cgi) = @_;
     my $server = MyServer::HelloWorld::HelloWorldSoap->new({
         dispatch_to => 'main',
         transport_class => 'SOAP::WSDL::Server::Simple',
     });
     $server->handle($cgi);
 }

 my $httpd = __PACKAGE__->new(8081);
 $httpd->run();

sub sayHello {
    my ($self, $body, $header) = @_;
    my $name = $body->get_name();
    my $givenName = $body->get_givenName();

    return MyElements::sayHelloResponse->new({
        sayHelloResult => "Hello $givenName $name"
    })
}