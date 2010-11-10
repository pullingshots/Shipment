package SOAP::WSDL::Server::CGI;
use strict;
use warnings;
use Encode;
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
    my $self = shift;
    my $response;
    my $length = $ENV{'CONTENT_LENGTH'} || 0;

    if (!$length) {
        $response = HTTP::Response->new(411); # LENGTH REQUIRED
        $self->_output($response);
        return;
    }

    if (exists $ENV{EXPECT} && $ENV{EXPECT} =~ /\b100-Continue\b/i) {
        print "HTTP/1.1 100 Continue\r\n\r\n";
    }

    my $content = q{};
    my $buffer;

    # do we need to use bytes; here ?
    binmode(STDIN);
    while (read(STDIN,$buffer,$length - length($content))) {
        $content .= $buffer;
    }

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
    # imitate nph- cgi for IIS (pointed by Murray Nesbitt)
    my $status = defined($ENV{'SERVER_SOFTWARE'}) && $ENV{'SERVER_SOFTWARE'}=~/IIS/
        ? $ENV{SERVER_PROTOCOL} || 'HTTP/1.0'
        : 'Status:';

    my $code = $response->code;
    binmode(STDOUT);
    print STDOUT "$status $code ", HTTP::Status::status_message($code)
        , "\015\012", $response->headers_as_string("\015\012")
        , "\015\012", $response->content;
}

1;

=pod

=head1 NAME

SOAP::WSDL::Server::CGI - CGI based SOAP server

=head1 SYNOPSIS

 use MyServer::TestService::TestPort;
 my $server = MyServer::TestService::TestPort->new({
    dispatch_to => 'main',
    transport_class => 'SOAP::WSDL::Server::CGI',   # optional, default
 });
 $server->handle();

=head1 USAGE

To use SOAP::WSDL::Server::CGI efficiently, you should first create a server
interface using L<wsdl2perl.pl|wsdl2perl.pl>.

SOAP::WSDL::Server dispatches all calls to appropriately named methods in the
class or object set via C<dispatch_to>.

See the generated server class on details.

=head1 DESCRIPTION

Lightweight CGI based SOAP server. SOAP::WSDL::Server::CGI does not provide
the fancier things of CGI handling, like URL parsing, parameter extraction
or the like, but provides a basic SOAP server using SOAP::WSDL::Server.

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
