#!/usr/bin/perl
package SOAP::WSDL::XSD::Typelib::ComplexType;
use strict;
use warnings;
use Carp;
use SOAP::WSDL::XSD::Typelib::Builtin;
use Scalar::Util qw(blessed);
use Data::Dumper;
require Class::Std::Fast::Storable;

use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anyType);

use version; our $VERSION = qv('2.00.99_3');

# remove in 2.1
our $AS_HASH_REF_WITHOUT_ATTRIBUTES = 0;

my %ELEMENT_FORM_QUALIFIED_OF;  # denotes whether elements are qualified
my %ELEMENTS_FROM;      # order of elements in a class
my %ATTRIBUTES_OF;      # references to value hashes
my %CLASSES_OF;         # class names of elements in a class
my %NAMES_OF;           # XML names of elements in a class


# XML Attribute handling
my %xml_attr_of     :ATTR();

# Namespace handling
my %xmlns_of        :ATTR();

our $MAY_HAVE_CHILDREN = 1;

# don't you ever dare to use this !
our $___classes_of_ref = \%CLASSES_OF;
our $___attributes_of_ref = \%ATTRIBUTES_OF;
our $___xml_attribute_of_ref = \%xml_attr_of;

# STORABLE_ methods for supporting Class::Std::Fast::Storable.
# We could also handle them via AUTOMETHOD,
# but AUTOMETHOD should always croak...
# Actually, AUTOMETHOD is faster (~1%) if Class::Std::Fast is loaded
# properly, and slower (~10%) if not.
# Hmmm. Trade 1% for 10?

my %STORABLE_METHODS = (
    STORABLE_freeze_pre => undef,
    STORABLE_freeze_post => undef,
    STORABLE_thaw_pre => undef,
    STORABLE_thaw_post => undef,
);

# for error reporting. Eases working with data objects...
sub AUTOMETHOD {
    # return before unpacking @_ for speed reasons
    return if exists $STORABLE_METHODS{$_};

    my ($self, $ident, @args_from) = @_;
    my $class = ref $self || $self or die "Cannot call AUTOMETHOD as function";

    # Test whether we're called from ->can()
    my @caller = caller(1);

    # return if not called by AUTOLOAD - caller must be something like can()
    # Unfortunately we cannot test for "UNIVERSAL::can", as it gets overwritten
    # by both Class::Std and Class::Std::Fast, and we don't know the loading
    # order (Class::Std::Fast should be loaded before for maximum speedup)
    return if $caller[3] ne 'Class::Std::AUTOLOAD';

    confess "Can't locate object method \"$_\" via package \"$class\". \n"
        . "Valid methods are: "
        . join(', ', map { ("get_$_" , "set_$_") } keys %{ $ATTRIBUTES_OF{ $class } })
        . "\n"
}

sub attr {
    # We're working on @_ for speed.
    # Normally, the first line would look like this:
    # my $self = shift;

    my $class = $_[0]->__get_attr_class()
        or return;

    # pass arguments to attributes constructor (if any);
    # lets attr($foo) work as setter
    if ($_[1]) {
        return $xml_attr_of{ ${$_[0]} } = $class->new($_[1]);
    }
    return $xml_attr_of{ ${$_[0]} } if exists $xml_attr_of{ ${$_[0]} };
    return $xml_attr_of{ ${$_[0]} } = $class->new();
}

sub serialize_attr {
    return q{} if not $xml_attr_of{ ${ $_[0] } };
    return $xml_attr_of{ ${ $_[0] } }->serialize();
}

# TODO: are complextypes are always true ?
sub as_bool :BOOLIFY { 1 }

sub as_hash_ref {
    # we're working on $_[0] for speed (as always...)
    #
    # Normally the first line would read:
    # my ($self, $ignore_attributes) = @_;
    #
    my $attributes_ref = $ATTRIBUTES_OF{ ref $_[0] };

    my $hash_of_ref = {};
    if ($_[0]->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType')) {
        $hash_of_ref->{ value } = $_[0]->get_value();
    }
    else {
        foreach my $attribute (keys %{ $attributes_ref }) {
            next if not defined $attributes_ref->{ $attribute }->{ ${ $_[0] } };
            my $value = $attributes_ref->{ $attribute }->{ ${ $_[0] } };

            $hash_of_ref->{ $attribute } = blessed $value
                ? $value->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType')
                    ? $value->get_value()
                    : $value->as_hash_ref($_[1])
                : ref $value eq 'ARRAY'
                    ? [
                        map {
                            $_->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType')
                                ? $_->get_value()
                                : $_->as_hash_ref($_[1])
                        } @{ $value }
                    ]
                    : die "Neither blessed obj nor list ref";
        };
    }

    # $AS_HASH_REF_WITHOUT_ATTRIBUTES is deprecated by NOW and will be removed
    # in 2.1
    return $hash_of_ref if $_[1] or $AS_HASH_REF_WITHOUT_ATTRIBUTES;


    if (exists $xml_attr_of{ ${ $_[0] } }) {
        $hash_of_ref->{ xmlattr } = $xml_attr_of{ ${ $_[0] } }->as_hash_ref();
    }

    return $hash_of_ref;
}

