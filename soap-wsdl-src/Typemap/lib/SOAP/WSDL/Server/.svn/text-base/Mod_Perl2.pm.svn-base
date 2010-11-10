package SOAP::WSDL::Server::Mod_Perl2;
use strict;
use warnings;
use base qw(SOAP::WSDL::Server);
use Scalar::Util qw(blessed);

use HTTP::Request       ();
use Apache2::RequestIO  (); # $r->read()
use Apache2::RequestRec (); # $r->headers_in
use Apache2::RequestUtil(); # $r->dir_config()
use APR::Table          (); # $r->headers_in->get()
use Apache2::Log        (); # $r->log
use Apache2::Const -compile => qw(
                                    OK
                                    SERVER_ERROR
                                    HTTP_LENGTH_REQUIRED
                                );

use version; our $VERSION = qv('2.00.99_3');

my %LOADED_OF = ();

sub handler {
    my $r       = shift;
    my $rlog    = $r->log();

    #
    # Set up section; import requested modules, throwing errors if we're
    # unable to do so. For maximum performance, this should be re-worked
    # to use perl-based Apache directives rather than dir_config(), since
    # the former happens at startup time and the latter at request time.

    #
    # dispatch_to
    my $dispatch_to     = $r->dir_config('dispatch_to');
    if (! $dispatch_to) {
        $rlog->error("No 'dispatch_to' variable set in httpd.conf");
        return Apache2::Const::SERVER_ERROR;
    }

    if (! exists $LOADED_OF{$dispatch_to}) {
        eval "require $dispatch_to";
        if ($@) {
            $rlog->error("Failed to require [$dispatch_to]: $@");
            return Apache2::Const::SERVER_ERROR;
        }
        $LOADED_OF{$dispatch_to} = undef;
    }

    #
    # SOAP service
    my $soap_service_package    = $r->dir_config('soap_service');
    if (! $soap_service_package) {
        $rlog->error("No 'soap_service' variable set in httpd.conf");
        return Apache2::Const::SERVER_ERROR;
    }

    if (! exists $LOADED_OF{$soap_service_package}) {
        eval "require $soap_service_package";
        if ($@) {
            $rlog->error("Failed to require [$soap_service_package]: $@");
            return Apache2::Const::SERVER_ERROR;
        }
        $LOADED_OF{$soap_service_package} = undef;
    }

    #
    # transport_class (optional)
    my $transport_class = $r->dir_config('transport_class');
    if ($transport_class) {
        eval "require $transport_class";
        if ($@) {
            $rlog->error("Failed to require [$transport_class]: $@");
            return Apache2::Const::SERVER_ERROR;
        }
    }
    else {
        #
        # if no transport class was specified, use this package's handle()
        # method
        $transport_class = __PACKAGE__;
    }

    #
    # instantiate SOAP server object
    my $server  = $soap_service_package->new({
            dispatch_to     => $dispatch_to,        # methods
            transport_class => $transport_class,    # handle() call
    });

    my $response_msg    = $server->handle($r);
    if ($response_msg =~ /^\d{3}$/) {
        #
        # a 3-digit number is presumed to be an HTTP return status; since
        # we got this and not a SOAP response, it's presumed to be an
        # error; pass it back to the client as-is
        $rlog->error("Dispatcher returned HTTP $response_msg");
        return $response_msg;
    }

    if ($response_msg) {
        $r->content_type('text/xml; charset="utf-8"');
        $r->print($response_msg);
        return Apache2::Const::OK;
    }
    else {
        $rlog->error("No response returned from dispatcher");
        return Apache2::Const::SERVER_ERROR;
    }
}

