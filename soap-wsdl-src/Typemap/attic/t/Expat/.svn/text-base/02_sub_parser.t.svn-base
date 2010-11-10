package TopElement;
use Class::Std::Storable;
use SOAP::WSDL::XSD::Typelib::Element;
use SOAP::WSDL::XSD::Typelib::ComplexType;
use Memoize;

memoize('_get_handlers');

use base qw(SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);
{
    my %TestElement_of :ATTR();
    my $CLASS_OF_REF = { TestElement => 'TestElement' };
    
    __PACKAGE__->_factory( [ 'TestElement' ], 
        { 'TestElement' => \%TestElement_of, },
        { TestElement => 'TestElement' },
    );
    
    sub get_xmlns { 'urn:Test' };
    __PACKAGE__->__set_name('TopElement');
    __PACKAGE__->__set_nillable(1);
    
    sub _get_handlers {
         my $self = shift;
         my $parser = shift;
         
         return {
             Start => $parser->start_tag({
                class_of => $CLASS_OF_REF,
                handler_of => {
                    TestElement => TestElement->_get_handlers( $parser ), 
                }            
             }),
             End => $parser->end_top_tag( ),
             Char => undef,
         };
    }
}
1;

package TestElement;
use Class::Std::Storable;
use SOAP::WSDL::XSD::Typelib::Element;
use SOAP::WSDL::XSD::Typelib::ComplexType;

use Memoize;
memoize('_get_handlers');

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

{
    my %test_of :ATTR();
    my %test2_of :ATTR();
    
    my $CLASS_OF_REF = { 
          test => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
          test2 => 'SOAP::WSDL::XSD::Typelib::Builtin::string'
    };
    
    __PACKAGE__->_factory( [ 'test', 'test2' ], 
        { test => \%test_of, test2 => \%test2_of, },
        $CLASS_OF_REF,
    );
    
    sub get_xmlns { 'urn:Test' };
    __PACKAGE__->__set_name('TestElement');
    __PACKAGE__->__set_nillable(1);
    
    sub _get_handlers {
         my $self = shift;
         my $parser = shift;
         
         return {
             Start => $parser->start_tag({
                class_of => $CLASS_OF_REF,
                handler_of => 
                {
                   map { ( $_ => $CLASS_OF_REF->{$_}->_get_handlers( $parser ) )} 
                        keys %{ $CLASS_OF_REF }
                }, 
             }),
             End => $parser->end_tag(),
             Char => undef,
         };
    }
}
1;

package TestResolver;

sub get_class {
    my $path = join('/', @{ $_[1] });
    my $class = {
        'TestElement' => 'TestElement',
        'TestElement/test' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'TestElement/test2' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'TopElement' => 'TopElement',
        'TopElement/TestElement' => 'TestElement',
        'TopElement/TestElement/test' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'TopElement/TestElement/test2' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    };
    return $class->{ $path }; 
}

1;

package main;

use Test::More qw/no_plan/; # TODO: change to tests => N;
use strict;
use warnings;
use lib '../../lib';

use_ok('SOAP::WSDL::Expat::MessageParser');
use_ok('SOAP::WSDL::Expat::MessageSubParser');
my $obj;

ok($obj = SOAP::WSDL::Expat::MessageSubParser->new(), "Object creation");

#my $test = $obj->start_tag({
#    order => [],
#    class_of => {
#        test => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
#        test2 => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
#    },
#    handler_of => {
#        test => {
#            Char => $obj->characters(),
#        },
#        test2 => {
#            Char => $obj->characters(),
#        },       
#    }
#});
#
#my $handlers = {
#    Start => $test,
#    End => $obj->end_tag(),
#};
#
#my $parser = $obj->initialize( $handlers );
#
#$parser->parsestring('<test>Test</test>');
#is $obj->get_data(), 'Test', 'Parse simple XML';
#
#my $element = $obj->start_tag({
#    order => [],
#    class_of => {
#        TestElement => 'TestElement',
#    },
#    handler_of => {
#        TestElement => {
#            Start => $obj->start_tag({
#                order => [],
#                class_of => {
#                    test => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
#                    test2 => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
#                },
#                handler_of => {
#                    test => {
#                        Char => $obj->characters(),
#                    },
#                    test2 => {
#                        Char => $obj->characters(),
#                    },       
#                }
#            }),
#            End => $obj->end_tag(),
#            Char => undef,
#        }
#    }
#});
#
#
#$handlers = {
#    Start => $element,
#    End => $obj->end_tag(),
#    Char => undef,
#};
#
#$parser = $obj->initialize( TestElement->_get_parser( $obj ) );
#
#my $xml = '<TestElement xmlns="urn:Test">
#    <test>Test</test>
#    <test2>Test2</test2>
#</TestElement>';
#
#$parser->parsestring($xml);
#
#is $obj->get_data()
#    , '<TestElement xmlns="urn:Test" ><test >Test</test ><test2 >Test2</test2 ></TestElement>'
#    , 'Parse && serialize ComplexType Element';
#

