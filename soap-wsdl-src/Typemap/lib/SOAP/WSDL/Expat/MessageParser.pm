#!/usr/bin/perl
package SOAP::WSDL::Expat::MessageParser;
use strict; use warnings;

use SOAP::WSDL::Generator::PrefixResolver;
use SOAP::WSDL::XSD::Typelib::Builtin;
use SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType;
use SOAP::WSDL::XSD::Typelib::ComplexType;
use base qw(SOAP::WSDL::Expat::Base);

BEGIN { require Class::Std::Fast };

our $VERSION = 2.01;

# GLOBALS
my $OBJECT_CACHE_REF = Class::Std::Fast::OBJECT_CACHE_REF();
my $CLASSES_OF_REF = $SOAP::WSDL::XSD::Typelib::ComplexType::___classes_of_ref;

# keep track of classes loaded
my %LOADED_OF = ();

sub new {
    my ($class, $args) = @_;
    my $self = {
        prefix_resolver => $args->{ prefix_resolver } || SOAP::WSDL::Generator::PrefixResolver->new(),
        class_resolver  => $args->{ class_resolver },
        body_parts      => $args->{ body_parts }   || [],
        header_parts    => $args->{ header_parts } || [],
        strict          => exists $args->{ strict } ? $args->{ strict } : 1,
    };

    bless $self, $class;

    $self->load_classes()
        if $args->{ class_resolver }
           && ! exists $LOADED_OF{ $self->{ class_resolver } };

    return $self;
}

sub set_header_parts {
    $_[0]->{ header_parts } = $_[1];
}

sub set_body_parts {
    $_[0]->{ body_parts } = $_[1];
}

sub class_resolver {
    my $self = shift;
    if ( @_ ) {
        $self->{ class_resolver } = shift
            or return;
        $self->load_classes() if ! exists $LOADED_OF{ $self->{ class_resolver } };
    }
    return $self->{ class_resolver };
}

sub load_classes {
    my $self = shift;

    return if $LOADED_OF{ $self->{ class_resolver } }
           || ! $self->{ class_resolver }->can('get_typemap');

    # requires sorting to make sub-packages load after their parent
    for ( sort values %{ $self->{ class_resolver }->get_typemap() } ) {
        no strict qw(refs);
        my $class = $_;

        # ignore __SKIP__
        next if $class eq '__SKIP__';

        # check if namespace exists
        next if defined *{ "$class\::" }; # bad test - know a better one?

        # Require takes a bareword or a file name - we have to take
        # the filname road here...
        $class =~s{ :: }{/}xmsg;
        require "$class.pm";
    }
    $LOADED_OF{ $self->{ class_resolver } } = 1;
}

sub get_type_class {
    my ($self, $name) = @_;
    my ($prefix,$localname) = split m{:}x , $name;
    my $namespace;
    if ($localname) {
        $namespace = $self->{ parser }->expand_ns_prefix($prefix);
    }
    else {
        $namespace = $self->{ parser }->expand_ns_prefix('#default');
        $localname = $name;
    }

    return "SOAP::WSDL::XSD::Typelib::Builtin::$localname"
        if ($namespace eq 'http://www.w3.org/2001/XMLSchema');

    # resolve perl prefix
    my $perl_prefix = $self->{ prefix_resolver }->resolve_prefix('type', $namespace);

    # TODO build a perl name from >type< prefix and name using the prefix resolver
    return "$perl_prefix$localname";
}

