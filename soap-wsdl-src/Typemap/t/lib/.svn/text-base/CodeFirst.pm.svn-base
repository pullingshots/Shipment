package CodeFirst;
use Moose;
use Carp;
use Scalar::Util qw(blessed);
use XML::LibXML;

use parent qw(Attribute::Handlers);

our $VERSION = 0.1;

my %ACTION_MAP_OF;
my %ACTION_DATA_OF;
my %SCHEMA_DATA_OF;

has 'schema' => is => 'rw';

has 'typeMap' => is  => 'rw',
  isa         => 'CodeFirst::Types',
  default     => sub { CodeFirst::Types->new() };

sub WebMethod : ATTR {
    my (
        $class, $symbol, $referent, $attr,
        $data,  $phase,  $filename, $linenum
    ) = @_;

    my %parameter_of;
    eval { %parameter_of = @{$data} };
    if ($@) {
        die "Cannot parse :WebMethod arguments: $@ at " . Carp::shortmess;
    }

    $ACTION_MAP_OF{$class}->{$parameter_of{action}} = $symbol;

    $ACTION_DATA_OF{$class}->{$parameter_of{action}} = {
        name    => $parameter_of{name},
        request => {
            body   => $parameter_of{request_body},
            header => $parameter_of{request_header},
        },
        response => {
            body   => $parameter_of{response_body},
            header => $parameter_of{response_header},
        }};

    $SCHEMA_DATA_OF{$class}->{$parameter_of{request_header}} = undef
      if ( $parameter_of{request_header} );
    $SCHEMA_DATA_OF{$class}->{$parameter_of{request_body}} = undef
      if ( $parameter_of{request_body} );
    $SCHEMA_DATA_OF{$class}->{$parameter_of{response_header}} = undef
      if ( $parameter_of{response_header} );
    $SCHEMA_DATA_OF{$class}->{$parameter_of{response_body}} = undef
      if ( $parameter_of{response_body} );

    #use Data::Dumper;
    #print Dumper \%ACTION_DATA_OF;

    #return Class::Std::Fast::MODIFY_CODE_ATTRIBUTES( $class, $code,
    #		@attribute_from );
    return;    # @attribute_from;

}