# we store per-class elements.
# call as __PACKAGE__->_factory
sub _factory {
    my $class = shift;
    $ELEMENTS_FROM{ $class }    = shift;
    $ATTRIBUTES_OF{ $class }    = shift;
    $CLASSES_OF{ $class }       = shift;
    $NAMES_OF{ $class }         = shift;

    no strict qw(refs);
    no warnings qw(redefine);

    while (my ($name, $attribute_ref) = each %{ $ATTRIBUTES_OF{ $class } } ) {
        my $type = $CLASSES_OF{ $class }->{ $name }
            or croak "No class given for $name";

        # require all types here
        $type->isa('UNIVERSAL')
            or eval "require $type"
                or croak $@;

        # check now, so we don't need to do it later.
        # $is_list is used in the methods created. Filling it now means
        # we don't have to check it every time the method is called, but
        # can just use $is_list, which will hold the value assigned to
        # it when the method was created.
        my $is_list = $type->isa('SOAP::WSDL::XSD::Typelib::Builtin::list');

        # The set_$name method below looks rather weird,
        # but is optimized for performance.
        #
        #  We could use sub calls for sure, but these are much slower. And
        # the logic is not that easy:
        #
        #  we accept:
        #  a) objects
        #  b) scalars
        #  c) list refs
        #  d) hash refs
        #  e) mixed stuff of all of the above, so we have to set our child to
        #    a) value if it's an object
        #    b) New object of expected class with value for simple values
        #    c 1) New object with value for list values and list type
        #    c 2) List ref of new objects with value for list values and
        #         non-list type
        #    c + e 1) List ref of objects for list values (list of objects)
        #             and non-list type
        #    c + e 2) List ref of new objects for list values (list of hashes)
        #             and non-list type where the hash ref is passed to new as
        #             argument
        #    d) New object with values passed to new for HASH references
        #
        #  We throw an error on
        #  a) list refs of list refs - don't know what to do with this (maybe
        #     use for lists of list types ?)
        #  b) wrong object types
        #  c) non-blessed non-ARRAY/HASH references - if you can define semantics
        #     for GLOB or SCALAR references, feel free to add them.
        #  d) we should also die for non-blessed non-ARRAY/HASH references in
        #     lists but don't do yet - oh my !

        # keep in sync with Generator::Template::Plugin::XSD - maybe use
        # function to allow substituting via symbol table...
        my $method_name = $name;
        $method_name =~s{[\.\-]}{_}xmsg;
        *{ "$class\::set_$method_name" } = sub {
            if (not $#_) {
                delete $attribute_ref->{ ${ $_[0] } };
                return;
            };
            my $is_ref = ref $_[1];
            $attribute_ref->{ ${ $_[0] } } = ($is_ref)
                ? ($is_ref eq 'ARRAY')
                    ? $is_list                             # remembered from outside closure
                        ? $type->new({ value => $_[1] })   # it's a list element - can take list ref as value
                        : [ map {                          # it's not a list element - set value to list of objects
                            ref $_
                              ? ref $_ eq 'HASH'
                                  ? $type->new($_)
                                  : ref $_ eq $type
                                      ? $_
                                      : croak "cannot use " . ref($_) . " reference as value for $name - $type required"
                              : $type->new({ value => $_ })
                            } @{ $_[1] }
                         ]
                    : $is_ref eq 'HASH'
                        ?  $type->new( $_[1] )
                        # neither ARRAY nor HASH - probably an object... -
                        # do we need to test for it being blessed?
                        :  blessed $_[1] && $_[1]->isa($type)              # of required type ?
                            ? $_[1]                         # use it
                            : die croak "cannot use $is_ref reference as value for $name - $type required"

                # not $is_ref
                : defined $_[1] ? $type->new({ value => $_[1] }) : () ;
            return;
        };

        *{ "$class\::add_$method_name" } = sub {
            warn "attempting to add empty value to " . ref $_[0]
                if not defined $_[1];

            # first call
            # test for existance, not for definedness
            if (not exists $attribute_ref->{ ${ $_[0]} }) {
                $attribute_ref->{ ${ $_[0]} } = $_[1];
                return;
            }

            if (not ref $attribute_ref->{ ${ $_[0]} } eq 'ARRAY') {
                # second call: listify previous value if it's no list and add current
                $attribute_ref->{ ${ $_[0]} } = [  $attribute_ref->{ ${ $_[0]} }, $_[1] ];
                return;
            }

            # second and following: add to list
            push @{ $attribute_ref->{ ${ $_[0]} } }, $_[1];
            return;
        };
    }

    # TODO Could be moved as normal method into base class, e.g. here.
    # Hmm. let's see...
    *{ "$class\::new" } = sub {
        # We're working on @_ for speed.
        # Normally, the first line would look like this:
        # my ($class, $args_of) = @_;
        #
        # The hanging side comment show you what would be there, then.

        # Read as:
        # my $self = bless \(my $o = Class::Std::Fast::ID()), $class;
        my $self = bless \(my $o = Class::Std::Fast::ID()), $_[0];

        # Set attributes if passed via { xmlattr => \%attributes }
        #
        # This works just because
        #    a) xmlattr cannot be used as valid XML identifier (it starts
        #       with "xml" which is banned by the XML schema standard)
        #    b) $o->attr($attribute_ref) passes $attribute_ref to the
        #       attribute object's constructor
        #    c) we are in the object's constructor here (which means that)
        #       no attributes object can have been legally constructed
        #       before.
        if (exists $_[1]->{xmlattr}) {                      # $args_of->{xmlattr}
            $self->attr(delete $_[1]->{xmlattr});
        }

        # iterate over keys of arguments
        # and call set appropriate field in clase
        map { ($ATTRIBUTES_OF{ $class }->{ $_ })
            ? do {
                my $method = "set_$_";

                # keep in sync with Generator::Template::Plugin::XSD - maybe use
                # function to allow substituting via symbol table...
                $method =~s{[\.\-]}{_}xmsg;

                $self->$method( $_[1]->{ $_ } );               # ( $args_of->{ $_ } );
           }
           : $_ =~ m{ \A              # beginning of string
                      xmlns           # xmlns
                }xms        # get_elements is inlined for performance.
                ? ()
                : do {
                     croak "unknown field $_ in $class. Valid fields are:\n"
                     . join(', ', @{ $ELEMENTS_FROM{ $class } }) . "\n"
                     . "Structure given:\n" . Dumper @_ };
        } keys %{ $_[1] };                                      # %$args_of;
        return $self;
    };

    # this _serialize method works fine for <all> and <sequence>
    # complextypes, as well as for <restriction><all> or
    # <restriction><sequence>, and attribute sets.
    #
    # But what about choice, extension ?
    #
    # Triggers XML attribute serialization if the options hash ref contains
    # a attr element with a true value.
    *{ "$class\::_serialize" } = sub {
        my $ident = ${ $_[0] };
        my $option_ref = $_[1];
        
        # return concatenated return value of serialize call of all
        # elements retrieved from get_elements expanding list refs.
        return \join q{} , map {
            my $element = $ATTRIBUTES_OF{ $class }->{ $_ }->{ $ident };

            # do we have some content
            if (defined $element) {
                $element = [ $element ] if not ref $element eq 'ARRAY';
                # from 2.00.09 on $NAMES_OF is filled - use || $_; for
                # backward compatibility
                my $name = $NAMES_OF{$class}->{$_} || $_;

                # get element's class for comparing with elements
                my $element_class = $CLASSES_OF{$class}->{$_};

                my $target_namespace = $_[0]->get_xmlns();
                map {
                    my %type_info = ($element_class ne ref $_)
                        ? (derived => 1)
                        : ();

                    # serialize element elements with their own serializer
                    # but name them like they're named here.
                    # TODO: check. element ref="" has a name???
                    if ( $_->isa( 'SOAP::WSDL::XSD::Typelib::Element' ) ) {
                            # serialize elements of different namespaces
                            # with namespace declaration
                            ($target_namespace ne $_->get_xmlns())
                                ? $_->serialize({ name => $name, qualified => 1, %type_info })
                                : $_->serialize({ name => $name
                                    , %type_info
                                });
                    }
                    # serialize complextype elments (of other types) with their
                    # serializer, but add element tags around.
                    else {
                        # TODO: check whether we have to handle
                        # types from different namespaces special, too
                        if (!defined $ELEMENT_FORM_QUALIFIED_OF{ $class }
                            or $ELEMENT_FORM_QUALIFIED_OF{ $class }
                        ) {
                            # handle types from different namespaces
                            #
                            # serialize with last namespace put on stack
                            # if the last namespace is a change from the
                            # before-last
                            #
                            if (
                                exists $option_ref->{ xmlns_stack } 
                                && (scalar @{ $option_ref->{ xmlns_stack } } >= 2) 
                                && ($option_ref->{ xmlns_stack }->[-1] ne $option_ref->{ xmlns_stack }->[-2])) {
                                # warn "New namespace: ", $option_ref->{ xmlns_stack }->[-1]; 
                                join q{}, $_->start_tag({ name => $name , 
                                    xmlns => $option_ref->{ xmlns_stack }->[-1], 
                                    %{ $option_ref }, %type_info })
                                    , $_->serialize({ %{ $option_ref }, %type_info })
                                    , $_->end_tag({ name => $name , %{ $option_ref } });
                            }
                            else {
                                # hack to get UPS wsdl files working
                                # the commom:Request element uses <Request> for all subtags
                                # Andrew Baerg - Oct 6, 2010
                                if ($name && $option_ref->{name}) {
                                  warn "deleting option_ref->{name} for $name: [$option_ref->{name}]";
                                  delete $option_ref->{name};
                                }

                                join q{}, $_->start_tag({ name => $name , %{ $option_ref }, %type_info })
                                    , $_->serialize({ %{ $option_ref }, %type_info })
                                    , $_->end_tag({ name => $name , %{ $option_ref } });
                            }
                        }
                        else {
                            # in elementFormDefault="unqualified" mode,
                            # the serialize method has to set
                            # xmnlns="" on all elements inside a ComplexType
                            #
                            # Other serializers usually use prefixes 
                            # for "unqualified" and just omit all prefixes
                            # for inner elements 
                            
                            # check whether we "had" a xmlns around
                            my $set_xmlns = delete $option_ref->{xmlns};
                            
                            # serialize start tag with xmlns="" if out parent
                            # did not do that
                            join q{}, $_->start_tag({
                                    name => $name,
                                    %{ $option_ref },
                                    %type_info,
                                    (! defined $set_xmlns)
                                        ? (xmlns => "")
                                        : ()
                                })
                                # add xmlns = "" to child serialize options
                                # to avoid putting xmlns="" everywhere
                                , $_->serialize({ %{$option_ref}, xmlns => "" })
                                , $_->end_tag({ name => $name , %{ $option_ref } });
                        }
                    }
                } @{ $element }
            }
            else {
                 q{};
            }
        } (@{ $ELEMENTS_FROM{ $class } });
    };

    # put hidden complex serializer into class
    # ... but not for AttributeSet classes
    if ( ! $class->isa('SOAP::WSDL::XSD::Typelib::AttributeSet')) {
        *{ "$class\::serialize" } = \&__serialize_complex;
    };
}

