#!perl
package Test::SOAP::WSDL::Generator::Visitor::Typemap;
use strict; use warnings;
use Test::More;
use base qw(Test::SOAP::WSDL::Tester);

# It's a modulinho - it runs when executed...
if (! caller() ) {
    __PACKAGE__->runtests();
}

sub a_constructor : Test( 1 ) {
    my $self = shift;
    ok my $obj = $self->get_class->new() ;
    $self->set_object( $self->get_class->new() );
}
