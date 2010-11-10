package SOAP::WSDL::Types;
use strict;
use warnings;
use SOAP::WSDL::XSD::Schema::Builtin;
use Class::Std::Fast::Storable;
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

my %schema_of :ATTR(:name<schema> :default<[]>);

sub START {
    my ($self, $ident, $args_of) = @_;
    $self->push_schema( SOAP::WSDL::XSD::Schema::Builtin->new() );
    return $self;
}

sub find_type {
    my ($self, $ns, $name) = @_;
    ($ns, $name) = @{ $ns } if ref $ns;     # allow passing list refs
    print "Looking for type {$ns}$name\n" if ($SOAP::WSDL::Trace);
    foreach my $schema (@{ $schema_of{ ident $self } }) {
        my $type = $schema->find_type($ns, $name);
        return $type if $type;
    }
    return;
}

sub find_attribute {
    my ($self, $ns, $name) = @_;
    ($ns, $name) = @{ $ns } if ref $ns;     # allow passing list refs
    print "Looking for attribute {$ns}$name\n" if ($SOAP::WSDL::Trace);
    foreach my $schema (@{ $schema_of{ ident $self } }) {
        my $type = $schema->find_attribute($ns, $name);
        return $type if $type;
    }
    return;
}

sub find_element {
    my ($self, $ns, $name) = @_;
    ($ns, $name) = @{ $ns } if ref $ns;     # allow passing list refs
    print "Looking for element {$ns}$name\n" if ($SOAP::WSDL::Trace);
    foreach my $schema (@{ $schema_of{ ident $self } }) {
        print "\tin schema ", $schema->get_targetNamespace() ,"\n" if ($SOAP::WSDL::Trace);
        my $type = $schema->find_element($ns, $name);
        return $type if $type;
    }
    return;
}

1;