sub _initialize {
    my ($self, $parser) = @_;
    $self->{ parser } = $parser;

    delete $self->{ data };                     # remove potential old results
    delete $self->{ header };

    # Note: $current MUST be undef - it is used as sentinel
    # on the object stack via if (! defined $list->[-1])
    # DON'T set it to anything else !
    my $current = undef;

    my ($list, $path)  = ([], []); # node list (object stack) and path
    my ($skip, $depth) = (0, 0);   # skip elements, depth

    # use "globals" for speed
    my ($_prefix, $_method, $_class, $_leaf, $characters, $_current_classes_of_ref, $handling_multiple_parts) = ();
    my (@_attr_from, %_xsi_attr_of) = ();

    my %parts_of = (
        body => {
           map {
                exists $LOADED_OF{ $_ }
                    || eval "require $_" and $LOADED_OF{ $_ } = undef;
                $_->__get_name() => $_
           } @{ $self->{ body_parts } }
        },
        header => {
            map {
                exists $LOADED_OF{ $_ }
                    || eval "require $_" and $LOADED_OF{ $_ } = undef;
                eval "require $_"; $_->__get_name() => $_
            } @{ $self->{ header_parts } }
        }
    );

    my %content_check = (
        0 => sub {
            die "Bad top node $_[1]" if $_[1] ne 'Envelope';
            die "Bad namespace for SOAP envelope: " . $_[0]->recognized_string()
                if $_[0]->namespace($_[1]) ne 'http://schemas.xmlsoap.org/soap/envelope/';
            $depth++;
        },
        1 => sub {
            $depth++;
            if ($_[1] eq 'Body') {
                if ( exists $self->{data} ) { # there was header data
                    $self->{ header } = delete $self->{ data };
                    $list = [];
                    $path = [];
                    undef $current;
                }
                $handling_multiple_parts = @{ $self->{body_parts} } > 1;
                $_current_classes_of_ref = $parts_of{ body };
            }
            elsif ($_[1] eq 'Header') {
                $handling_multiple_parts = @{ $self->{header_parts} } > 1;
                $_current_classes_of_ref = $parts_of{ header };
            }
        },
    );
    # bypass checking wheter namespaces are OK in non-strict mode
    if (! $self->{strict}) {
	    $content_check{0} = sub { $depth++ };
    }
    my $char_handler = sub {
        return if ! $_leaf;    # we only want characters in leaf nodes
        $characters .= $_[1];  # add to characters
        return;                # return void
    };

    my $start_handler = sub {
        # my ($parser, $element, %attrs) = @_;
        $_leaf = 1;     # believe we're a leaf node until we see an end

        # call methods without using their parameter stack. That's slightly
        # faster than $content_check{ $depth }->() and we don't have to pass
        # $_[1] to the method.
        return &{$content_check{ $depth }} if exists $content_check{ $depth };

        $depth++;
        return if ($skip);
        # handle attributes
        # Attribute names must not be converted into hash keys - they're
        # dual-valued scalars, and loose their second value when converted
        # to a hash key...
        %_xsi_attr_of = ();
        if (@_ > 2) {
            @_attr_from = @_[2..$#_];

            # handle xsi attributes
            # looks pretty C-ish - but those dual vars don't leave much choice
            my $i = 0;
            while ($i < @_attr_from) {
                if ( ( $_[0]->namespace($_attr_from[$i]) || q{} ) eq 'http://www.w3.org/2001/XMLSchema-instance') {
                    $_xsi_attr_of{$_attr_from[$i]} = $_attr_from[$i + 1];
                    splice @_attr_from, $i, 2;
                }
                $i += 2;
            }
        }

        # we only need to set $_current_classes_of if we may have child nodes
        # set new class resolver

        # get class from current complexType
        $_class = exists $_xsi_attr_of{type}
            ? $self->get_type_class($_xsi_attr_of{type})
            : ( $_current_classes_of_ref->{ $_[1] });

        # When no class is found: throw error in strict mode
        # and enable skipping in lax mode. Be sure not to move
        # this block not below pushing stuff on @{ $list } - the
        # list contains a sentinel used as stop marker for
        # returning content (instead of adding it to a parent)
        if (! defined($_class) ) {
            if ($self->{ strict }) {
                die "Cannot resolve class for element " . $_[1];
            }
            $skip = $depth;
            $_[0]->setHandlers( Char => undef );
            return;
        }

        # step down in tree
        # on the first object (after skipping Envelope/Body), $current
        # is undef.  We put it on the stack, anyway, and use it as sentinel
        # when  going through the closing tags in the End handler
        push @{ $list }, $current;                  # remember current
        push @{ $path }, $_current_classes_of_ref;  # remember class map

        # all Builtins are simple types
        # complexTypes need to look up their child's element map...
        COMPLEX: {
            if ( $_class !~ m{ SOAP::WSDL::XSD::Typelib::Builtin:: }x ) {
                if ( exists $CLASSES_OF_REF->{ $_class } ) {
                    $_current_classes_of_ref = $CLASSES_OF_REF->{ $_class };
                    last COMPLEX;
                }

                # try parent classes - walk through isa
                # only elements need to walk through @ISA
                $_class->isa('SOAP::WSDL::XSD::Typelib::Element')
                    or last COMPLEX;

                # follow @ISA depth first
                no strict qw(refs);
                my @isa = @{ "$_class\::ISA" };
                ISA: {
                    do {
                        if ( exists $CLASSES_OF_REF->{ $isa[0] } ) {
                            $_current_classes_of_ref = $CLASSES_OF_REF->{ $isa[0] };
                            last ISA;
                        }

                        unshift @isa, @{ shift(@isa) . '::ISA'};
                    } until ($#isa < 0);
                }
            }
        }

        # cleanup
        undef $current; # help profilers find real hot spots
        $characters = q{};

        # Create and set new objects using Class::Std::Fast's object cache
        # if possible, or blessing directly into the class in question
        # (circumventing constructor) here. That's dirty, but fast.
        #
        # TODO: check whether this is faster under all perls - there's
        # strange benchmark results...
        #
        # The alternative would read:
        # $current = $_class->new({ @_[2..$#_] });

        $current = pop @{ $OBJECT_CACHE_REF->{ $_class } };
        if ( ! defined $current ) {
            $current = bless \Class::Std::Fast::ID(), $_class;
        }

        # ahm - ain't this better off in a end handler?
        if ( $_xsi_attr_of{nil} && $_xsi_attr_of{nil} ne 'false' ) {
            undef $characters;
        }

        # set attributes if there are any
        $current->attr({ @_attr_from }) if @_attr_from;
#        $depth++;

        # return is only half as fast as no statement - however,
        # XML::Parser::Expat accidentally calls the callbacks in
        # scalar (instead of void) context, making return faster
        return;
    };

    # compatibility start handler for use with typemaps
    my $start_handler_typemap = sub {
        # my ($parser, $element, %attrs) = @_;

        $_leaf = 1;  # believe we're a leaf node until we see an end

        # call methods without using their parameter stack
        # That's slightly faster than $content_check{ $depth }->()
        # and we don't have to pass $_[1] to the method.
        # Yup, that's dirty.
        return &{$content_check{ $depth }}
            if exists $content_check{ $depth };

        push @{ $path }, $_[1];        # step down in path
        return if $skip;               # skip inside __SKIP__

        # resolve class of this element
        $_class = $self->{ class_resolver }->get_class( $path );

        if (! defined($_class) and $self->{ strict }) {
            die "Cannot resolve class for element "
                . join('/', @{ $path }) . " via " . $self->{ class_resolver };
        }

        if (! defined($_class) or ($_class eq '__SKIP__') ) {
            $skip = scalar @{ $path };
            $_[0]->setHandlers( Char => undef );
            return;
        }

        # step down in tree (remember current)
        #
        # on the first object (after skipping Envelope/Body), $current
        # is undef.
        # We put it on the stack, anyway, and use it as sentinel when
        # going through the closing tags in the End handler
        #
        push @{$list}, $current;

        # cleanup.
        undef $current;     # help profilers find the real hot spots
        $characters = q{};  # reset characters read

        # Create and set new objects using Class::Std::Fast's object cache
        # if possible, or blessing directly into the class in question
        # (circumventing constructor) here.
        # That's dirty, but fast.
        #
        # TODO: check whether this is faster under all perls - there's
        # strange benchmark results...
        #
        # The alternative would read:
        # $current = $_class->new({ @_[2..$#_] });
        #
        $current = pop @{ $OBJECT_CACHE_REF->{ $_class } };
        if ( ! defined $current ) {
            $current = bless \Class::Std::Fast::ID(), $_class;
        }

        # set attributes if there are any
        ATTR: {
            my %attr = @_[2..$#_];

            if ( %attr ) {
                if ( my $nil = delete $attr{nil} ) {
                    # TODO: check namespace
                    if ($nil && $nil ne 'false') {
                        undef $characters;
                        last ATTR if ! %attr;
                    }
                }
                $current->attr(\%attr);
            }
        }
        $depth++;

        return; # Speed up XML::Parser::Expat - see above for why
    };

    my $end_handler = sub {
        # operate on @_ for performance

        $_current_classes_of_ref = pop @{ $path };  # step up in path
        $depth--;

        # check $skip - do we have to come back?
        #
        # Skip is a marker for the depth of the element to skip.
        # If depth ever drops below this, remove marker
        # be sure not to move the $depth-- below this block
        if ($skip) {
            return if $skip < $depth;
            $skip = 0;
            $_[0]->setHandlers( Char => $char_handler );
            return;
        }

        # we only set character values in leaf nodes
        # Use dirty but fast access via global variables.
        # The normal way (via method) would be this:
        # $current->set_value( $characters ) if (length($characters));
        $SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType::___value
            ->{ ${$current} } = $characters
                if $_leaf && defined $characters && defined $current;

        # empty characters
        $characters = q{};

        # stop believing we're a leaf node
        undef $_leaf;

        # return if there's only one elment - can't set it in parent ;-)
        # but set as root element if we don't have one already.
        if ( defined $list->[-1] ) {
            # set appropriate attribute in last element
            # multiple values must be implemented in base class
            # TODO check if hash access is faster
            # $_method = "add_$_localname";
            $_method = "add_$_[1]";

            # fixup XML names for perl names
            $_method =~ s{\.}{__}xg;
            $_method =~ s{\-}{_}xg;
            $list->[-1]->$_method( $current );

            $current = pop @{$list}; # step up in object hierarchy

            undef $_leaf; # stop believing we're a leaf node
        }
        else {
            if ( $handling_multiple_parts ) {
                push @{$self->{data} ||= []}, $current;
                $current = ();
            }
            elsif ( ! exists $self->{ data } ) {
                $self->{data} = $current;
            }
            # TODO: Skip content of anyType / any stuff
        }

        return; # Speed up XML::Parser::Expat - see above for why
    };

    my $end_handler_typemap = sub {
        pop @{ $path };                     # step up in path
        # check __SKIP__
        if ($skip) {
            return if $skip < scalar @{ $path };
            $skip = 0;
            $_[0]->setHandlers( Char => $char_handler );
            return;
        }

        $depth--;

        # we only set character values in leaf nodes
        if (defined $_leaf) {
            # Use dirty but fast access via global variables.
            # The normal way (via method) would be this:
            # $current->set_value( $characters ) if (length($characters));
            $SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType::___value
                ->{ $$current } = $characters
                    if defined $characters && defined $current; # =~m{ [^\s] }xms;
        }

        # empty characters
        $characters = q{};

        # stop believing we're a leaf node
        undef $_leaf;

        # return if there's only one elment - can't set it in parent ;-)
        # but set as root element if we don't have one already.
        if ( ! defined $list->[-1] ) {
            $self->{ data } = $current if ! exists $self->{ data };
            return;
        };

        # set appropriate attribute in last element
        # multiple values must be implemented in base class
        # TODO check if hash access is faster
        # $_method = "add_$_localname";
        $_method = "add_$_[1]";

        # fixup XML names for perl names
        $_method =~s{\.}{__}xg;
        $_method =~s{\-}{_}xg;
        $list->[-1]->$_method( $current );

        # step up in object hierarchy
        $current = pop @$list;

        # Speed up XML::Parser::Expat - calls handlers in scalar context...
        return;
    };

    no strict qw(refs);
    $parser->setHandlers(
        Start => @{ $self->{ body_parts } }
            ? $start_handler
            : $start_handler_typemap,
        Char  => $char_handler,
        End   => @{ $self->{ body_parts } }
            ? $end_handler
            : $end_handler_typemap,
    );

    return $parser;
}

sub get_header {
    return $_[0]->{ header };
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

See L<SOAP::WSDL::Manual::Parser> for details.

=head2 Skipping unwanted items

Skipping unwanted items only works with typemaps.

The use of typemaps is discouraged from SOAP::WSDL 2.01 on. The typemap
mechanism will become deprecated and eventually dropped in future versions of
SOAP::WSDL.

The information below is just there for completeness.

Sometimes there's unneccessary information transported in SOAP messages.

To skip XML nodes (including all child nodes), just edit the type map for
the message, set the type map entry to '__SKIP__', and comment out all
child elements you want to skip.

=head1 Bugs and Limitations

=over

=item * Ignores all namespaces

=item * Does not handle mixed content

=item * The SOAP header is ignored

=back

=head1 AUTHOR

Replace the whitespace by @ for E-Mail Address.

 Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2008 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 Repository information

 $Id: MessageParser.pm 840 2009-03-09 20:17:15Z kutterma $

 $LastChangedDate: 2009-03-09 14:17:15 -0600 (Mon, 09 Mar 2009) $
 $LastChangedRevision: 840 $
 $LastChangedBy: kutterma $

 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Expat/MessageParser.pm $

