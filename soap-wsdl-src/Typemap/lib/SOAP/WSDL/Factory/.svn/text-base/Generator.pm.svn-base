package SOAP::WSDL::Factory::Generator;
use strict;
use warnings;

use version; our $VERSION = qv('2.00.99_3');

my %GENERATOR = (
    'XSD' => 'SOAP::WSDL::Generator::Template::XSD',
);

# class method
sub register {
    my ($class, $ref_type, $package) = @_;
    $GENERATOR{ $ref_type } = $package;
}

sub get_generator {
    my ($self, $args_of_ref) = @_;

    # sanity check
#    die "no generator registered for generation method $args_of_ref->{ type }"
#
    my $generator_class = (exists ($GENERATOR{ $args_of_ref->{ type } }))
        ? $GENERATOR{ $args_of_ref->{ type } }
        : $args_of_ref->{ type };

    # load module
    eval "require $generator_class"
        or die "Cannot load generator $generator_class", $@;

    return $generator_class->new();
}

1;

=pod

=head1 NAME

SOAP::WSDL::Factory:Generator - Factory for retrieving generator objects

=head1 SYNOPSIS

 # from SOAP::WSDL::Client:
 $generator = SOAP::WSDL::Factory::Generator->get_generator({
     soap_version => $soap_version,
 });

 # in generator class:
 package MyWickedGenerator;
 use SOAP::WSDL::Factory::Generator;

 # register as generator for SOAP1.2 messages
 SOAP::WSDL::Factory::Generator->register( '1.2' , __PACKAGE__ );

=head1 DESCRIPTION

SOAP::WSDL::Factory::Generator serves as factory for retrieving
generator objects for SOAP::WSDL.

The actual work is done by specific generator classes.

SOAP::WSDL::Generator tries to load one of the following classes:

=over

=item * the class registered for the scheme via register()

=back

=head1 METHODS

=head2 register

 SOAP::WSDL::Generator->register('Lite', 'MyWickedGenerator');

Globally registers a class for use as generator class.

=head2 get_generator

Returns an object of the generator class for this endpoint.

=head1 WRITING YOUR OWN GENERATOR CLASS

=head2 Registering a generator

Generator classes may register with SOAP::WSDL::Factory::Generator.

Registering a generator class with SOAP::WSDL::Factory::Generator is done
by executing the following code where $version is the SOAP version the
class should be used for, and $class is the class name.

 SOAP::WSDL::Factory::Generator->register( $version, $class);

To auto-register your transport class on loading, execute register() in
your generator class (see L<SYNOPSIS|SYNOPSIS> above).

=head2 Generator package layout

Generator modules must be named equal to the generator class they contain.
There can only be one generator class per generator module.

=head2 Methods to implement

Generator classes must implement the following methods:

=over

=item * new

Constructor.

=item * generate

Generate SOAP interface

=back

Generators may implements one or more of the following configuration
methods. All of them are tried via can() by wsdl2perl.

=over

=item * set_wsdl

Set the raw WSDL XML. Implement if you have your own WSDL parser.

=item * set_definitions

Sets the (parsed) SOAP::WSDL::Definitions object.

=item * set_type_prefix

Sets the prefix for XML Schema type classes

=item * set_element_prefix

Sets the prefix for XML Schema element classes

=item * set_typemap_prefix

Sets the prefix for typemap classes (class resolvers).

=item * set_interface_prefix

Sets the prefix for interface classes

=item * set_typemap

Set user-defined typemap snippet

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