sub _set_element_form_qualified {
    $ELEMENT_FORM_QUALIFIED_OF{ $_[0] } = $_[1];
}

# Just as fallback: return no attribute set class as default.
# Subclasses may override
sub __get_attr_class {};

# hidden complex serializer
sub __serialize_complex {
    # we work on @_ for performance.
    $_[1] ||= {};                                   # $option_ref
    
    push @{ $_[1]->{ xmlns_stack } }, $_[0]->get_xmlns();
    
    # get content first (pass by reference to avoid copying)
    my $content_ref = $_[0]->_serialize($_[1]);     # option_ref

    pop @{ $_[1]->{ xmlns_stack } };

    # do we have a empty element ?
    return $_[0]->start_tag({ %{ $_[1] }, empty => 1 })
        if not length ${ $content_ref };

    return join q{}, $_[0]->start_tag($_[1]), ${ $content_ref }, $_[0]->end_tag();
}

sub get_xmlns {
    return q{}
}

1;

__END__

=pod

=head1 NAME

SOAP::WSDL::XSD::Typelib::ComplexType - Base class for complexType node classes

=head1 Subclassing

To subclass, write a package like this:

 package MyComplexType;
 use Class::Std::Fast::Storable constructor => 'none';
 use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

 # we only need the :get attribute qualifier.
 # set and init_arg are automatically created by
 # SOAP::WSDL::XSD::Typelib::ComplexType
 my %first_attr_of   :ATTR(:get<first_attr>  :default<()>);
 my %second_attr_of  :ATTR(:get<second_attr> :default<()>);
 my %third_attr_of   :ATTR(:get<third_attr>  :default<()>);

 # the order of elements in a complexType
 my @elements_from = qw(first_attr second_attr third_attr);

 # references to the private hashes
 my %attribute_of = (
    first_attr  => \%first_attr_of,
    second_attr => \%second_attr_of,
    third_attr  => \%third_attr_of,
 );

 # classes_of: Classes the child elements should be of
 my %classes_of = (
    first_attr  => 'My::FirstElement',
    second_attr => 'My::SecondElement',
    third_attr  => 'My::ThirdElement',
 );

 # call _factory
 __PACKAGE__->_factory(
    \@elements_from,
    \%attributes_of,
    \%classes_of,
 );

 1;

