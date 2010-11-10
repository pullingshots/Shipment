package SOAP::WSDL::Factory::Serializer;
use strict;
use warnings;

use version; our $VERSION = qv('2.00.99_3');

my %SERIALIZER = (
    '1.1' => 'SOAP::WSDL::Serializer::XSD',
);

# class method
sub register {
    my ($class, $ref_type, $package) = @_;
    $SERIALIZER{ $ref_type } = $package;
}

sub get_serializer {
    my ($self, $args_of_ref) = @_;
    $args_of_ref->{ soap_version } ||= '1.1';
    # sanity check
    die "no serializer registered for SOAP version $args_of_ref->{ soap_version }"
        if not exists ($SERIALIZER{ $args_of_ref->{ soap_version } });

    # load module
    eval "require $SERIALIZER{ $args_of_ref->{ soap_version } }"
        or die "Cannot load serializer $SERIALIZER{ $args_of_ref->{ soap_version } }", $@;

    return $SERIALIZER{ $args_of_ref->{ soap_version } }->new();
}

1;

=pod

=head1 NAME

SOAP::WSDL::Factory::Serializer - Factory for retrieving serializer objects

=head1 SYNOPSIS

 # from SOAP::WSDL::Client:
 $serializer = SOAP::WSDL::Factory::Serializer->get_serializer({
     soap_version => $soap_version,
 });

 # in serializer class:
 package MyWickedSerializer;
 use SOAP::WSDL::Factory::Serializer;

 # register as serializer for SOAP1.2 messages
 SOAP::WSDL::Factory::Serializer->register( '1.2' , __PACKAGE__ );

=head1 DESCRIPTION

SOAP::WSDL::Factory::Serializer serves as factory for retrieving
serializer objects for SOAP::WSDL.

The actual work is done by specific serializer classes.

SOAP::WSDL::Serializer tries to load one of the following classes:

=over

=item * the class registered for the scheme via register()

=back

=head1 METHODS

=head2 register

 SOAP::WSDL::Serializer->register('1.1', 'MyWickedSerializer');

Globally registers a class for use as serializer class.

=head2 get_serializer

Returns an object of the serializer class for this endpoint.

=head1 WRITING YOUR OWN SERIALIZER CLASS

=head2 Registering a deserializer

Serializer classes may register with SOAP::WSDL::Factory::Serializer.

Serializer objects may also be passed directly to SOAP::WSDL::Client by
using the set_serializer method. Note that serializers objects set via
SOAP::WSDL::Client's set_serializer method are discarded when the SOAP
version is changed via set_soap_version.

Registering a serializer class with SOAP::WSDL::Factory::Serializer is done
by executing the following code where $version is the SOAP version the
class should be used for, and $class is the class name.

 SOAP::WSDL::Factory::Serializer->register( $version, $class);

To auto-register your transport class on loading, execute register() in
your tranport class (see L</SYNOPSIS> above).

=head2 Serializer package layout

Serializer modules must be named equal to the serializer class they contain.
There can only be one serializer class per serializer module.

=head2 Methods to implement

Serializer classes must implement the following methods:

=over

=item * new

Constructor.

=item * serialize

Serializes data to XML. The following named parameters are passed to the
serialize method in a anonymous hash ref:

 {
   method => $operation_name,
   header => $header_data,
   body => $body_data,
 }

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2007 Martin Kutter. All rights reserved.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself.

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 861 $
 $LastChangedBy: kutterma $
 $Id: Serializer.pm 861 2010-03-28 10:41:26Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Factory/Serializer.pm $

=cut
