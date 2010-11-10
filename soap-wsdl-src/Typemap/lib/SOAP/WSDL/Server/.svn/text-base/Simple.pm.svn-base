package SOAP::WSDL::Server::Simple;
use strict;
use warnings;

use Encode;

use HTTP::Request;
use HTTP::Response;
use HTTP::Status;
use HTTP::Headers;
use Scalar::Util qw(blessed);

use Class::Std::Fast::Storable;

use base qw(SOAP::WSDL::Server);

use version; our $VERSION = qv('2.00.99_3');

# mostly copied from SOAP::Lite. Unfortunately we can't use SOAP::Lite's CGI
# server directly - we would have to swap out it's base class...
#
# This should be a warning for us: We should not handle methods via inheritance,
# but via some plugin mechanism, to allow alternative handlers to be plugged
# in.

sub handle {
    my ($self, $cgi) = @_;

    my $response;

    my $content = $cgi->param('POSTDATA');

    my $request = HTTP::Request->new(
        $ENV{'REQUEST_METHOD'} || '' => $ENV{'SCRIPT_NAME'},
        HTTP::Headers->new(
            map {
                    (/^HTTP_(.+)/i
                        ? ($1=~m/SOAPACTION/)
                            ?('SOAPAction')
                            :($1)
                        : $_
                     ) => $ENV{$_}
            } keys %ENV),
        $content,
    );

    # we copy the response message around here.
    # Passing by reference would be much better...
    my $response_message = eval { $self->SUPER::handle($request) };

    # caveat: SOAP::WSDL::SOAP::Typelib::Fault11 is false in bool context...
    if ($@ || blessed $@) {
        my $exception = $@;
        $response = HTTP::Response->new(500);
        $response->header('Content-type' => 'text/xml; charset="utf-8"');
        if (blessed($exception)) {
            $response->content( $self->get_serializer->serialize({
                    body => $exception
                })
            );
        }
        else {
            $response->content($exception);
        }
    }
    else {
        $response = HTTP::Response->new(200);
        $response->header('Content-type' => 'text/xml; charset="utf-8"');
        $response->content( encode('utf8', $response_message ) );
        {
            use bytes;
            $response->header('Content-length', length $response_message);
        }
    }

    $self->_output($response);
    return;
}

sub _output :PRIVATE {
    my ($self, $response) = @_;
    my $code = $response->code;
    binmode(STDOUT);
    print STDOUT "HTTP/1.0 $code ", HTTP::Status::status_message($code)
        , "\015\012", $response->headers_as_string("\015\012")
        , "\015\012", $response->content;

    warn "HTTP/1.0 $code ", HTTP::Status::status_message($code)
        , "\015\012", $response->headers_as_string("\015\012")
        , $response->content, "\n\n";
}

1;

=pod

=head1 NAME

SOAP::WSDL::Server::Simple - CGI based SOAP server for HTTP::Server::Simple

=head1 SYNOPSIS

 package TestServer;
 use base qw(HTTP::Server::Simple::CGI);
 use MyServer::TestService::TestPort;

 sub handle_request {
     my ($self, $cgi) = @_;
     my $server = MyServer::TestService::TestPort->new({
         dispatch_to => 'main',
         transport_class => 'SOAP::WSDL::Server::Simple',
     });
     $server->handle($cgi);
 }

 my $httpd = __PACKAGE__->new();
 $httpd->run();

=head1 USAGE

To use SOAP::WSDL::Server::Simple efficiently, you should first create a server
interface using L<wsdl2perl.pl|wsdl2perl.pl>.

SOAP::WSDL::Server::Simple dispatches all calls to appropriately named methods in the
class or object set via C<dispatch_to>.

See the generated server class on details.

=head1 DESCRIPTION

Lightweight SOAP server for use with HTTP::Server::Simple, mainly designed
for testing purposes. It allows to set up a simple SOAP server without having
to configure CGI or mod_perl stuff.

SOAP::WSDL::Server::Simple is not recommended for production use.

=head1 METHODS

=head2 handle

See synopsis above.

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2008 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under the same
terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 391 $
 $LastChangedBy: kutterma $
 $Id: Client.pm 391 2007-11-17 21:56:13Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Client.pm $

=cut
