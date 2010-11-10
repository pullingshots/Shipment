package SOAP::WSDL::Base;
use SOAP::WSDL;
use strict; use warnings;
use Class::Std::Fast::Storable;
use List::Util;
use Scalar::Util;
use Carp qw(croak carp confess);

use version; our $VERSION = qv('2.00.99_3');

my %id_of               :ATTR(:name<id> :default<()>);
my %lang_of             :ATTR(:name<lang> :default<()>);
my %name_of             :ATTR(:name<name> :default<()>);
my %namespace_of        :ATTR(:name<namespace> :default<()>);
my %documentation_of    :ATTR(:name<documentation> :default<()>);
my %annotation_of       :ATTR(:name<annotation> :default<()>);
my %targetNamespace_of  :ATTR(:name<targetNamespace> :default<"">);
my %xmlns_of            :ATTR(:name<xmlns> :default<{}>);
my %parent_of           :ATTR(:get<parent> :default<()>);

my %namespaces_of       :ATTR(:default<{}>);

sub namespaces {
    return shift->get_xmlns();
}

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;
    if (defined $arg_ref->{ parent }) {
        $parent_of{ $ident } = delete $arg_ref->{ parent },
        Scalar::Util::weaken($parent_of{ $ident });
    }
}

sub START {
    my ($self, $ident, $arg_ref) = @_;
    $xmlns_of{ $ident }->{ 'xml' } = 'http://www.w3.org/XML/1998/namespace';
    $namespaces_of{ $ident }->{ '#default' } = $self->get_xmlns()->{ '#default' };
    $namespaces_of{ $ident }->{ 'xml' } = 'http://www.w3.org/XML/1998/namespace';
}

#
# set_parent is hand-implemented to break up (weaken) the circular reference
# between an object and it's parent
#
sub set_parent {
    $parent_of{ ${ $_[0]} } = $_[1];
    Scalar::Util::weaken($parent_of{ ${ $_[0]} });
}

# _accept is here to be called by visitor.
# The visitor pattern is a level of indirection - here the visitor calls
# $object->_accept($visitor) on each object, which in turn calls
# $visitor->visit_$class( $object ) where $class is the object's class.
#
sub _accept {
    my $self = shift;
    my $class = ref $self;
    $class =~ s{ \A SOAP::WSDL:: }{}xms;
    $class =~ s{ (:? :: ) }{_}gxms;
    my $method = "visit_$class";
    no strict qw(refs);
    return shift->$method( $self );
}

# unfortunately, AUTOMETHOD is SLOW.
# Re-implement in derived package wherever speed is an issue...
#
sub AUTOMETHOD {
    my ($self, $ident, @values) = @_;
    my $subname = $_;   # Requested subroutine name is passed via $_

    # we're called as $self->push_something(@values);
    if ($subname =~s{^push_}{}xms) {
        my $getter = "get_$subname";
        my $setter = "set_$subname";
        # Checking here is paranoid - will fail fatally if there is no setter.
        # And we would have to check getters, too.
        # Maybe do it the Conway way via the Symbol table...
        # ... can is way slow...
        return sub {
            no strict qw(refs);
            my $old_value = $self->$getter();
            # Listify if not a list ref
            $old_value = $old_value ? [ $old_value ] : [] if not ref $old_value;

            push @$old_value , @values;
            $self->$setter( $old_value );
        };
    }

    # we're called as $obj->find_something($ns, $key)
    elsif ($subname =~s {^find_}{get_}xms) {
        @values = @{ $values[0] } if ref $values[0] eq 'ARRAY';
        return sub {
            return List::Util::first {
                $_->get_targetNamespace() eq $values[0] &&
                $_->get_name() eq $values[1]
            }
            @{ $self->$subname() };
        }
    }
    elsif ($subname =~s {^first_}{get_}xms) {
        return sub {
            my $result_ref = $self->$subname();
            return if not $result_ref;
            return $result_ref if (not ref $result_ref eq 'ARRAY');
            return $result_ref->[0];
        };
    }

    return;
}

sub init {
    my ($self, @args) = @_;
    print "Creating new node" . ident($self) . "\n" if $SOAP::WSDL::Trace;
    foreach my $value (@args) {
        croak @args if (not defined ($value->{ Name }));

        print "\tAttribute $value->{ Name } = $value->{ Value }\n" if $SOAP::WSDL::Trace;

        if ($value->{ Name } =~m{^xmlns\:}xms) {
            # add namespaces
            print "\tbind prefix $value->{ LocalName } to $value->{ Value }\n" if $SOAP::WSDL::Trace;
            $xmlns_of{ ident $self }->{ $value->{ LocalName } } = $value->{ Value };
            next;
        }

        # check for namespae-qualified attributes.
        # neither XML Schema, nor WSDL1.1, nor the SOAP binding allow
        # namespace-qualified attribute names
        my ($ns, $localname) = split /\|/, $value->{ Name };
        if ($ns) {
            warn "found unrecognised attribute \{$ns}$localname (ignored)";
            next;
        }

        my $name = $value->{ LocalName };
        my $method = "set_$name";
        $self->$method( $value->{ Value } );
    }
    
    return $self;
}

sub expand {
    my ($self, $qname) = @_;
    my $ns_of = $xmlns_of{ ident $self };
    my $parent;
    print "Resolving name for $qname in ", $self, " (", ident($self), ")\n" if $SOAP::WSDL::Trace;
    if (not $qname=~m{:}xm) {
        if (defined $ns_of->{ '#default' }) {
            # TODO check. Returning the targetNamespace for the default ns
            # is probably wrong
            #return $self->get_targetNamespace(), $qname;
            return $ns_of->{ '#default' }, $qname;
        }
        if ($parent = $self->get_parent()) {
            return $parent->expand($qname);
        }
        die "un-prefixed element name <$qname> found, but no default namespace set\n"
    }

    my ($prefix, $localname) = split /:/x, $qname;
    return ($ns_of->{ $prefix }, $localname) if ($ns_of->{ $prefix });
    if ($parent = $self->get_parent()) {
        return $parent->expand($qname);
    }
    croak "unbound prefix $prefix found for $prefix:$localname. Bound prefixes are "
        . join(', ', keys %{ $ns_of });
}
sub _expand;
*_expand = \&expand;

sub schema {
    my $parent = $_[0]->get_parent();
    return if ! defined $parent;
    return $parent if $parent->isa('SOAP::WSDL::XSD::Schema');
    return $parent->schema();
}

1;

__END__

# REPOSITORY INFORMATION
#
# $Rev: 332 $
# $LastChangedBy: kutterma $
# $Id: WSDL.pm 332 2007-10-19 07:29:03Z kutterma $
# $HeadURL: http://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL.pm $
#

