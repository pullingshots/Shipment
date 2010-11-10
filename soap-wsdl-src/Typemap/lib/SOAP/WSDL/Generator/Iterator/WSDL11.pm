package SOAP::WSDL::Generator::Iterator::WSDL11;
use strict; use warnings;
use Class::Std::Fast;

use version; our $VERSION = qv('2.00.99_3');

my %definitions_of  :ATTR(:name<definitions>    :default<[]>);
my %nodes_of        :ATTR(:name<nodes>          :default<[]>);

# memoization attributes
my %portType_of     :ATTR();
my %types_of        :ATTR();

my %METHOD_OF = (
    'SOAP::WSDL::Definitions'   => 'get_service',
    'SOAP::WSDL::Service'       => 'get_port',
    'SOAP::WSDL::Port'          => sub {
        my ($self, $node) = @_;
        return if ! $node->first_address()
            or ! $node->first_address()->isa('SOAP::WSDL::SOAP::Address');

        return [ $self->get_definitions()
            ->find_binding( $node->expand( $node->get_binding() ) ) || () ];
    },

    'SOAP::WSDL::Binding'       => sub {
        my ($self, $node) = @_;

        # remember referenced portType
        $portType_of{ ident $self } = $self->get_definitions()
            ->find_portType( $node->expand( $node->get_type ) )
            or return [];

        return $node->get_operation();
    },

    'SOAP::WSDL::Operation'     => sub {
        my ($self, $node) = @_;

        my $name = $node->get_name();

        # get the equally named operation from the portType
        my ($op) = grep { $_->get_name() eq $name }
            @{ $portType_of{ ident $self }->get_operation() }
            or return [];

        return [ @{ $op->get_input }, @{ $op->get_output }, @{ $op->get_fault } ]
    },

    'SOAP::WSDL::OpMessage' => sub {
        my ($self, $node) = @_;
        return if ( ref $node->get_parent() eq 'SOAP::WSDL::Binding' );    # we're in binding

        # TODO maybe allow more messages && overloading by specifying name

        return [ $self->get_definitions()->find_message(
            $node->expand( $node->get_message() )
        ) || () ];
    },

    'SOAP::WSDL::Message'       => 'get_part',

    'SOAP::WSDL::Part'          => sub {
        my ($self, $node) = @_;
        my $ident = ident $self;
        my $types = $types_of{ $ident } = $definitions_of{ $ident }->get_types()->[0]
            or return [];
        return [
            # If we have a type, this type is to be used in document/literal
            # as global type. However this is forbidden, at least by WS-I.
            # We should store the style/encoding somewhere, and regard it.
            # TODO: auto-generate element for RPC bindings
            $node->get_type()
                ? do {
                    die "unsupported global type <"
                        . $node->get_type . "> found in part <". $node->get_name() . ">\n"
                        . "Looks like a rpc/literal WSDL, which is not supported by SOAP::WSDL\n";
                    ## use this once we can auto-generate an element for RPC bindings
                    # $types->find_type( $node->expand($node->get_type) )
                }
                : (),
            $node->get_element()
                ? $types->find_element( $node->expand($node->get_element) )
                : (),
        ];
    },
);

sub init {
    my ($self, $arg_of) = @_;
    my $ident = ident $self;
    undef $portType_of{ $ident };
    undef $types_of{ $ident };
    $nodes_of{ $ident } = [
        exists($arg_of->{ node })
            ? $arg_of->{ node }
            : $definitions_of{ ident $self }
        ];
}

sub get_next {
    my $self = shift;
    my $ident = ident $self;

    my $node = shift @{ $nodes_of{ $ident }};
    return if ! defined $node;

    unshift @{ $nodes_of{ $ident }}, @{ $self->get_nextNodes( $node ) || [] };

    return $node;
}

sub get_nextNodes {
    my ($self, $node) = @_;

    my $method = $METHOD_OF{ ref $node }
        or return [];

    return (ref($method) eq 'CODE')
        ? $method->( $self, $node )
        : $node->can($method)->( $node );
}

1;

__END__

=pod

=head1 NAME

SOAP::WSDL::Generator::Iterator::WSDL11 - WSDL 1.1 Iterator

=head1 SYNOPSIS

 my $iter = SOAP::WSDL::Generator::Iterator::WSDL11->new({
     definitions => $wsdl
 });
 $iter->init();
 while (my $node = $iter->get_next()) {
     # do something with node - possibly call _accept with a visitor on it...
 }

=head1 DESCRIPTION

Iterator for walking a WSDL 1.1 definition.

The iterator performs a depth-first search along the following path:

 service
 port
 binding
 operation
 input/output/fault of operation in portType
 message
 part
 type/element in XML schema

If you wonder about this path: This is how to look up which XML Schema element
is associated with a operation from a service/port.

=head2 Example

The nodes are returned in the order denoted in the following example:

 <?xml version="1.0" encoding="UTF-8"?>
 <!-- 1 -->
 <definitions xmlns:http="http://schemas.xmlsoap.org/wsdl/http/"
   xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
   xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:s0="urn:HelloWorld"
   targetNamespace="urn:HelloWorld"
   xmlns="http://schemas.xmlsoap.org/wsdl/">
   <types>
     <s:schema elementFormDefault="qualified" targetNamespace="urn:HelloWorld">
       <!-- 9 -->
       <s:element name="sayHello">
         <s:complexType>
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1" name="name" type="s:string" />
              <s:element minOccurs="0" maxOccurs="1" name="givenName" type="s:string" nillable="1" />
            </s:sequence>
            <s:attribute name="testAttr" type="s:string" use="optional"></s:attribute>
          </s:complexType>
        </s:element>

        <!-- 13 -->
        <s:element name="sayHelloResponse">
          <s:complexType>
            <s:sequence>
              <s:element minOccurs="0" maxOccurs="1"
                name="sayHelloResult" type="s:string" />
           </s:sequence>
         </s:complexType>
       </s:element>
     </s:schema>
   </types>

   <!-- 7 -->
   <message name="sayHelloSoapIn">
     <!-- 8 -->
     <part name="parameters" element="s0:sayHello" />
   </message>

   <!-- 11 -->
   <message name="sayHelloSoapOut">
     <!-- 12 -->
     <part name="parameters" element="s0:sayHelloResponse" />
   </message>

   <portType name="Service1Soap">
     <operation name="sayHello">
     <!-- 6 -->
     <input message="s0:sayHelloSoapIn" />
     <!-- 10 -->
     <output message="s0:sayHelloSoapOut" />
   </operation>
  </portType>

    <!-- 4 -->
    <binding name="Service1Soap" type="s0:Service1Soap">
        <soap:binding transport="http://schemas.xmlsoap.org/soap/http"
            style="document" />

        <!-- 5 -->
        <operation name="sayHello">
            <soap:operation soapAction="urn:HelloWorld#sayHello"
                style="document" />

            <input>
                <soap:body use="literal" />
            </input>

            <output>
                <soap:body use="literal" />
            </output>
        </operation>
    </binding>

    <!-- 2 -->
    <service name="Service1">
        <!-- 3 -->
        <port name="Service1Soap" binding="s0:Service1Soap">
            <soap:address
                location="http://localhost:81/soap-wsdl-test/helloworld.pl" />
        </port>
    </service>
 </definitions>

You should not rely too much on this order - it may change. Even though the
current order will probably remain, the nodes currently skipped might
be returned somewhere along the path.


=head1 LICENSE AND COPYRIGHT

Copyright 2004-2008 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 239 $
 $LastChangedBy: kutterma $
 $Id: Client.pm 239 2007-09-11 09:45:42Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Client.pm $

=cut
