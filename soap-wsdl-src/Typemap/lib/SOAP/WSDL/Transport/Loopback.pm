package SOAP::WSDL::Transport::Loopback;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'basic';
use SOAP::WSDL::Factory::Transport;

use version; our $VERSION = qv('2.00.99_3');

# register on loading
SOAP::WSDL::Factory::Transport->register( http => __PACKAGE__ );
SOAP::WSDL::Factory::Transport->register( https => __PACKAGE__ );

my %code_of         :ATTR(:name<code>           :default<()>);
my %status_of       :ATTR(:name<status>         :default<()>);
my %message_of      :ATTR(:name<message>        :default<()>);
my %is_success_of   :ATTR(:name<is_success>     :default<()>);

# create methods normally inherited from SOAP::Client
SUBFACTORY: {
    no strict qw(refs);
    foreach my $method ( qw(code message status is_success) ) {
        *{ $method } = *{ "get_$method" };
    }
}

sub send_receive {
    my ($self, %parameters) = @_;
    return $parameters{envelope};
}

Class::Std::initialize();


1;

=head1 NAME

SOAP::WSDL::Transport::Test - Loopback transport class for SOAP::WSDL

=head1 SYNOPSIS

 use SOAP::WSDL::Client;
 use SOAP::WSDL::Transport::Loopback;

 my $soap = SOAP::WSDL::Client->new()
 $soap->get_transport->set_base_dir('.');
 $soap->call('method', \%body, \%header);

=head1 DESCRIPTION

SOAP::WSDL::Transport::Loopback is a loopback test transport backend for
SOAP::WSDL.

When SOAP::WSDL::Transport::Loopback is used as transport backend, the
request is returned as response. No data ever goes over the wire.
This is particularly useful for testing SOAP::WSDL plugins and applications.

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