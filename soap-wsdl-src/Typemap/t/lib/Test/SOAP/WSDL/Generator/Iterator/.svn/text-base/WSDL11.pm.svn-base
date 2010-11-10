#!perl
package Test::SOAP::WSDL::Generator::Iterator::WSDL11;
use strict;
use warnings;
use Test::More;
use SOAP::WSDL::Expat::WSDLParser;
use base qw(Test::SOAP::WSDL::Tester);

# It's a modulinho - it runs when executed...
if (! caller() ) {
    __PACKAGE__->runtests();
}
sub parse_t_uri {
    my $self = shift;
    my $parser = SOAP::WSDL::Expat::WSDLParser->new();
    return $parser->parse_uri($self->t_url() . '/'. shift);
}

sub iterate :Test() {
    my $self = shift;
    my $iter = SOAP::WSDL::Generator::Iterator::WSDL11->new();
    $iter->set_definitions($self->parse_t_uri( "acceptance/wsdl/WSDLParser.wsdl"));
    $iter->init();

    while (my $node = $iter->get_next()) {
        print $node, "\n";
    }
}

sub iterate_init :Test() {
    my $self = shift;
    my $iter = SOAP::WSDL::Generator::Iterator::WSDL11->new();
    $iter->set_definitions($self->parse_t_uri( "acceptance/wsdl/WSDLParser.wsdl"));
    $iter->init();

    for my $service (@{ $iter->get_definitions()->get_service() }) {
        while (my $node = $iter->get_next()) {
            print $node, "\n";
        }
    }
}

