package SOAP::WSDL::Factory::Deserializer;
use strict;
use warnings;

use version; our $VERSION = qv('2.00.99_3');

my %DESERIALIZER = (
    '1.1' => 'SOAP::WSDL::Deserializer::XSD',
);

# class method
sub register {
    my ($class, $ref_type, $package) = @_;
    $DESERIALIZER{ $ref_type } = $package;
}

sub get_deserializer {
    my ($self, $args_of_ref) = @_;
    $args_of_ref->{ soap_version } ||= '1.1';
    # sanity check
    die "no deserializer registered for SOAP version $args_of_ref->{ soap_version }"
        if not exists ($DESERIALIZER{ $args_of_ref->{ soap_version } });

    # load module
    eval "require $DESERIALIZER{ $args_of_ref->{ soap_version } }"
        or die "Cannot load serializer $DESERIALIZER{ $args_of_ref->{ soap_version } }", $@;

    return $DESERIALIZER{ $args_of_ref->{ soap_version } }->new($args_of_ref);
}

1;

=pod

=head1 NAME

SOAP::WSDL::Factory::Deserializer - Factory for retrieving Deserializer objects

=head1 SYNOPSIS

 # from SOAP::WSDL::Client:
 $deserializer = SOAP::WSDL::Factory::Deserializer->get_deserializer({
     soap_version => $soap_version,
     class_resolver => $class_resolver,
 });

 # in deserializer class:
 package MyWickedDeserializer;
 use SOAP::WSDL::Factory::Deserializer;

 # register class as deserializer for SOAP1.2 messages
 SOAP::WSDL::Factory::Deserializer->register( '1.2' , __PACKAGE__ );

=head1 DESCRIPTION

SOAP::WSDL::Factory::Deserializer serves as factory for retrieving
deserializer objects for SOAP::WSDL.

The actual work is done by specific deserializer classes.

SOAP::WSDL::Deserializer tries to load one of the following classes:

=over

=item * The class registered for the scheme via register()

=back

By default, L<SOAP::WSDL::Deserializer::XSD|SOAP::WSDL::Deserializer::XSD>
is registered for SOAP1.1 messages.

=head1 METHODS

=head2 register

 SOAP::WSDL::Deserializer->register('1.1', 'MyWickedDeserializer');

Globally registers a class for use as deserializer class.

=head2 get_deserializer

Returns an object of the deserializer class for this endpoint.

=head1 WRITING YOUR OWN DESERIALIZER CLASS

Deserializer classes may register with SOAP::WSDL::Factory::Deserializer.

=head2 Registering a deserializer

Registering a deserializer class with SOAP::WSDL::Factory::Deserializer
is done by executing the following code where $version is the SOAP version
the class should be used for, and $class is the class name.

 SOAP::WSDL::Factory::Deserializer->register( $version, $class);

To auto-register your transport class on loading, execute register()
in your tranport class (see L<SYNOPSIS|SYNOPSIS> above).

=head2 Deserializer package layout

Deserializer modules must be named equal to the deserializer class they
contain. There can only be one deserializer class per deserializer module.

=head2 Methods to implement

Deserializer classes must implement the following methods:

=over

=item * new

Constructor.

=item * deserialize

Deserialize data from XML to arbitrary formats.

deserialize() must return a fault indicating that deserializing failed if
any error is encountered during the process of deserializing the XML message.

The following positional parameters are passed to the deserialize method:

 $content   - the xml message

=item * generate_fault

Generate a fault in the supported format. The following named parameters are
passed as a single hash ref:

 code       - The fault code, e.g. 'soap:Server' or the like
 role       - The fault role (actor in SOAP1.1)
 message    - The fault message (faultstring in SOAP1.1)

=item * init_from_caller (optional)

This method is called from the caller (usually a SOAP::WSDL::Client or a 
SOAP::WSDL::Server subclass) and allows the deserializer to initialize itself.

It is currently called with the following parameters: 

 $caller - the calling object
 $method - a method info hash ref, containing the parts and stuff of the
           SOAP method invoked.

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2007 Martin Kutter. All rights reserved.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 176 $
 $LastChangedBy: kutterma $
 $Id: Serializer.pm 176 2007-08-31 15:28:29Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Factory/Serializer.pm $

=cut
