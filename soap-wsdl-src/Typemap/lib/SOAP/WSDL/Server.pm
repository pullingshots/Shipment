package SOAP::WSDL::Server;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use SOAP::WSDL::Factory::Deserializer;
use SOAP::WSDL::Factory::Serializer;

use version; our $VERSION = qv('2.00.99_3');

my %dispatch_to_of      :ATTR(:name<dispatch_to>    :default<()>);
my %action_map_ref_of   :ATTR(:name<action_map_ref> :default<{}>);
my %method_map_ref_of   :ATTR(:name<method_map_ref> :default<{}>);
my %class_resolver_of   :ATTR(:name<class_resolver> :default<()>);
my %deserializer_of     :ATTR(:name<deserializer>   :default<()>);
my %serializer_of       :ATTR(:name<serializer>     :default<()>);
my %soap_version_of     :ATTR(:name<soap_veraion>   :default<1.1>);

sub handle {
    my $self    = shift;
    my $request = shift; # this involves copying the request... once
    my $ident   = ident $self;


    # we only support 1.1 now...
    $deserializer_of{ $ident } ||= SOAP::WSDL::Factory::Deserializer->get_deserializer({
        soap_version => $soap_version_of{ $ident },
    });
    $serializer_of{ $ident } ||= SOAP::WSDL::Factory::Serializer->get_serializer({
        soap_version => $soap_version_of{ $ident },
    });

    # lookup method name by SOAPAction
    # TODO: factor out dispatcher logic into dispatcher factory + dispatcher
    # classes
    #    $dispatcher_of{ $ident } ||= SOAP::WSDL::Factory::Dispatcher->get_dispatcher({});

    my $soap_action = $request->header('SOAPAction');
    $soap_action = '' if ! defined $soap_action;
    $soap_action =~s{ \A(?:"|')(.+)(?:"|') \z }{$1}xms;
    my $method_name = $action_map_ref_of{ $ident }->{ $soap_action };

    if ( ! $dispatch_to_of{ $ident } ) {
        die $deserializer_of{ $ident }->generate_fault({
                code => 'SOAP-ENV:Server',
                role => 'urn:localhost',
                message => "No handler registered",
            });
    };

    if ( ! defined $request->header('SOAPAction') ) {
        die $deserializer_of{ $ident }->generate_fault({
                code => 'SOAP-ENV:Server',
                role => 'urn:localhost',
                message => "Not found: No SOAPAction given",
            });
    };

    if ( ! defined $method_name) {
        die $deserializer_of{ $ident }->generate_fault({
                code => 'SOAP-ENV:Server',
                role => 'urn:localhost',
                message => "Not found: No method found for the SOAPAction '$soap_action'",
            });
    };

    # initialize deserializer from caller
    if ( $method_map_ref_of{$ident} && $deserializer_of{ $ident }->can('init_from_caller') ) {
        $deserializer_of{ $ident }->init_from_caller(
            $self, $method_map_ref_of{ $ident }->{ $method_name }
        );
    }
    else {
        # for compatibility only
        $deserializer_of{ $ident }->set_class_resolver( $class_resolver_of{ $ident } )
            if ( $deserializer_of{ $ident }->can('set_class_resolver') );

        $deserializer_of{ $ident }->set_body_parts(
            $method_map_ref_of{ $ident }->{ $method_name }->{ body }->{ parts }
        ) if ( $deserializer_of{ $ident }->can('set_body_parts') );

        $deserializer_of{ $ident }->set_header_parts(
            $method_map_ref_of{ $ident }->{ $method_name }->{ header }->{ parts }
        ) if ( $deserializer_of{ $ident }->can('set_header_parts') );
    }

    # Try deserializing response
    my ($body, $header) = eval {
       $deserializer_of{ $ident }->deserialize( $request->content() );
    };
    if ($@) {
        die $deserializer_of{ $ident }->generate_fault({
                code => 'soap:Server',
                role => 'urn:localhost',
                message => "Error deserializing message: $@. \n"
            });
    };
    if ( blessed($body) && $body->isa('SOAP::WSDL::SOAP::Typelib::Fault11') ) {
        die $body;
    }

#    $dispatcher_of{ $ident }->dispatch({
#        soap_action => $soap_action,
#        request_body => $body,
#        request_header => $header,
#    });

    # find method in handling class/object
    my $method_ref = $dispatch_to_of{ $ident }->can($method_name);

    if ( ! $method_ref) {
        die $deserializer_of{ $ident }->generate_fault({
                code => 'SOAP-ENV:Server',
                role => 'urn:localhost',
                message => "Not implemented: The handler does not implement the method $method_name",
            });
    };

    my ($response_body, $response_header) = $method_ref->($dispatch_to_of{ $ident }, $body, $header );

    return $serializer_of{ $ident }->serialize({
        body   => $response_body,
        header => $response_header,
    });
}

1;

=pod

=head1 NAME

SOAP::WSDL::Server - WSDL based SOAP server base class

=head1 SYNOPSIS

Don't use directly, use the SOAP::WSDL::Server::* subclasses
instead.

=head1 DESCRIPTION

SOAP::WSDL::Server basically follows the architecture sketched below
(though dispatcher classes are not implemented yet)

 SOAP Request           SOAP Response
       |                     ^
       V                     |
  ------------------------------------------
 |       SOAP::WSDL::Server                 |
 |  --------------------------------------  |
 | | Transport Class                      | |
 | |--------------------------------------| |
 | | Deserializer       | Serializer      | |
 | |--------------------------------------| |
 | | Dispatcher                           | |
 |  --------------------------------------  |
  ------------------------------------------
      | calls                 ^
      v                       | returns
   -------------------------------------
  |   Handler                           |
   -------------------------------------

All of the components (Transport class, deserializer, dispatcher and
serializer) are implemented as plugins.

The architecture is not implemented as planned yet, but the dispatcher is
currently part of SOAP::WSDL::Server, which aggregates serializer and
deserializer, and is subclassed by transport classes (of which
SOAP::WSDL::Server::CGI is the only implemented one yet).

The dispatcher is currently based on the SOAPAction header. This does not
comply to the WS-I basic profile, which declares the SOAPAction as optional.

The final dispatcher will be based on wire signatures (i.e. the classes
of the deserialized messages).

A hash-based dispatcher could be implemented by examining the top level
hash keys.

=head1 EXCEPTION HANDLING

=head2 Builtin exceptions

SOAP::WSDL::Server handles the following errors itself:

In case of errors, a SOAP Fault containing an appropriate error message
is returned.

=over

=item * XML parsing errors

=item * Configuration errors

=back

=head2 Throwing exceptions

The proper way to throw a exception is just to die -
SOAP::WSDL::Server::CGI catches the exception and sends a SOAP Fault
back to the client.

If you want more control over the SOAP Fault sent to the client, you can
die with a SOAP::WSDL::SOAP::Fault11 object - or just let the
SOAP::Server's deserializer create one for you:

 my $soap = MyServer::SomeService->new();

 die $soap->get_deserializer()->generate_fault({
    code => 'SOAP-ENV:Server',
    role => 'urn:localhost',
    message => "The error message to pas back",
    detail => "Some details on the error",
 });

You may use any other object as exception, provided it has a
serialize() method which returns the object's XML representation.

=head2 Subclassing

To write a transport-specific SOAP Server, you should subclass
SOAP::WSDL::Server.

See the C<SOAP::WSDL::Server::*> modules for examples.

A SOAP Server must call the following method to actually handle the request:

=head3 handle

Handles the SOAP request.

Returns the response message as XML.

Expects a C<HTTP::Request> object as only parameter.

You may use any other object as parameter, as long as it implements the
following methods:

=over

=item * header

Called as header('SOAPAction'). Must return the corresponding HTTP header.

=item * content

Returns the request message

=back

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
