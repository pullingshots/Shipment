#!/usr/bin/perl
package SOAP::WSDL::Expat::Message2Hash;
use strict;
use warnings;
use base qw(SOAP::WSDL::Expat::Base);

use version; our $VERSION = qv('2.00.99_3');

sub _initialize {
    my ($self, $parser) = @_;
    $self->{ parser } = $parser;
    delete $self->{ data };             # remove potential old results

    my $characters;
    my $current = {};
    my $list = [];                      # node list
    my $current_part = q{};             # are we in header or body ?
    $self->{ data } = $current;

    # use "globals" for speed
    my ($_element, $_method,
        $_class, $_parser, %_attrs) = ();

    # no strict qw(refs);
    $parser->setHandlers(
        Start => sub {
            push @$list, $current;
           #If our element exists and is a list ref, add to it
            if ( exists $current->{ $_[1] }
              && ( ref ($current->{ $_[1] }) eq 'ARRAY')
            )  {
                push @{ $current->{ $_[1] } }, {};
                $current = $current->{ $_[1] }->[-1];
            }
            elsif ( exists $current->{ $_[1] } )
            {
                $current->{ $_[1] } = [ $current->{ $_[1] }, {} ];
                $current = $current->{ $_[1] }->[-1];
            }
            else {
                $current->{ $_[1] } = {};
                $current = $current->{ $_[1] };
            }
            return;
        },

        Char => sub {
            $characters .= $_[1] if $_[1] !~m{ \A \s* \z}xms;
            return;
        },

        End => sub {
            $_element = $_[1];

            # This one easily handles ignores for us, too...
            # return if not ref $$list[-1];

            if (length $characters) {
                if (ref $list->[-1]->{ $_element } eq 'ARRAY') {
                    $list->[-1]->{ $_element }->[-1] = $characters ;
                }
                else {
                    $list->[-1]->{ $_element } = $characters;
                }
            }
            $characters = q{};
            $current = pop @$list;           # step up in object hierarchy...
            return;
        }
    );
    return $parser;
}

1;

=pod

=head1 NAME

SOAP::WSDL::Expat::Message2Hash - Convert SOAP messages to perl hash refs

=head1 SYNOPSIS

 my $parser = SOAP::WSDL::Expat::MessageParser->new({
    class_resolver => 'My::Resolver'
 });
 $parser->parse( $xml );
 my $obj = $parser->get_data();

=head1 DESCRIPTION

Real fast expat based SOAP message parser.

See L<SOAP::WSDL::Manual::Parser> for details.

=head1 Bugs and Limitations

=over

=item * Ignores all namespaces

=item * Ignores all attributes

=item * Does not handle mixed content

=item * The SOAP header is ignored

=back

=head1 AUTHOR

Replace the whitespace by @ for E-Mail Address.

 Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 Repository information

 $Id: $

 $LastChangedDate: 2007-09-10 18:19:23 +0200 (Mo, 10 Sep 2007) $
 $LastChangedRevision: 218 $
 $LastChangedBy: kutterma $

 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Expat/MessageParser.pm $

