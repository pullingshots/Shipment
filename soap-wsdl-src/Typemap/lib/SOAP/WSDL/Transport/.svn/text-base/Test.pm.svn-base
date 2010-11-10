package SOAP::WSDL::Transport::Test;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use SOAP::WSDL::Factory::Transport;

use version; our $VERSION = qv('2.00.99_3');

SOAP::WSDL::Factory::Transport->register( http => __PACKAGE__ );
SOAP::WSDL::Factory::Transport->register( https => __PACKAGE__ );

my %code_of :ATTR(:name<code>           :default<()>);
my %status_of :ATTR(:name<status>       :default<()>);
my %message_of :ATTR(:name<message>     :default<()>);
my %is_success_of :ATTR(:name<is_success> :default<()>);
my %base_dir_of :ATTR(:name<base_dir> :init_arg<base_dir> :default<.>);

# create methods normally inherited from SOAP::Client
SUBFACTORY: {
    no strict qw(refs);
    foreach my $method ( qw(code message status is_success) ) {
        *{ $method } = *{ "get_$method" };
    }
}

sub send_receive {
    my ($self, %parameters) = @_;
    my ($envelope, $soap_action, $endpoint, $encoding, $content_type) =
        @parameters{qw(envelope action endpoint encoding content_type)};

    my $filename = $soap_action;
    $filename =~s{ \A(:?'|") }{}xms;
    $filename =~s{ (:?'|")\z }{}xms;
    $filename =~s{ \A [^:]+ : (:? /{2})? }{}xms;

    $filename = join '/', $base_dir_of{ ${ $self } }, "$filename.xml";

    if (not -r $filename) {
        warn "cannot access $filename";
        $self->set_code( 500 );
        $self->set_message( "Failed" );
        $self->set_is_success(0);
        $self->set_status("500 Failed");
        return;
    }

    open my $fh, '<', $filename or die "cannot open $filename: $!";
    binmode $fh;
    my $response = <$fh>;
    close $fh or die "cannot close $filename: $!";

    $self->set_code( 200 );
    $self->set_message( "OK" );
    $self->set_is_success(1);
    $self->set_status("200 OK");
    return $response;
}

1;

=head1 NAME

SOAP::WSDL::Transport::Test - Test transport class for SOAP::WSDL

=head1 SYNOPSIS

 use SOAP::WSDL::Client;
 use SOAP::WSDL::Transport::Test;

 my $soap = SOAP::WSDL::Client->new()
 $soap->get_transport->set_base_dir('.');
 $soap->call('method', \%body, \%header);

=head1 DESCRIPTION

SOAP::WSDL::Transport::Test is a file-based test transport backend for
SOAP::WSDL.

When SOAP::WSDL::Transport::Test is used as transport backend, the reponse is
read from a XML file and the request message is discarded. This is
particularly useful for testing SOAP::WSDL plugins.

=head2 Filename resolution

SOAP::WSDL::Transport makes up the response XML file name from the SOAPAction
of the request. The following filename is used:

 base_dir / soap_action .xml

The protocol scheme (e.g. http:) and two heading slashes (//) are stripped from
the soap_action.

base_dir defaults to '.'

Examples:

 SOAPAction: http://somewhere.over.the.rainbow/webservice/webservice.asmx
 Filename: ./somewhere.over.the.rainbow/webservice/webservice.asmx.xml

 SOAPAction: uri:MyWickedService/test
 Filename: ./MyWickedService/test.xml


=head1 METHODS

=head2 set_base_dir

Sets the base directory SOAP::WSDL::Transport::Test should look for response
files.

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2007 Martin Kutter. All rights reserved.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 218 $
 $LastChangedBy: kutterma $
 $Id: HTTP.pm 218 2007-09-10 16:19:23Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Transport/HTTP.pm $

=cut
