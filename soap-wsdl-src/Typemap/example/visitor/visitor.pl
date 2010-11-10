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


