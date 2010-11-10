package SOAP::WSDL::Generator::Visitor::Code;
use strict;
use warnings;
use Class::Std::Storable;

use base qw(SOAP::WSDL::Generator::Visitor);

my %typemap_prefix_of       :ATTR(:name<typemap_prefix> :default<()>);
my %class_of                :ATTR(:name<class> :default<()>);
my %current_class_of        :ATTR(:name<current_class> :default<()>);
my %current_style_of        :ATTR();
my %current_service_of      :ATTR();
my %current_portType_of     :ATTR();
my %current_operation_of    :ATTR();
my %current_operation_info_of :ATTR();
my %message_parts_of        :ATTR();
my %message_part_order_of   :ATTR();

my %operation_of            :ATTR(:get<operation>);

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $typemap_prefix_of{ $ident } = 'MyTypemap::' if not exists 
        $arg_ref->{ 'typemap_prefix' };    
}

sub visit_Definitions {
    my ( $self, $definitions ) = @_;
    $self->set_definitions( $definitions ); 
}

# create a lookup table of message parts
# and their order.
# $message_parts_of = {
#    $message_name => [ @parts ]    
# }
sub visit_Message {
    
    my ($self, $message) = @_;
    my $ident = ident $self;
    
    my (%parts_of, @part_order_from) = ( () , () );
    my $definitions = $self->get_definitions();
    
    for my $part (@{ $message->get_part }) {

        my $part_name = '{'. $part->get_targetNamespace .'}'. $part->get_name;

        if (my $element_name = $part->get_element() ) {
            my ($ns, $localname) =  $definitions->_expand( $element_name );
            push @part_order_from, 
                 $parts_of{ $part_name } = $self->get_element_prefix . $localname;
        }
        elsif (my $type_name = $part->get_type() ) {
            my ($ns, $localname) =  $definitions->_expand( $type_name );
            push @part_order_from, 
                 $parts_of{ $part_name } = $self->get_type_prefix . $localname;
        }
    }
    
    my $message_name = '{' . $message->get_targetNamespace . '}' . $message->get_name;
    $message_parts_of{ $ident }->{ $message_name } = \%parts_of;
    $message_part_order_of{ $ident }->{ $message_name } = [ @part_order_from ];    
}

sub _start_interface {
    my ($self, $port) = @_;
    my $ident = ident $self;

    # TODO: factor out soap::location in extra class and visit this one...
    # maybe use different visitors for soap and http binding - 
    # maybe even retrieve them via a factory to be extensible...
    my $location = $port->get_location();

    my $class_resolver = $self->get_typemap_prefix() . $current_service_of{ $ident }->get_name();
    my $name = join q{}, $current_service_of{ $ident }->get_name(), '::', $port->get_name();

    $current_class_of{$ident} = $name;
    $class_of{ $ident }->{ $name }->{ location } = $location;
    $class_of{ $ident }->{ $name }->{ class_resolver } = $class_resolver;
}

sub visit_Service {
    my ($self, $ident, $service) = ($_[0], ident $_[0], $_[1]);
    $current_service_of{ $ident } = $service;
}

sub visit_Port {
    my ($self, $port) = @_;
    $self->_start_interface( $port );
}

sub visit_Binding {
    my ($self, $ident, $binding) = ($_[0], ident $_[0], $_[1]);

    # we ignore transport bindings for now
    # return if 
    #   $binding->get_transport() ne 'http://schemas.xmlsoap.org/soap/http';
    
    # remember style if set.
    $current_style_of{ $ident } = $binding->get_style();
    
    $current_portType_of{ $ident } = $self->get_definitions()->find_portType(
        $self->get_definitions()->_expand( $binding->get_type )
    );
}

