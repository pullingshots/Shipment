package SOAP::WSDL::Generator::PrefixResolver;
use strict; use warnings;

use Class::Std::Fast::Storable;

use version; our $VERSION = qv('2.00.99_3');

my %namespace_prefix_map_of :ATTR(:name<namespace_prefix_map>   :default<{}>);
my %namespace_map_of        :ATTR(:name<namespace_map>          :default<{}>);
my %prefix_of               :ATTR(:name<prefix> :default<{}>);

sub resolve_prefix {
    my ($self, $type, $namespace, $element) = @_;
    my $prefix;
    if (not defined($namespace)) {
        $prefix = $prefix_of{ $$self }->{ $type }
    }
    else {
        $prefix = $namespace_prefix_map_of{ $$self }->{ $namespace }
            || ( ($namespace_map_of{ $$self }->{ $namespace })
                ? join ('::', $prefix_of{ $$self }->{ $type }, $namespace_map_of{ $$self }->{ $namespace })
                : $prefix_of{ $$self }->{ $type }
            );
    }
    return "${prefix}::";
}

1;

__END__

=pod

=head1 NAME

SOAP::WSDL::Generator::PrefixResolver - prefixes for different classes

=head1 SYNOPSIS

If you want to create your custom prefix resolver:

 package MyPrefixResolver;
 use strict; use warnings;
 use base qw(SOAP::WSDL::Generator::PrefixResolver);

 sub resolve_prefix {
     my ($self, $type, $namespace, $node) = @_;
     # return something special
     return $self->SUPER::resolve_prefix($type, $namespace, $node);
 }

When generating code:

 use MyPrefixResolver;
 use SOAP::WSDL::Generator::XSD;
 my $generator = SOAP::WSDL::Generator::Template::XSD->new({
    prefix_resolver_class => 'MyPrefixResolver',
 });

=head1 DESCRIPTION

Prefix resolver class for SOAP::WSDL's code generator. You may subclass it to
apply some custom prefix resolving logic.

Subclasses must implement the following methods:

=over

=item * resolve_prefix

 sub resolve_prefix {
    my ($self, $namespace, $node) = @_;
    # ...
 }

resolve_prefix is expected to return a (perl class) prefix. It is called with
the following parameters:

 NAME       DESCRIPTION
 -----------------------------------------------------------------------------
 type       One of (server|interface|typemap|type|element|attribute)
 namespace  The targetNamespace of the node to generate a prefix for.
 node       The node to generate a prefix for

You usually just need type and namespace for prefix resolving. node is
provided for rather funky setups, where you have to choose different prefixes
based on type names or whatever.

Node may be of any of the following classes:

 SOAP::WSDL::Service
 SOAP::WSDL::XSD::Attribute
 SOAP::WSDL::XSD::Element
 SOAP::WSDL::XSD::Type

Note that both namespace and node may be undef - you should test for
definedness before doing anything fancy with them.

If you want your prefixes to represent perl class hierarchies, they should
end with '::'.

Example:

Imagine you're generating interfaces for the Acme Pet Shop. Acme Corp. has
set up their datatypes to be global across all interfaces (and products), while
elements are local to the product (the Pet Shop in the example).
All elements are in the urn:Acme namespace.

In addition, there are types in the namespace urn:Acme:Goods, which should go
into the same namespace as types, but be prefixed with 'Goods_'

You may want prefixes (roughly) like this:

 Interfaces:        Acme::Client::PetShop::
 Server:            Acme::Server::PetShop::
 Types:             Acme::Types::
 Types (Goods):     Acme::Types::Goods_
 Elements:          Acme::Elements::PetShop::
 Typemaps:          Acme::Typemaps::PetShop::

=back

=head1 BUGS AND LIMITATIONS

You cannot suffix your types by some rule yet...

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 583 $
 $LastChangedBy: kutterma $
 $Id: $
 $HeadURL: $

=cut
