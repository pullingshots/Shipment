package SOAP::WSDL::Deserializer::SOM;
use strict;
use warnings;

use version; our $VERSION = qv('2.00.99_3');
our @ISA;

eval {
    require SOAP::Lite;
    push @ISA, 'SOAP::Deserializer';
}
or die "Cannot load SOAP::Lite.
Cannot deserialize to SOM object without SOAP::Lite.
Please install SOAP::Lite.";

sub deserialize {
    my $self = shift;
    my $result = eval { $self->SUPER::deserialize(@_) };
    if ($@) {
        return SOAP::Fault->new(
            faultactor => 'SOAP-ENV:Server',
            faultstring => $@,
        );
    }
    return $result;
}

sub generate_fault {
    my ($self, $args_from_ref) = @_;
    # code, message, detail, actor
    die SOAP::Fault->new(
        faultcode => $args_from_ref->{ code },
        faultstring => $args_from_ref->{ message },
        faultactor => $args_from_ref->{ role },
    );
}

1;

__END__

=head1 NAME

SOAP::WSDL::Deserializer::SOM - Deserializer SOAP messages into SOM objects

=head1 SYNOPSIS

 use SOAP::WSDL;
 use SOAP::WSDL::Deserializer::SOM;
 use SOAP::WSDL::Factory::Deserializer;
 SOAP::WSDL::Factory::Deserializer->register( '1.1', __PACKAGE__ );

=head1 DESCRIPTION

Deserializer for creating SOAP::Lite's SOM object as result of a SOAP call.

This package is here for two reasons:

=over

=item * Compatibility

You don't have to change the rest of your SOAP::Lite based app when switching
to SOAP::WSDL, but can just use SOAP::WSDL::Deserializer::SOM to get back the
same objects as you were used to.

=item * Completeness

SOAP::Lite covers much more of the SOAP specification than SOAP::WSDL.

SOAP::WSDL::Deserializer::SOM can be used for content which cannot be
deserialized by L<SOAP::WSDL::Deserializer::SOAP11|SOAP::WSDL::Deserializer::SOAP11>.
This may be XML including mixed content, attachements and other XML data not
(yet) handled by L<SOAP::WSDL::Deserializer::SOAP11|SOAP::WSDL::Deserializer::SOAP11>.

=back

SOAP::WSDL::Deserializer::SOM is a subclass of L<SOAP::Deserializer|SOAP::Deserializer>
from the L<SOAP::Lite|SOAP::Lite> package.

=head1 METHODS

=head2 deserialize

Deserializes a XML sting into a SOAP::SOM object. Returns a SOAP::Fault object
on deserialization errors.

=head2 generate_fault

Dies with a SOAP::Fault object.

=head1 USAGE

SOAP::WSDL::Deserializer will not autoregister itself - to use it for a particular
SOAP version just use the following lines:

 my $soap_version = '1.1'; # or '1.2', further versions may appear.

 use SOAP::WSDL::Deserializer::SOM;
 use SOAP::WSDL::Factory::Deserializer;
 SOAP::WSDL::Factory::Deserializer->register( $soap_version, __PACKAGE__ );

=head1 DIFFERENCES FROM OTHER CLASSES

=head2 Differences from SOAP::Lite

=over

=item * No on_fault handler

You cannot specify what to do when an error occurs - SOAP::WSDL will return
a SOAP::Fault object on transport errors.

=back

=head2 Differences from other SOAP::WSDL::Deserializer classes

=over

=item * generate_fault

SOAP::WSDL::Deserializer::SOM will die with a SOAP::Fault object on calls
to generate_fault.

This also means that a SOAP::Fault may be thrown as exception when using


=back

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself.

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 861 $
 $LastChangedBy: kutterma $
 $Id: SOM.pm 861 2010-03-28 10:41:26Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Deserializer/SOM.pm $

=cut
