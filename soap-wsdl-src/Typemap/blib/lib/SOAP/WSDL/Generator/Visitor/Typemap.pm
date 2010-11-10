package SOAP::WSDL::Generator::Visitor::Typemap;
use strict;
use warnings;
use Class::Std::Fast::Storable;

use base qw(SOAP::WSDL::Generator::Visitor);

use version; our $VERSION = qv('2.00.99_3');

my %path_of             :ATTR(:name<path>           :default<[]>);
my %typemap_of          :ATTR(:name<typemap>        :default<()>);
my %resolver_of         :ATTR(:name<resolver>       :default<()>);

sub START {
    my ($self, $ident, $arg_ref) = @_;
    $resolver_of { $ident } = $arg_ref->{ resolver };
}

sub set_typemap_entry {
    my ($self, $value) = @_;
    # warn join( q{/}, @{ $path_of{ ident $self } }) . " => $value";
    $typemap_of{ ident $self }->{
        join( q{/}, @{ $path_of{ ident $self } } )
    } = $value;
}

sub add_element_path {
    my ($self, $element) = @_;

    # Swapping out this lines against the ones below generates
    # a namespace-sensitive typemap.
    # Well almost: Class names are not constructed in a namespace-sensitive
    # manner, yet - there should be some facility to allow binding a (perl)
    # prefix to a namespace...

    if (my $ref = $element->get_ref() ) {
        $element = $self->get_definitions()->first_types()->find_element(
            $element->expand($ref) );
    }
    my $name = $element->get_name();

    push @{ $path_of{ ident $self } }, $name;
}

sub process_referenced_type {
    my ( $self, $ns, $localname ) = @_;

    my $ident = ident $self;

    # get type's class name
    # Caveat: visits type if it's a referenced type from the
    # a ? b : c operation.
    my ($type, $typeclass);
    $type = $self->get_definitions()->first_types()->find_type( $ns, $localname );
    $typeclass = $self->get_resolver()->create_xsd_name($type);

    # set before to allow it to be used from inside _accept
    $self->set_typemap_entry($typeclass);

    $type->_accept($self) if ($ns ne 'http://www.w3.org/2001/XMLSchema');

    # set afterwards again (just to be sure...)
    $self->set_typemap_entry($typeclass);
    return $self;
}

sub visit_XSD_Element {
    my ( $self, $ident, $element ) = ( $_[0], ident $_[0], $_[1] );

    # warn "simpleType " . $element->get_name();
    my @path = @{ $path_of{ ${ $self } } };
    my $path = join '/', @path;
    my $parent = $typemap_of{ ${ $self } }->{ $path };

    # step down in tree
    $self->add_element_path( $element );

    # now call all possible variants.
    # They all just return if no argument is given,
    # and return $self on success.
    SWITCH: {
        my $name = $element->get_name();

        if ($element->get_type) {
            $self->process_referenced_type( $element->expand( $element->get_type() ) );
            last SWITCH;
        }

        # atomic simpleType typemap rule:
        # if we have a parent, use parent's sub-package.
        # if not, use element package.
        if ($element->get_simpleType()) {
            # warn "simpleType " . $element->get_name();
            my @path = @{ $path_of{ ${ $self } } };
            my $typeclass = $self->get_resolver()->create_subpackage_name($element);
            $self->set_typemap_entry($typeclass);
            $typeclass =~s{\.}{::}g;
            $typeclass =~s{\-}{_}g;
            last SWITCH;
        }

        # for atomic and complex types , and ref elements
        my $typeclass = $self->get_resolver()->create_subpackage_name($element);
        $self->set_typemap_entry($typeclass);

        if (my $complexType = $element->first_complexType()) {
            $complexType->_accept($self);
            last SWITCH;
        }

        # element ref handling
        if (my $ref = $element->get_ref()) {
            $element = $self->get_definitions()->first_types()->find_element(
                $element->expand($ref) );
            # we added a path too much - we should add the path of this
            # element instead.
            pop @{ $path_of{$ident} };
            $element->_accept($self);
            # and we must not pop it off now - thus, just return
            return;
        }
        die "Neither type nor ref in element >". $element->get_name ."<. Don't know what to do."
    };

    # Safety measure. If someone defines a top-level element with
    # a normal (not atomic) type, we just override it here
    if (not defined($parent)) {
        # for atomic and complex types , and ref elements
        my $typeclass = $self->get_resolver()->create_xsd_name($element);
        $self->set_typemap_entry($typeclass);
    }

    # step up in hierarchy
    pop @{ $path_of{$ident} };
}

sub visit_XSD_ComplexType {
    my ($self, $ident, $type) = ($_[0], ident $_[0], $_[1] );
    my $variety = $type->get_variety();
    my $derivation = $type->get_derivation();
    my $content_model = $type->get_contentModel;
    return if not $variety; # empty complexType
    return if ($content_model eq 'simpleContent');

    if ( grep { $_ eq $variety} qw(all sequence choice) )
    {
        # visit child elements
        for (@{ $type->get_element() || [] }) {
            $_->_accept( $self );
        }
    }
    # Only continue for derived types
    # Saves a uninitialized warning.
    return if not $derivation;

    if ($derivation eq 'restriction' ) {
        # TODO check and probably correct - this includes
        # all base type's elements in a restriction derivation.
        # Probably wrong.
        #
        # resolve base / get atomic type and run on elements
        if (my $type_name = $type->get_base()) {
            my $subtype = $self->get_definitions()
                ->first_types()->find_type( $type->expand($type_name) );
            # visit child elements
            for (@{ $subtype->get_element() || [] }) {
                $_->_accept( $self );
            }
        }
    }
    elsif ($derivation eq 'extension' ) {
        # resolve base / get atomic type and run on elements
        while (my $type_name = $type->get_base()) {
            $type = $self->get_definitions()
                ->first_types()->find_type( $type->expand($type_name) );
            # visit child elements
            for (@{ $type->get_element() || [] }) {
                $_->_accept( $self );
            }
        }
    }
}

1;

__END__

=pod

=head1 NAME

SOAP::WSDL::Generator::Visitor::Typemap - Visitor class for generating typemaps

=head1 DESCRIPTION

Visitor used by SOAP::WSDL's XSD generator for creating typemaps

=head1 AUTHOR

Replace the whitespace by @ for E-Mail Address.

 Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright 2008, 2009 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 Repository information

 $Id: WSDLParser.pm 770 2009-01-24 22:55:54Z kutterma $

 $LastChangedDate: 2009-01-24 23:55:54 +0100 (Sa, 24 Jan 2009) $
 $LastChangedRevision: 770 $
 $LastChangedBy: kutterma $

 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Expat/WSDLParser.pm $

