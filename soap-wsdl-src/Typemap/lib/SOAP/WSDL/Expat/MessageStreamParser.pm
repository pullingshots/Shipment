#!/usr/bin/perl
package SOAP::WSDL::Expat::MessageStreamParser;
use strict;
use warnings;
use XML::Parser::Expat;
use SOAP::WSDL::Expat::MessageParser;
use base qw(SOAP::WSDL::Expat::MessageParser);

use version; our $VERSION = qv('2.00.99_3');

sub parse_start {
    my $self = shift;
    $self->{ parser } = $_[0]->_initialize( XML::Parser::ExpatNB->new( Namespaces => 1 ) );
}
sub init;
*init = \&parse_start;

sub parse_more {
    $_[0]->{ parser }->parse_more( $_[1] );
}

sub parse_done {
    $_[0]->{ parser }->parse_done();
    $_[0]->{ parser }->release();
}

1;

=pod

=head1 NAME

SOAP::WSDL::Expat::MessageStreamParser - Convert SOAP messages to custom object trees

=head1 SYNOPSIS

 my $lwp = LWP::UserAgent->new();

 my $parser = SOAP::WSDL::Expat::MessageParser->new({
    class_resolver => 'My::Resolver'
 });
 my $chunk_parser = $parser->init();
 # process response while it comes in, trying to read 32k chunks.
 $lwp->request( $request, sub { $chunk_parser->parse_more($_[0]) } , 32468 );
 $chunk_parser->parse_done();

 my $obj = $parser->get_data();

=head1 DESCRIPTION

ExpatNB based parser for parsing huge documents.

See L<SOAP::WSDL::Manual::Parser> for details.

=head1 Bugs and Limitations

See SOAP::WSDL::Expat::MessageParser

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright 2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 REPOSITORY INFORMATION

 $Rev: 861 $
 $LastChangedBy: kutterma $
 $Id: MessageStreamParser.pm 861 2010-03-28 10:41:26Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Expat/MessageStreamParser.pm $

=cut