sub get_wsdl {
    my $self    = shift;
    my $class   = ref $self;
    my $address = shift;

    my $className = $class;
    $className =~ s{::}{.}xg;
    my XML::LibXML::Document $doc = XML::LibXML::Document->new();
    my $root = XML::LibXML::Element->new("definitions");
    $root->setNamespace( 'http://schemas.xmlsoap.org/wsdl/',      undef,  1 );
    $root->setNamespace( 'http://www.w3.org/2001/XMLSchema',      'xs',   0 );
    $root->setNamespace( 'http://schemas.xmlsoap.org/wsdl/soap/', 'soap', 0 );
    $root->setNamespace( 'uri:MooseX.SOAP.' . $className,         'tns',  0 );
    $root->setAttribute( 'targetNamespace', 'uri:MooseX.SOAP.' . $className );

    $doc->setDocumentElement($root);

    my $type = XML::LibXML::Element->new('types');
    $root->appendChild($type);

    my $schema = $self->create_schema($className);
    $type->appendChild($schema);

    my $portType = XML::LibXML::Element->new('portType');
    $portType->setAttribute( 'name', $className . 'SOAP11' );

    my $binding = XML::LibXML::Element->new('binding');
    $binding->setAttribute( 'name', $className . 'SOAP11Binding' );
    $binding->setAttribute( 'type', 'tns:' . $className . 'SOAP11' );

    # 		<soap:binding transport="http://schemas.xmlsoap.org/soap/http"
    #		style="document" />
    my $soapBinding = XML::LibXML::Element->new('binding');
    $soapBinding->setNamespace( 'http://schemas.xmlsoap.org/wsdl/soap/',
        'soap', 1 );
    $soapBinding->setAttribute( 'transport',
        'http://schemas.xmlsoap.org/soap/http' );
    $soapBinding->setAttribute( 'style', 'document' );
    $binding->appendChild($soapBinding);

    for my $method ( keys %{$ACTION_DATA_OF{$class}} ) {

        my $methodName = $ACTION_DATA_OF{$class}->{$method}->{name};

        my $inElement = XML::LibXML::Element->new('element');
        $inElement->setAttribute( 'name', $methodName );
        $schema->appendChild($inElement);

        my $outElement = XML::LibXML::Element->new('element');
        $outElement->setAttribute( 'name', $methodName . 'Response' );
        $schema->appendChild($outElement);

        my $inMessage = XML::LibXML::Element->new('message');
        $inMessage->setAttribute( 'name', $methodName . 'SoapIn' );
        $root->appendChild($inMessage);

        my $inMessageBodyPart = XML::LibXML::Element->new('part');
        $inMessageBodyPart->setAttribute( 'name',    'input' );
        $inMessageBodyPart->setAttribute( 'element', 'tns:' . $methodName );
        $inMessage->appendChild($inMessageBodyPart);

        my $outMessage = XML::LibXML::Element->new('message');
        $outMessage->setAttribute( 'name', $methodName . 'SoapOut' );
        $root->appendChild($outMessage);

        my $outMessageBodyPart = XML::LibXML::Element->new('part');
        $outMessageBodyPart->setAttribute( 'name', 'output' );
        $outMessageBodyPart->setAttribute( 'element',
            'tns:' . $methodName . 'Response' );
        $outMessage->appendChild($outMessageBodyPart);

        my $portOperation = XML::LibXML::Element->new('operation');
        $portOperation->setAttribute( 'name', $methodName );
        $portType->appendChild($portOperation);

        my $inputMessage = XML::LibXML::Element->new('input');
        $inputMessage->setAttribute( 'message',
            'tns:' . $methodName . 'SoapIn' );
        $portOperation->appendChild($inputMessage);

        my $outputMessage = XML::LibXML::Element->new('output');
        $outputMessage->setAttribute( 'message',
            'tns:' . $methodName . 'SoapOut' );
        $portOperation->appendChild($outputMessage);

        my $bindingOperation = XML::LibXML::Element->new('operation');
        $bindingOperation->setAttribute( 'name', $methodName );
        $binding->appendChild($bindingOperation);

        my $soapOperation = XML::LibXML::Element->new('operation');
        $soapOperation->setNamespace( 'http://schemas.xmlsoap.org/wsdl/soap/',
            'soap', 1 );
        $soapOperation->setAttribute( 'soapAction', $method );
        $soapOperation->setAttribute( 'style',      'document' );

        $bindingOperation->appendChild($soapOperation);

        my $bindingInput = XML::LibXML::Element->new('input');
        $bindingOperation->appendChild($bindingInput);
        my $soapInputBody = XML::LibXML::Element->new('body');
        $soapInputBody->setNamespace( 'http://schemas.xmlsoap.org/wsdl/soap/',
            'soap', 1 );
        $soapInputBody->setAttribute( 'use', 'literal' );
        $bindingInput->appendChild($soapInputBody);

        my $bindingOutput = XML::LibXML::Element->new('output');
        $bindingOperation->appendChild($bindingOutput);

        my $soapOutputBody = XML::LibXML::Element->new('body');
        $soapOutputBody->setNamespace(
            'http://schemas.xmlsoap.org/wsdl/soap/',
            'soap', 1 );
        $soapOutputBody->setAttribute( 'use', 'literal' );
        $bindingOutput->appendChild($soapOutputBody);

    }
    $root->appendChild($portType);
    $root->appendChild($binding);

    my $service = XML::LibXML::Element->new('service');
    $service->setAttribute( 'name', $className );
    $root->appendChild($service);

    my $port = XML::LibXML::Element->new('port');
    $port->setAttribute( 'name',    $className . 'PortSOAP' );
    $port->setAttribute( 'binding', 'tns:' . $className . 'SOAP11Binding' );

    my $soapAddress = XML::LibXML::Element->new('address');
    $soapAddress->setNamespace( 'http://schemas.xmlsoap.org/wsdl/soap/',
        'soap', 1 );
    $soapAddress->setAttribute( 'location', $address );

    $port->appendChild($soapAddress);

    $service->appendChild($port);

    $self->schema($schema);

    return $doc;
}

sub create_schema {
    my ( $self, $className ) = @_;

    my $class = ref $self;

    my $schema = XML::LibXML::Element->new('schema');
    $schema->setAttribute( 'targetNamespace',
        'uri:MooseX.SOAP.' . $className );
    $schema->setNamespace( 'http://www.w3.org/2001/XMLSchema', undef, 1 );
    $schema->setNamespace( 'http://www.w3.org/2001/XMLSchema', 'xs',  0 );
    $schema->setNamespace( 'uri:MooseX.SOAP.' . $className,    'tns', 0 );

    for my $type ( keys %{$SCHEMA_DATA_OF{$class}} ) {
        eval "require $type";
        $schema->appendChild( $self->create_xsd_type($type) );
    }
    return $schema;
}

sub create_xsd_type {
    my $self = shift;
    my $type = shift;

    my $name = $type;
    $name =~ s{::}{\.}xg;

    my $node = XML::LibXML::Element->new('complexType');
    $node->setNamespace( 'http://www.w3.org/2001/XMLSchema', undef, 1 );
    $node->setAttribute( 'name', $name );

    my $sequence = XML::LibXML::Element->new('sequence');
    $node->appendChild($sequence);

    my $typeMap = $self->typeMap->types();

    for my $attribute ( reverse $type->meta()->get_all_attributes() ) {
        my $attributeNode = XML::LibXML::Element->new('element');
        $attributeNode->setAttribute( 'name', $attribute->name );
        $attributeNode->setAttribute( 'type',
            $typeMap->{$attribute->type_constraint} );
        $sequence->appendChild($attributeNode);
    }
    return $node;
}

1;