When subclassing, the following methods are created in the subclass:

=head2 new

Constructor. For your convenience, new will accept data for the object's
properties in the following forms:

 hash refs
 1) of scalars
 2) of list refs
 3) of hash refs
 4) of objects
 5) mixed stuff of all of the above

new() will set the data via the set_FOO methods to the object's element
properties.

Data passed to new must comply to the object's structure or new() will
complain. Objects passed must be of the expected type, or new() will
complain, too.

The special key B<xmlattr> may be used to pass XML attributes. This key is
chosen, because "xmlattr" cannot legally be used as XML name (it starts with
"xml"). Passing a hash ref structure as value to "xmlattr" has the same
effect as passing the same structure to a call to C<$obj->attr()>

Examples:

 my $obj = MyClass->new({ MyName => $value });

 my $obj = MyClass->new({
     MyName => {
         DeepName => $value,
     },
     MySecondName => $value,
 });

 my $obj = MyClass->new({
     MyName => [
        { DeepName => $value },
        { DeepName => $other_value },
     ],
     MySecondName => $object,
     MyThirdName => [ $object1, $object2 ],
 });

my $obj = MyClass->new({
     xmlattr => { name => 'foo' },
     MyName => {
         DeepName => $value,
     },
     MySecondName => $value,
 });

