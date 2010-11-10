package SOAP::WSDL::Deserializer::Hash;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use SOAP::WSDL::SOAP::Typelib::Fault11;
use SOAP::WSDL::Expat::Message2Hash;

use SOAP::WSDL::Factory::Deserializer;
SOAP::WSDL::Factory::Deserializer->register( '1.1', __PACKAGE__ );

use version; our $VERSION = qv('2.00.99_3');

sub BUILD {
    my ($self, $ident, $args_of_ref) = @_;

    # ignore all options
    for (keys %{ $args_of_ref }) {
        delete $args_of_ref->{ $_ }
    }
}

sub deserialize {
    my ($self, $content) = @_;

    my $parser = SOAP::WSDL::Expat::Message2Hash->new();
    eval { $parser->parse_string( $content ) };
    if ($@) {
        die $self->generate_fault({
            code => 'soap:Server',
            role => 'urn:localhost',
            message => "Error deserializing message: $@. \n"
                . "Message was: \n$content"
        });
    }
    return $parser->get_data();
}

sub generate_fault {
    my ($self, $args_from_ref) = @_;
    return SOAP::WSDL::SOAP::Typelib::Fault11->new({
            faultcode => $args_from_ref->{ code } || 'SOAP-ENV:Client',
            faultactor => $args_from_ref->{ role } || 'urn:localhost',
            faultstring => $args_from_ref->{ message } || "Unknown error"
    });
}

1;

=head1 NAME

SOAP::WSDL::Deserializer::Hash - Deserializer SOAP messages into perl hash refs

=head1 SYNOPSIS

 use SOAP::WSDL;
 use SOAP::WSDL::Deserializer::Hash;

=head1 DESCRIPTION

Deserializer for creating perl hash refs as result of a SOAP call.

=head2 Output structure

The XML structure is converted into a perl data structure consisting of
hash and or list references. List references are used for holding array data.

SOAP::WSDL::Deserializer::Hash creates list references always at the maximum
depth possible.

Examples:

 XML:
 <MyDataArray>
    <MyData>1</MyData>
    <MyData>1</MyData>
 </MyDataArray>

 Perl:
 {
     MyDataArray => {
         MyData => [ 1, 1 ]
     }
 }

 XML:
 <DeepArray>
    <MyData><int>1<int>/MyData>
    <MyData><int>1<int>/MyData>
 </DeepArray>

 Perl:
 {
     MyDataArray => {
         MyData => [
            { int => 1 },
            { int => 1 }
         ]
     }
 }

List reference creation is triggered by the second occurance of an element.
XML Array types with one element only will not be represented as list
references.

=head1 USAGE

All you need to do is to use SOAP::WSDL::Deserializer::Hash.

SOAP::WSDL::Deserializer::Hash autoregisters itself for SOAP1.1 messages

You may register SOAP::WSDLDeserializer::Hash for other SOAP Versions by
calling

 SOAP::Factory::Deserializer->register('1.2',
    SOAP::WSDL::Deserializer::Hash)

=head1 Limitations

=over

=item * Namespaces

All namespaces are ignored.

=item * XML attributes

All XML attributes are ignored.

=back

=head2 Differences from other SOAP::WSDL::Deserializer classes

=over

=item * generate_fault

SOAP::WSDL::Deserializer::Hash will die with a SOAP::WSDL::Fault11 object when
a parse error appears

=back

=head1 METHODS

=head2 deserialize

Deserializes the message.

=head2 generate_fault

Generates a L<SOAP::WSDL::SOAP::Typelib::Fault11|SOAP::WSDL::SOAP::Typelib::Fault11>
object and returns it.

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2008 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself.

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 861 $
 $LastChangedBy: kutterma $
 $Id: Hash.pm 861 2010-03-28 10:41:26Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Deserializer/Hash.pm $

=cut
