#!/usr/bin/perl
package SOAP::WSDL::Expat::MessageSubParser;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin;
use XML::Parser::Expat;

sub new {
    my ($class, $args) = @_;
    my $self = {};
    bless $self, $class;
    return $self;
}

# create handlers via currying - XML::Compiled is a good teacher...
#
# A handler has to know
# - the order of it's child elements
# - the classes for these child elements
# - the handlers for these child elements (sub refs)

# order is checked if provided

sub start_tag {
    my $self = shift;
    my $arg_ref = shift;
       
    my $CHILD_ORDER = $arg_ref->{ order } || [];
    my $CHILD_CLASS = $arg_ref->{ class_of } || {};
    my $CHILD_HANDLER = $arg_ref->{ handler_of };
    my $CHILD_OCCURS = $arg_ref->{ occurs_of } || {};
    
    my $CHILD_INDEX = 0;

   
    return sub {
        # parser, element, attrs
        my ($prefix, $localname) = split m{:}xms , $_[1];
        $localname ||= $_[1];

=pod

#       # implement better checks...
#        if (@{ $CHILD_ORDER }) {
#            if ($CHILD_ORDER->[$CHILD_INDEX] ne $localname) {
#                if (! $CHILD_ORDER->[++$CHILD_INDEX] 
#                    ||  $CHILD_ORDER->[$CHILD_INDEX] ne $localname) {
#                die "misplaced xml element " . $parser->recognized_string() 
#                    . " at line "
#                    . $parser->current_line()
#                    . " column " . $parser->current_column() , "\n"
#                    , "Element order: " . join(',' , @{ $CHILD_ORDER }), "\n"
#                    }                        
#            }
#        }
#
#        if (%{ $CHILD_OCCURS }) {
#            die "too many occurances of $localname at line "
#                    . $parser->current_line()
#                    . " column " . $parser->current_column() , "\n"
#                if (not --$CHILD_OCCURS->{ $localname }->{ max });
#
#            # min must be checked in end_element !
#            $CHILD_OCCURS->{ $localname }->{ min }-- 
#                if ($CHILD_OCCURS->{ $localname }->{ min }); 
#        }

=cut

        # remove this some day
        return if ($localname eq 'Envelope');
        return if ($localname eq 'Body');
    
        # step down in tree (remember current)
        push @{ $self->{ list } }, $self->{ current };              
        $self->{ current } = $CHILD_CLASS->{ $localname }->new({ @_[2..$#_] });
            
        # Set (and remember) next state
        push @{ $self->{ handlers } }, $CHILD_HANDLER->{ $localname };
        $_[0]->setHandlers( %{ $CHILD_HANDLER->{ $localname } } ); 
    };
}

# characters is a good candidate for replacement when not needed -  
# expat calls it for those whitespaces in non-mixed-content-elements, too
sub characters {
    my $self = shift;    
    return sub { $self->{ characters } .= $_[1] };
}

# end_tag is a somewhat generic thingy - don't know whether we should 
# curry it, and whether this will speed us up...
sub end_tag {
    my $self = shift;

    return sub {
        # step down handler hierarchy
        pop @{ $self->{ handlers } };

        # restore state: set handler to last handler
        $_[0]->setHandlers( %{ $self->{ handlers }->[ -1 ] } );

        my ($prefix, $localname) = split m{:}xms , $_[1];          
        $localname ||= $_[1];          # for non-prefixed elements            

        # we only have characters if we need them - if not Char handler 
        # has to be set to undef       
        $self->{ current }->set_value( $self->{ characters } ) 
            if ($self->{ characters });
        
        # empty temp characters
        undef $self->{ characters };

        # return if we're top node
        # This one easily handles ignores for us, too...
        #
        # Hmm... could be replaced by something else, maybe ???
        # Maybe by defining an empty end_tag handler for the top node ?
        # Can we do this ???
        return if not defined $self->{ list }->[-1];

        # set appropriate attribute in last element
        # multiple values must be implemented in base class
        my $method = "add_$localname";
        $self->{ list }->[-1]->$method( $self->{ current } );

        # step up in object hierarchy...
        $self->{ current } = pop @{ $self->{ list } };                
    };
}

sub end_top_tag {
    my $self = shift;
    return sub {};   
}

sub initialize {   
    my ($self, $handler_of_ref, $parser ) = @_;
    $parser ||= XML::Parser::Expat->new();
    $self->{ list } = undef;   
    $self->{ current } = undef;
    $self->{ characters } = q{};      # empty characters
    $self->{ handlers } = [ $handler_of_ref ];
    $parser->setHandlers( %$handler_of_ref );
    return $parser;
}

sub get_data {
    return $_[0]->{ current };
}

1;

=pod

=head1 NAME

SOAP::WSDL::Expat::MessageParser - Convert SOAP messages to custom object trees

=head1 SYNOPSIS

 my $parser = SOAP::WSDL::Expat::MessageParser->new({
    class_resolver => 'My::Resolver'   
 });
 $parser->parse( $xml );
 my $obj = $parser->get_data();

=head1 DESCRIPTION

Real fast expat based SOAP message parser.

See L<SOAP::WSDL::Parser> for details.

=head2 Skipping unwanted items

Sometimes there's unneccessary information transported in SOAP messages.

To skip XML nodes (including all child nodes), just edit the type map for 
the message and set the type map entry to '__SKIP__'. 

=head1 Bugs and Limitations

=over

=item * Ignores all namespaces

=item * Does not handle mixed content

=item * The SOAP header is ignored

=back

=head1 AUTHOR

Replace the whitespace by @ for E-Mail Address.

 Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 COPYING

This module may be used under the same terms as perl itself.

=head1 Repository information

 $ID: $

 $LastChangedDate: 2007-10-02 14:07:21 -0600 (Tue, 02 Oct 2007) $
 $LastChangedRevision: 304 $
 $LastChangedBy: kutterma $

 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/attic/lib/SOAP/WSDL/Expat/MessageSubParser.pm $


