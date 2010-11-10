package SOAP::WSDL::Generator::Visitor;
use strict;
use warnings;
use Class::Std::Fast::Storable;

use version; our $VERSION = qv('2.00.99_3');

my %definitions_of :ATTR(:name<definitions> :default<()>);
my %type_prefix_of :ATTR(:name<type_prefix> :default<()>);
my %element_prefix_of :ATTR(:name<element_prefix> :default<()>);

sub START {
    my ($self, $ident, $arg_ref) = @_;
    $type_prefix_of{ $ident } = 'MyType' if not exists
        $arg_ref->{ 'type_prefix' };
    $element_prefix_of{ $ident } = 'MyElement' if not exists
        $arg_ref->{ 'element_prefix' };

}


# WSDL stuff
sub visit_Definitions {}
sub visit_Binding {}
sub visit_Message {}
sub visit_Operation {}
sub visit_OpMessage {}
sub visit_Part {}
sub visit_Port {}
sub visit_PortType {}
sub visit_Service {}
sub visit_SoapOperation {}
sub visit_Types {}

# XML Schema stuff
sub visit_XSD_Schema {}
sub visit_XSD_ComplexType {}
sub visit_XSD_Element {}
sub visit_XSD_SimpleType {}

1;

__END__

=head1 NAME

SOAP::WSDL::Generator::Visitor - SOAP::WSDL's Visitor-based Code Generator

=head1 DESCRIPTION

SOAP::WSDL features a code generating facility. This code generation facility
(in fact there are several of them) is implemented as Visitor to
SOAP::WSDL::Base-derived objects.

=head2 The Visitor Pattern

The Visitor design pattern is one of the object oriented design pattern
described by [GHJV1995].

A Visitor is an object implementing some behaviour for a fixed set of classes,
whose implementation would otherwise need to be scattered accross those
classes' implementations.

Visitors are usually combined with Iterators for traversing either a list or
tree of objects.

A Visitor's methods are called using the so-called double dispatch technique.
To allow double dispatching, the Visitor implements one method for every class
to be handled, whereas every class implements just one method (commonly named
"access"), which does nothing more than calling a method on the reference
given, with the self object as parameter.

If all this sounds strange, maybe an example helps. Imagine you had a list of
person objects and wanted to print out a list of their names (or address
stamps or everything else you like). This can easily be implemented with a
Visitor:

    package PersonVisitor;
    use Class::Std;    # handles all basic stuff like constructors etc.

    sub visit_Person {
        my ( $self, $object ) = @_;
        print "Person name is ", $object->get_name(), "\n";
    }

    package Person;
    use Class::Std;
    my %name : ATTR(:name<name> :default<anonymous>);

    sub accept { $_[1]->visit_Person( $_[0] ) }

    package main;
    my @person_from = ();
    for (qw(Gamma Helm Johnson Vlissides)) {
        push @person_from, Person->new( { name => $_ } );
    }

    my $visitor = PersonVisitor->new();
    for (@person_from) {
        $_->accept($visitor);
    }

    # will print
    Person name is Gamma
    Person name is Helm
    Person name is Johnson
    Person name is Vlissides

While using this pattern for just printing a list may look a bit over-sized,
it may become handy if you need multiple output formats and different
classes to operate on.

The main benefits using visitors are:

=over

=item * Grouping related behaviour in one class

Related behaviour for several classes can be grouped together in the Visitor
class. The behaviour can easily be changed by changing the code in one class,
instead of having to change all the visited classes.

=item * Cleaning up the data classes' implementations

If classes holding data also implement several different output formats or
other (otherwise unrelated) behaviour, they tend to get bloated.

=item * Adding behaviour is easy

Swapping out the visitor class allows easy alterations of behaviour. So on a
list of Persons, one Visitor may print address stamps, while another one prints
out a phone number list.

=back

Of course, there are also drawbacks in the visitor pattern:

=over

=item * Changes in the visited classes are expensive

If one of the visited classes changes (or is added), all visitors must be
updated to reflect this change. This may be rather expensive if classes change
often.

