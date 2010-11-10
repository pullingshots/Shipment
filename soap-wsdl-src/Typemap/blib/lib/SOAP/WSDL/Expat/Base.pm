package SOAP::WSDL::Expat::Base;
use strict;
use warnings;
use URI;
use XML::Parser::Expat;

# TODO: convert to Class::Std::Fast based class - hash based classes suck.

use version; our $VERSION = qv('2.00.99_3');

sub new {
    my ($class, $arg_ref) = @_;
    my $self = {
        data => undef,
    };
    bless $self, $class;

    $self->set_user_agent($arg_ref->{ user_agent })
        if $arg_ref->{ user_agent };
    $self->{ parsed } = $arg_ref->{ parsed } if $arg_ref->{ parsed };

    return $self;
}

sub clone {
    my $self = shift;
    my $class = ref $self;
    my $clone = $class->new($self);
    return $clone;
}

sub set_uri { $_[0]->{ uri } = $_[1]; }
sub get_uri { return $_[0]->{ uri }; }

sub set_user_agent { $_[0]->{ user_agent } = $_[1]; }
sub get_user_agent { return $_[0]->{ user_agent }; }

# Mark a URI as "already parsed"
sub set_parsed {
    my ($self, $uri) = @_;
    $self->{ parsed }->{ $uri } = 1;
    return;
}


# returns true if a specific URI has already been parsed
sub is_parsed {
    my ($self, $uri) = @_;
    return exists $self->{ parsed }->{ $uri };
}


# parse a URI. This is the preferred parsing method for WSDL files, as it's
# the only one allowing automatic import resolution
sub parse_uri {
    my $self = shift;
    my $uri = shift;

    if ($self->is_parsed($uri)){
        warn "$uri already imported; ignoring it.\n";
        return;
    }
    $self->set_parsed($uri);

    $self->set_uri( $uri );

    if (not $self->{ user_agent }) {
        require LWP::UserAgent;
        $self->{ user_agent } = LWP::UserAgent->new();
    }

    my $response = $self->{ user_agent }->get($uri);
    die $response->message() if $response->code() ne '200';
    return $self->parse( $response->content() );
}

sub parse {
    eval {
        $_[0]->_initialize( XML::Parser::Expat->new( Namespaces => 1 )  )->parse( $_[1] );
        $_[0]->{ parser }->release();
    };
    $_[0]->{ parser }->xpcroak( $@ ) if $@;
    delete $_[0]->{ parser };
    return $_[0]->{ data };
}

sub parsefile {
    eval {
        $_[0]->_initialize( XML::Parser::Expat->new(Namespaces => 1) )->parsefile( $_[1] );
        $_[0]->{ parser }->release();
    };
    $_[0]->{ parser }->xpcroak( $@ ) if $@;
    delete $_[0]->{ parser };
    return $_[0]->{ data };
}

# SAX-like aliases
sub parse_string;
*parse_string = \&parse;

sub parse_file;
*parse_file = \&parsefile;

sub get_data {
    return $_[0]->{ data };
}

1;

=pod

=head1 NAME

SOAP::WSDL::Expat::Base - Base class for XML::Parser::Expat based XML parsers

=head1 DESCRIPTION

Base class for XML::Parser::Expat based XML parsers. All XML::SAX::Expat based
parsers in SOAP::WSDL inherit from this class.

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
