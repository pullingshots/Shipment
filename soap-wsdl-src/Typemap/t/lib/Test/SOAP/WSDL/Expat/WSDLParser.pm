#!perl
package Test::SOAP::WSDL::Expat::WSDLParser;
use strict;
use warnings;
use Test::More;
use Test::SOAP::WSDL::Tester;
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

sub parse_wsdl_schema :Test(1) {
    my $self = shift;
    ok my $wsdl = $self->parse_t_uri( "../imported/schema/wsdl11/wsdl.xsd");
}

sub parse_soap_binding :Test(1) {
    my $self = shift;
    ok my $wsdl = $self->parse_t_uri( "../imported/schema/wsdl11/soap_binding.xsd");
}

sub parse_http_binding :Test(1) {
    my $self = shift;
    ok my $wsdl = $self->parse_t_uri( "../imported/schema/wsdl11/http_binding.xsd");
}

sub parse_wsdl :Test(3) {
    my $self = shift;
    ok my $wsdl = $self->parse_t_uri( "acceptance/wsdl/WSDLParser.wsdl");
    my $schema = $wsdl->first_types()->get_schema()->[1];
    my $attr = $schema->get_element()->[0]->first_complexType->first_attribute();
    ok $attr->get_name('testAttribute');
    ok $attr->get_type('xs:string');

}

sub parse_wsdl_with_import :Test(8) {
    my $self = shift;
    ok my $wsdl = $self->parse_t_uri( "acceptance/wsdl/WSDLParser-import.wsdl");

    # Content checks
    is $wsdl->get_service()->[0]->get_name(),   'Service1',     'found service name';
    is $wsdl->get_portType->[0]->get_name(),    'Service1Soap', 'found portType name';
    is $wsdl->get_types()->[0]
        ->get_schema()->[1]
            ->get_element()->[0]->get_name(),   'sayHello',     'found element name';
    ok my $schema_from_ref = $wsdl->get_types()
        ->[0]->get_schema(), 'found schema';
    is @{ $schema_from_ref },                   2,              'got builtin and imported schema';
    ok @{ $schema_from_ref->[1]->get_element } > 0,             'found mi element in second schema';
    is $schema_from_ref->[1]
        ->get_element->[0]->get_name(),          'sayHello',     'found element name';
}

sub parse_wsdl_with_import_loop :Test(1) {
    my $self = shift;
    SKIP: {
        skip 'cannot test without Test::Warn', 1 if not $self->has_test_warn();
        my $wsdl;
        Test::Warn::warning_like
             { $wsdl = $self->parse_t_uri( "acceptance/wsdl/WSDLParser_import_loop.wsdl") }
            qr{file:///home/martin/workspace/SOAP-WSDL/t/acceptance/wsdl/import_loop.xsd \s already \s imported. \s Ignoring \s it}x,
            'warn about duplicate import';
    }
}
1;