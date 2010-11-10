package SOAP::WSDL::Factory::Transport;
use strict;
use warnings;
use version; our $VERSION = qv('2.00.99_3');

my %registered_transport_of = ();

# Local constants
# Could be made readonly, but that's just for the paranoid...
my %SOAP_LITE_TRANSPORT_OF = (
    ftp => 'SOAP::Transport::FTP',
    http => 'SOAP::Transport::HTTP',
    https => 'SOAP::Transport::HTTP',
    mailto => 'SOAP::Transport::MAILTO',
    'local' => 'SOAP::Transport::LOCAL',
    jabber => 'SOAP::Transport::JABBER',
    mq => 'SOAP::Transport::MQ',
);

my %SOAP_WSDL_TRANSPORT_OF = (
    http => 'SOAP::WSDL::Transport::HTTP',
    https => 'SOAP::WSDL::Transport::HTTP',
);

# class methods only
sub register {
    my ($class, $scheme, $package) = @_;
    die "Cannot use reference as scheme" if ref $scheme;
    $registered_transport_of{ $scheme } = $package;
}

sub get_transport {
    my ($class, $url, %attrs) = @_;


    my $scheme = $url;
    $scheme =~s{ \:.+$ }{}xm;


    if (defined $registered_transport_of{ $scheme }) {
        no strict qw(refs);
        $registered_transport_of{ $scheme }->can('new') or
            eval "require $registered_transport_of{ $scheme }"
                or die "Cannot load transport class $registered_transport_of{ $scheme } : $@";

        # try "foo::Client" class first - SOAP::Tranport always requires
        # a package withoug the ::Client appended, and then
        # instantiates a ::Client object...
        # ... pretty weird ...
        # ... must be from some time when the max number of files was a
        # sparse resource ...
        # ... but we've decided to mimic SOAP::Lite...

        return $registered_transport_of{ $scheme }->new( %attrs );
    }

    # try SOAP::Lite's Transport module - just skip if not require'able
    SOAP_Lite: {
        if (exists $SOAP_LITE_TRANSPORT_OF{ $scheme }) {
            no strict qw(refs);
            # behaves interestingly different under different versions of perl
            # maybe true even if it's not available
            my $protocol_class = $SOAP_LITE_TRANSPORT_OF{ $scheme } . '::Client';
            $protocol_class->can('new')
                or eval "require $SOAP_LITE_TRANSPORT_OF{ $scheme }"
                    or last SOAP_Lite;

            # may fail if it's not available
            my $transport = eval { $protocol_class->new( %attrs ) }
                or last SOAP_Lite;
            return $transport;
        }
    }

    if (exists $SOAP_WSDL_TRANSPORT_OF{ $scheme }) {
        no strict qw(refs);
        $SOAP_WSDL_TRANSPORT_OF{ $scheme }->can('new')
            or eval "require $SOAP_WSDL_TRANSPORT_OF{ $scheme }"
                or die "Cannot load transport class $SOAP_WSDL_TRANSPORT_OF{ $scheme } : $@";
        return $SOAP_WSDL_TRANSPORT_OF{ $scheme }->new( %attrs );
    }

    die "no transport class found for scheme <$scheme>";
}

1;

=pod

=head1 NAME

SOAP::WSDL::Factory::Transport - Factory for retrieving transport objects

=head1 SYNOPSIS

 # from SOAP::WSDL::Client:
 $transport = SOAP::WSDL::Factory::Transport->get_transport( $url, @opt );

 # in transport class:
 package MyWickedTransport;
 use SOAP::WSDL::Factory::Transport;

 # register class as transport module for httpr and https
 # (httpr is "reliable http", a protocol developed by IBM).
 SOAP::WSDL::Factory::Transport->register( 'httpr' , __PACKAGE__ );
 SOAP::WSDL::Factory::Transport->register( 'https' , __PACKAGE__ );

=head1 DESCRIPTION

SOAP::WSDL::Transport serves as factory for retrieving transport objects for
SOAP::WSDL.

The actual work is done by specific transport classes.

SOAP::WSDL::Transport tries to load one of the following classes:

=over

=item * the class registered for the scheme via register()

=item * the SOAP::Lite class matching the scheme

=item * the SOAP::WSDL class matching the scheme

=back

=head1 METHODS

=head2 register

 SOAP::WSDL::Transport->register('https', 'MyWickedTransport');

Globally registers a class for use as transport class.

=head2 proxy

 $trans->proxy('http://soap-wsdl.sourceforge.net');

Sets the proxy (endpoint).

Returns the transport for this protocol.

=head2 set_transport

Sets the current transport object.

=head2 get_transport

Gets the current transport object.

=head1 WRITING YOUR OWN TRANSPORT CLASS

=head2 Registering a transport class

Transport classes must be registered with SOAP::WSDL::Factory::Transport.

This is done by executing the following code where $scheme is the URL scheme
the class should be used for, and $module is the class' module name.

 SOAP::WSDL::Factory::Transport->register( $scheme, $module);

To auto-register your transport class on loading, execute register() in your
tranport class (see L<SYNOPSIS|SYNOPSIS> above).

Multiple protocols or multiple classes are registered by multiple calls to
register().

=head2 Transport plugin package layout

You may only use transport classes whose name is either
the module name or the module name with '::Client' appended.

=head2 Methods to implement

Transport classes must implement the interface required for SOAP::Lite
transport classes (see L<SOAP::Lite::Transport> for details,
L<SOAP::WSDL::Transport::HTTP|SOAP::WSDL::Transport::HTTP> for an example).

To provide this interface, transport modules must implement the following
methods:

=over

=item * new

=item * send_receive

Dispatches a request and returns the content of the response.

=item * code

Returns the status code of the last send_receive call (if any).

=item * message

Returns the status message of the last send_receive call (if any).

=item * status

Returns the status of the last send_receive call (if any).

=item * is_success

Returns true after a send_receive was successful, false if it was not.

=back

SOAP::Lite requires transport modules to pack client and server
classes in one file, and to follow this naming scheme:

 Module name:
   "SOAP::Transport::" . uc($scheme)

 Client class (additional package in module):
   "SOAP::Transport::" . uc($scheme) . "::Client"

 Server class (additional package in module):
   "SOAP::Transport::" . uc($scheme) . "::Client"

SOAP::WSDL does not require you to follow these restrictions.

There is only one restriction in SOAP::WSDL:

You may only use transport classes whose name is either the module name or
the module name with '::Client' appended.

SOAP::WSDL will try to instantiate an object of your transport class with
'::Client' appended to allow using transport classes written for SOAP::Lite.

This may lead to errors when a different module with the name of your
transport module suffixed with ::Client is also loaded.

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2007 Martin Kutter. All rights reserved.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 861 $
 $LastChangedBy: kutterma $
 $Id: Transport.pm 861 2010-03-28 10:41:26Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Factory/Transport.pm $

=cut