=item * The visited classes must expose all data required

Visitors may need to use the internals of a class. This may result in fidelling
with a object's internals, or a bloated interface in the visited class.

=back

Visitors are usually accompanied by a Iterator. The Iterator may be implemented
in the visited classes, in the Visitor, or somewhere else (in the example it
was somewhere else).

The Iterator decides which object to visit next.

=head2 Why SOAP::WSDL uses the Visitor pattern for Code Generation

Code generation in SOAP::WSDL means generating various artefacts:

=over

=item * Typemaps

For every WSDL definition, a Typemap is created. The Typemap is used later as
an aid in parsing the SOAP XML messages.

=item * Type Classes

For every type defined in the WSDL's schema, a Type Class is generated.

These classes are instantiated later as a result of parsing SOAP XML messages.

=item * Interface Classes

For every service, a interface class is generated. This class is later used by
programmers accessing the service

=item * Documentation

Both Type Classes and Interface Classes include documentation. Additional
documentation may be generated as a hint for programmers, or later for
mimicing .NET's .asmx example pages.

=back

All these behaviours could well be (and have historically been) implemented in
the classes holding the WSDL data. This made these classes rather bloated, and
made it hard to change behaviour (like supporting SOAP Headers,
supporting atomic types, and other features which were missing from early
versions of SOAP::WSDL).

Implementing these behaviours in Visitor classes eases adding new behaviours,
and reducing the incompletenesses still inherent in SOAP::WSDL's WSDL and XML
schema implementation.

=head2 Implementation

=head3 accept

SOAP::WSDL::Base defines an accept method which expects a Visitor as only
parameter.

The method visit_Foo_Bar is called on the visitor, with the self object as
parameter.

The actual method name is constructed this way:

=over

=item * SOAP::WSDL is stripped from the class name

=item * All remaining  :: s are replaced by _

=back

Example:

When visiting a SOAP::WSDL::XSD::ComplexType object, the method
visit_XSD_ComplexType is called on the visitor.

=head2 Writing your own visitor

SOAP::WSDL eases writing your own visitor. This might be required if you need
some special output format from a WSDL file or want to feed your own
serializer/deserializer pair with custom configuration data. Or maybe you want
to generate C# code from it...

To write your own code generating visitor, you should subclass
SOAP::WSDL::Generator::Visitor. It implements (empty) default methods for all
SOAP::WSDL data classes:

=over

=item * visit_Definitions

=item * visit_Binding

=item * visit_Message

=item * visit_Operation

=item * visit_OpMessage

=item * visit_Part

=item * visit_Port

=item * visit_PortType

=item * visit_Service

=item * visit_SoapOperation

=item * visit_Types

=item * visit_XSD_Schema

=item * visit_XSD_ComplexType

=item * visit_XSD_Element

=item * visit_XSD_SimpleType

=back

In your Visitor, you must implement visit_Foo methods for all classes you wish
to visit.

The SOAP::WSDL::Generator::Visitor implementations include part of their own
Iterator (which means they know how to find the next objects to visit). You
may or may not choose to implement a separate Iterator.

Letting a visitor implementing its own Iterator visit a WSDL definition is as
easy as writing something like this:

 my $visitor = MyVisitor->new();
 my $parser = SOAP::WSDL::Expat::WSDLParser->new();
 my $definitions = $parser->parse_file('my.wsdl'):

 $definitions->_accept( $visitor );

If you need an iterator following the somewhat crude path of dependencies in
a WSDL1.1 definition, you might want to look at L<SOAP::WSDL::Generator::Iterator::WSDL11>.

=head1 REFERENCES

=over

=item * [GHJV1995]

Erich Gamma, Richard Helm, Ralph E. Johnson, John Vlissides, (1995):
Design Patterns. Elements of Reusable Object-Oriented Software.
Addison-Wesley Longman, Amsterdam.

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2008 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under the same
terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 391 $
 $LastChangedBy: kutterma $
 $Id: Client.pm 391 2007-11-17 21:56:13Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Client.pm $

=cut