#my $mp = SOAP::WSDL::Expat::MessageParser->new({
#    class_resolver => 'TestResolver',
#});
#
#$mp->parse( $xml );

#use Benchmark;
#
#timethese 1000 , {
#    mp =>  sub { $mp->parse($xml) },
#    'sub_p' => sub { $obj->initialize( $handlers )->parse( $xml ) },
#
#};

#my $top = $obj->start_tag({
#    order => [],
#    class_of => {
#        TopElement => 'TopElement',
#    },
#    handler_of => {
#        TopElement => {
#            Start => $obj->start_tag({
#                order => [ 'TestElement', ],
#                class_of => {
#                    TestElement => 'TestElement',
#                },
#                handler_of => {
#                    TestElement => {
#                        Start => $obj->start_tag({
#                            order => ['test', 'test2'],
#                            class_of => {
#                                test => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
#                                test2 => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
#                            },
#                            handler_of => {
#                                test => {
#                                    Char => $obj->characters(),
#                                },
#                                test2 => {
#                                    Char => $obj->characters(),
#                                },       
#                            },
#                            occurs_of => {
#                                test => { max => 1 },
#                            }
#                        }),
#                        End => $obj->end_tag(),
#                        Char => undef,
#                    }
#                }
#            })
#        }
#    }
#});

my $top = $obj->start_tag({
    class_of => {
        TopElement => 'TopElement',
    },
    handler_of => {
        TopElement => TopElement->_get_handlers( $obj ),
    }
});

my $parser = $obj->initialize( { Start => $top , End => $obj->end_tag() , Char => undef } );

my $xml = '
<TopElement  xmlns="urn:Test">
    <TestElement>
        <test>Test</test>  
        <test2>Test2</test2>    
    </TestElement>
    <TestElement>
        <test>Test</test>
        <test2>Test2</test2>    
    </TestElement>
    <TestElement>
        <test>Test</test>
        <test2>Test2</test2>    
    </TestElement>
    <TestElement>
        <test>Test</test>  
        <test2>Test2</test2>    
    </TestElement>
    <TestElement>
        <test>Test</test>
        <test2>Test2</test2>    
    </TestElement>
    <TestElement>
        <test>Test</test>
        <test2>Test2</test2>    
    </TestElement>
</TopElement>';

$parser->parsestring($xml);

# print $obj->get_data();

__END__

# TODO factor out into benchmark suite

use XML::Simple;
use Benchmark;

my $mp = SOAP::WSDL::Expat::MessageParser->new({
    class_resolver => 'TestResolver',
});
$mp->parse( $xml );

$top = $obj->start_tag({
    class_of => {
        TopElement => 'TopElement',
    },
    handler_of => {
        TopElement => TopElement->_get_handlers( $obj ),
    }
});
my $top_end = $obj->end_top_tag();
$parser = $obj->initialize( { Start => $top , End => $top_end, , Char => undef } );
$parser->parse( $xml ),

print "DATA:" . $obj->get_data(), "\n";


# $XML::Simple::PREFERRED_PARSER = 'XML::SAX::Expat';
$XML::Simple::PREFERRED_PARSER = 'XML::Parser';

timethese 500 , {
    'typemap' =>  sub { $mp->parse($xml) },
    'sub_tree' => sub {            
            my $parser = $obj->initialize( { Start => $top , End => $top_end, , Char => undef } );
            $parser->parse( $xml ),
     },
     'XML::Simple' => sub { XMLin( $xml ); }
};