In case your building on Class::Std, please note the following limitations:

The new() method from Class::Std will be overridden, so you should not rely
on it's behaviour.

Your START and BUILD methods are called, but the class' inheritance tree is
not traversed.

=head2 set_FOO

A mutator method for every element property.

For your convenience, the set_FOO methods will accept all kind of data you
can think of (and all combinations of them) as input - with the exception
of GLOBS and filehandles.

This means you may set element properties by passing

 a) objects
 b) scalars
 c) list refs
 d) hash refs
 e) mixed stuff of all of the above

Examples are similar to the examples provided for new() above.

Note that you cannot delete a property by setting it to undef - this sets
the property to an empty property object (with value undef).

To delete a property, say:

 $obj->set_FOO();

=head2 attr

Returns / sets the attribute object associated with the object. XML Attributes
are modeled as attribute objects - their classes are usually private (i.e.
part of the associated class' file, not in a separate file named after the
attribute class).

Note that attribute support is still experimental.

=head2 as_bool

Returns the boolean value of the complexType (always true).

=head2 as_hash_ref

Returns a hash ref representation of the complexType object

Attributes are included under the special key "xmlattr" (if any).

The inclusion of attributes can be suppressed by calling

 $obj->as_has_ref(1);

or even globally by setting

 $SOAP::WSDL::XSD::Typelib::ComplexType::AS_HASH_REF_WITHOUT_ATTRIBUTES = 1;

Note that using the $AS_HASH_REF_WITHOUT_ATTRIBUTES global variable is
strongly discouraged. Use of this variable is deprecated and will be removed
as of version 2.1

as_hash_ref can be used for deep cloning. The following statement creates
a deep clone of a SOAP::WSDL::ComplexType-based object

 my $clone = ref($obj)->new($obj->as_hash_ref());

=head2 serialize_attr

Serialize a complexType's attributes

=head2 serialize

Serialize a ComplexType object to XML. Exported via symbol table into derived
classes.

=head1 Bugs and limitations

=over

=item * Incomplete API

Not all variants of XML Schema ComplexType definitions are supported yet.

Variants known to work are:

 sequence
 all
 complexContent containing sequence/all definitions

=item * Thread safety

SOAP::WSDL::XSD::Typelib::Builtin::ComplexType uses Class::Std::Fast::Storable which uses
Class::Std. Class::Std is not thread safe, so
SOAP::WSDL::XSD::Typelib::Builtin::ComplexType is neither.

=item * XML Schema facets

No facets are implemented yet.

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under the same
terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 861 $
 $LastChangedBy: kutterma $
 $Id: ComplexType.pm 861 2010-03-28 10:41:26Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/XSD/Typelib/ComplexType.pm $

=cut

