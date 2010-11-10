package SOAP::WSDL::Generator::Iterator;
use strict;
use warnings;
use Class::Std::Storable;

my %visitor_of      :ATTR(:name<visitor> :default<()>);
my %definitions_of  :ATTR(:name<definitions> :default<()> );

sub walk {
    my ($self, $definitions) = @_;
   
    $self->walk_Definitions( $definitions );    
}

sub walk_Definitions {
    my ($self, $definitions) = @_;

    $definitions_of{ ident $self } = $definitions;
    
    $definitions->_accept( $visitor_of{ ident $self } );
    
    for my $service ($definitions->get_service() ) {
        $self->walk_Service($service);
    }
}

sub walk_Service {
    my ($self, $service) = @_;
    $service->_accept( $visitor_of{ ident $self } );
    for my $port (@{ $service->get_port() }) {          
        $self->walk_Port( $port );
    }
}

sub walk_Port {
    my ($self, $port) = @_;
    
        # we only handle SOAP ports yet.
    return if not $port->first_address();
    return if not $port->first_address()->isa('SOAP::WSDL::SOAP::Address');
    
    
    $port->_accept( $visitor_of{ ident $self } );
            
    $self->walk_Binding( 
        $self->get_definitions()->find_binding( 
            $self->get_definitions()->_expand( $port->get_binding() )
        ) 
    );
}

sub walk_Binding {
    my ($self, $binding) = @_;
    $binding->_accept( $visitor_of{ ident $self } );
    for my $operation (@{ $binding->get_operation() }) {
        $self->walk_Operation( $operation );
    }
}

sub walk_Operation {
    my ($self, $operation) = @_;
    $operation->_accept( $visitor_of{ ident $self } );
}


sub walk_Message {
    my ($self, $message) = @_;
    $message->_accept( $visitor_of{ ident $self } );
}

1;