sub handle {
    my ($self, $r)  = @_;
    my $rlog        = $r->log();

    my $length  = $r->headers_in->get('content-length');
    if (! $length) {
        $rlog->error("No content-length provided");
        # TODO maybe throw instead of returning a HTTP code?
        # ... it's an exception, anyway...
        return Apache2::Const::HTTP_LENGTH_REQUIRED;
    }

    # read may return less than requested - read until there's no more...
    # TODO: We should note that LimitRequestBody is a must in apache config
    my ($buffer, $read_length);
    my $content = q{};
    while ($read_length = $r->read($buffer, $length)) {
        $content .= $buffer;
    }

    if ($length != length $content) {
        $rlog->error("Read length mismatch; read [" . length($content) . "] bytes but received [$length] bytes");
        return Apache2::Const::SERVER_ERROR;
    }

    # Shamelessly copied (with mild tweaks) from SOAP::WSDL::Server::CGI
    # ... which was as shamelessly copied from SOAP::Transport::HTTP...
    my $request = HTTP::Request->new(
                    $r->method  => $r->uri,
                    HTTP::Headers->new(
                        SOAPAction => $r->headers_in()->get('SOAPAction'),
                    ),
                    $content,
    );

    my $response_message   = eval { $self->SUPER::handle($request) };

    # TODO return response if @$ is a SOAP::WSDL::XSD::Typelib::Builtin::anyType object
    if ($@ || blessed($@)) {
        $rlog->error("Failed to handle request: $@");
        return Apache2::Const::SERVER_ERROR;
    }
    else {
        return $response_message;
    }
}

1;

__END__

=pod

=head1 NAME

SOAP::WSDL::Server::Mod_Perl2 - mod_perl based SOAP server using SOAP::WSDL

=head1 DESCRIPTION

Perl module providing a mod_perl2-based SOAP server using SOAP::WSDL

=head1 CONFIGURATION

Configuration is managed through the use of PerlSetVar directives.
The following variables are available:

=head2 dispatch_to

Takes as a single argument the package name of the module which contains
the methods which handle SOAP requests.

 PerlSetVar dispatch_to "WebPackage::SOAPMethods"

=head2 soap_service

Takes as a single argument the package name of the Server module
generated by SOAP::WSDL using

 wsdl2perl.pl --server file:///path/to/your/wsdl

By default, the name of the package is MyServer::$SERVICENAME::$PORTTYPE.

EXAMPLE: Given this sample WSDL which wsdl2perl.pl was run against to generate
perl packages:

    <wsdl:portType name="WebServiceSoap">
        [...]
    </wsdl:portType>

    [...]

    <wsdl:service name="WebService">
        <wsdl:port name="WebServiceSoap" binding="tns:WebServiceSoap">
            <soap:address location="http://www.example.com/WebService"/>
        </wsdl:port>
    </wsdl:service>

The following directive would be correct:

    PerlSetVar soap_service "MyServer::WebService::WebServiceSoap"

=head2 transport_class [OPTIONAL]

Takes as a single argument the package name of the perl module containing a
handle() method used to assemble the HTTP request which will be passed to the
methods in your L<dispatch_to> module (see above). A default handle() method
is supplied in this module which should handle most common cases.

handle() is called with the following parameters:

 $r - Apache::RequestRec object

=head1 EXAMPLES

The following snippet added to httpd.conf will enable a SOAP server at
/WebService on your webserver:

    <Location /WebService>
        SetHandler perl-script
        PerlResponseHandler SOAP::WSDL::Server::Mod_Perl2
        PerlSetVar dispatch_to "WebPackage::SOAPMethods"
        PerlSetVar soap_service "MyServer::WebService::WebServiceSoap"
    </Location>

=head1 PERFORMANCE

On my machine, a simple SOAP server (the HelloWorld service from the examples)
needs around 20s to process 300 requests to a CGI script implemented with
SOAP::WSDL::Server::CGI, around 4.5s to the same CGI with mod_perl enabled,
and around 3.2s with SOAP::WSDL::Server::Mod_Perl2. All these figures
include the time for creating the request and parsing the response.

As general advice, using mod_perl is highly recommended in high-performance
environments. Using SOAP::WSDL::Server::Mod_Perl2 yields an extra 20% speedup
compared with mod_perl enabled CGI scripts - and it allows one to configure
SOAP servers in the Apache config.

=head1 THREAD SAFETY

SOAP::WSDL uses Class::Std::Fast, which is not guaranteed to be threadsafe
yet. Thread safety in Class::Std::Fast is dependent on whether

 my $foo = $bar++;

is an atomic operation. I haven't found out yet.

A load test on a single CPU machine with 4 clients using the worker mpm
did not reveal any threading issues - but that does not mean there are none.

=head1 CREDITS

Contributed (along with lots of other little improvements) by Noah Robin.

Thanks!

=head1 LICENSE AND COPYRIGHT

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 AUTHOR

Noah Robin E<lt>noah.robin gmail.comE<gt>

Based on SOAP::WSDL::Server::CGI, by Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 583 $
 $LastChangedBy: kutterma $
 $Id: $
 $HeadURL: $

=cut
