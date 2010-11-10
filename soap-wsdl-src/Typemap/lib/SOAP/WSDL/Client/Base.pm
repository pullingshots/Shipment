package SOAP::WSDL::Client::Base;
use strict;
use warnings;
use base 'SOAP::WSDL::Client';
use Scalar::Util qw(blessed);

use version; our $VERSION = qv('2.00.99_3');

sub call {
    my ($self, $method, $body, $header) = @_;

    # Treat non-objects special
    if (not blessed $body) {

        # make sure there's something sensible in our body data
        $body = {} if not defined $body;
        $body = ref $body eq 'ARRAY' ? $body : [ $body ];

        my @body_from = @{ $body }; # make a copy

        # build list of parts as objects initialized with
        # parameters given
        my @part_from = ();
        foreach my $class (@{ $method->{ body }->{ parts } }) {
            eval "require $class" || die $@;    ## no critic (ProhibitStringyEval)
            push @part_from, $class->new(shift(@body_from) || {});
        }

        # it's either the first part or a list ref with all parts...
        $body = $#part_from ? \@part_from : $part_from[0];
    }

    # if we have a header
    if (%{ $method->{ header } }) {

        # treat non object special - as above, but only for one
        if (not blessed $header) {
            my $class = $method->{ header }->{ parts }->[0];
            eval "require $class" || die $@;    ## no critic (ProhibitStringyEval)
            $header = $class->new($header);
        }
    }
    return $self->SUPER::call($method, $body, $header);
}

1;

__END__

=pod

=head1 NAME

SOAP::WSDL::Client::Base - Factory class for WSDL-based SOAP access

=head1 SYNOPSIS

 package MySoapInterface;
 use SOAP::WSDL::Client::Base;
 __PACKAGE__->__create_methods( qw(one two three) );
 1;

=head1 DESCRIPTION

Factory class for creating interface classes. Should probably be renamed to
SOAP::WSDL::Factory::Interface...

=head1 METHODS

=head2 call

Abstraction layer method between the generated interfaces and
L<SOAP::WSDL::Client|SOAP::WSDL::Client>.

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under the same
terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 861 $
 $LastChangedBy: kutterma $
 $Id: Base.pm 861 2010-03-28 10:41:26Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Client/Base.pm $

=cut
