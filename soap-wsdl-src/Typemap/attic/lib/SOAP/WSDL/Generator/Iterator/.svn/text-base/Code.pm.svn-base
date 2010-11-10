package SOAP::WSDL::Generator::Iterator::Code;
use strict;
use warnings;
use SOAP::WSDL::Generator::Iterator;
use base qw(SOAP::WSDL::Generator::Iterator);

sub walk_Definitions {
    my ($self, $definitions) = @_;
    $self->set_definitions( $definitions );
    
    $definitions->_accept( $self->get_visitor() );
    
    for ( @{ $definitions->get_message() }) {
        $self->walk_Message( $_ );
    }
    for ( @{ $definitions->get_service() } ) {
        $self->walk_Service( $_ );
    }
}

sub walk_Operation {
    my ($self, $operation) = @_;

    $operation->_accept( $self->get_visitor );

    foreach my $soap_operation(@{ $operation->get_operation() }){
        $soap_operation->_accept( $self->get_visitor() );
    }

    if (my $input = $operation->get_input()->[0]) {
        if (my $body = $input->get_body()->[0]) {        
            $body->_accept( $self->get_visitor() );
        }
        if (my $header = $input->get_header()->[0]) {
            $header->_accept( $self->get_visitor() );        
        }
        if (my $headerfault = $input->get_headerfault()->[0]) {
            $headerfault->_accept( $self->get_visitor() );        
        }
    }
    
}

1;