# There's trouble. Operation serves two different purposes.
# Hmmm. Can we clean up ?
# Or do we need to switch to a map-based parser first?
# Or use a different visitor for the portType?
sub visit_Operation {
    my ($self, $ident, $operation) = ($_[0], ident $_[0], $_[1]);

    # remember current operation
    $current_operation_of{ $ident } = $operation;

    $current_operation_info_of{ $ident } = 
        $class_of{ $ident }->{ $current_class_of{ $ident } }->{ operations }->{ $operation->get_name() } = {};
    $current_operation_info_of{ $ident }->{ operation } = $operation->get_name();   
}

sub visit_SOAP_Body {
    my ($self, $ident, $body) = ($_[0], ident $_[0], $_[1]);

    my $definitions = $self->get_definitions();
    my $operation_name = $current_operation_of{$ident}->get_name();
    
    # the port operation is the one equally named
    my ($operation) =  grep { $_->get_name eq $operation_name }
        @{ $current_portType_of{ $ident }->get_operation() };

    my $message_name = '{' . join '}', $definitions->_expand(
        $operation->first_input()->get_message() );

    my $message_parts_from = $message_part_order_of{ $ident }->{ 
         $message_name };
    my $message_parts_ref =  $message_parts_of{ $ident }->{ 
         $message_name };
    my @part_name_from = split m{\s}xms , $body->get_parts();
    
    my %part_of = map {
        my ($ns,$local_name) = $definitions->_expand($_); 
        ($message_parts_ref->{ "{$ns}$local_name" } => undef)
    } @part_name_from;
    
    #warn $message_name;
    #use Data::Dumper;
    #warn Dumper $message_parts_of{ $ident };
    my @parts_from = (@part_name_from) 
        ? grep { exists $part_of{$_} } @{ $message_parts_from }
        : @{ $message_parts_from };

    $current_operation_info_of{ $ident }->{ body } = {
            encoding => $body->get_use(),
            namespace => $body->get_namespace(),
            encodingStyle => $body->get_encodingStyle(),
            parts => [ @parts_from ],
        };
}

sub visit_SOAP_Header {
    my ($self, $ident, $header) = ($_[0], ident $_[0], $_[1]);
    my $part_name = $header->get_part();
    my $definitions = $self->get_definitions();
    my ($ns, $local_name) = $definitions->_expand( $header->get_message() );
    my $message_name = "{$ns}$local_name";
    my $message_parts_ref = $message_parts_of{ $ident }->{ $message_name };
    
    ($ns,$local_name) = $definitions->_expand($part_name);
    my $part = $message_parts_ref->{ "{$ns}$local_name" };

    $current_operation_info_of{ $ident }->{ header } = {
            encoding => $header->get_use(),
            namespace => $header->get_namespace(),
            encodingStyle => $header->get_encodingStyle(),
            parts => [ $part ],
        };
}

sub visit_SOAP_HeaderFault {
    my ($self, $ident, $header) = ($_[0], ident $_[0], $_[1]);
    my $part_name = $header->get_part();
    my $definitions = $self->get_definitions();
    my ($ns, $local_name) = $definitions->_expand( $header->get_message() );
    my $message_name = "{$ns}$local_name";
    my $message_parts_ref = $message_parts_of{ $ident }->{ $message_name };
    
    ($ns,$local_name) = $definitions->_expand($part_name);
    my $part = $message_parts_ref->{ "{$ns}$local_name" };
    
    $current_operation_info_of{ $ident }->{ headerfault } = {
            encoding => $header->get_use(),
            namespace => $header->get_namespace(),
            encodingStyle => $header->get_encodingStyle(),
            parts => [ $part ],
        };
}

sub visit_SOAP_Operation {
    my ($self, $ident, $soap_operation) = ($_[0], ident $_[0], $_[1]);

    my $style = $soap_operation->get_style() || $current_style_of{ $ident };
    $current_operation_info_of{ $ident }->{ soap_action } =
        $soap_operation->get_soapAction();
    $current_operation_info_of{ $ident }->{ style } = $style; 
}

1;