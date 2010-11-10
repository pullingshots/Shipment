#!/usr/bin/perl -w
use strict;
use warnings;
use Test::More tests => 12;
use lib '../../../../lib';
use lib '../../../../t/lib';
use lib 't/lib';
use lib '../lib';
use lib 'lib';

use_ok(qw/SOAP::WSDL::Expat::MessageParser/);

use MyComplexType;
use MyElement;
use MySimpleType;
use MySimpleElement;

test_attrs();
test_nil();
test_complex_element();
test_complex_skip_element();
test_typemap();
test_skip_typemap();
test_unresolved();

test_xsi_type();
test_simple_element();

# data classes reside in t/lib/Typelib/
BEGIN {
    package FakeResolver;
    {
        my %class_list = (
            'MyAtomicComplexTypeElement' => 'MyAtomicComplexTypeElement',
            'MyAtomicComplexTypeElement/test' => 'MyTestElement',
            'MyAtomicComplexTypeElement/test2' => 'MyTestElement2',
            'MyAtomicComplexTypeElement/foo' => '__SKIP__',
            'MyElementAttrs' => 'MyElementAttrs',
            'MyElementAttrs/test' => 'MyTestElement',
            'MyElementAttrs/test2' => 'MyTestElement2',
            'MySimpleElement' => 'MySimpleElement',
        );

        sub new { return bless {}, 'FakeResolver' };

        sub get_typemap { return \%class_list };

        sub get_class {
            my $name = join('/', @{ $_[1] });
            return ($class_list{ $name }) ? $class_list{ $name }
                : undef;
        };
    };
};

sub test_nil {
    my $parser = SOAP::WSDL::Expat::MessageParser->new({
        body_parts => [ 'MyElementAttrs' ],
    });

    my $xml_nil_attr = q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body><MyElementAttrs xmlns="urn:Test">
    <test>Test</test>
    <test2 xsi:nil="1"/>
    </MyElementAttrs></SOAP-ENV:Body></SOAP-ENV:Envelope>};

    my $result = $parser->parse($xml_nil_attr);
    is $result->get_test2->serialize({ name => 'test2'}), '<test2 xsi:nil="true"/>';
}

sub test_complex_element {
    my $xml = q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
        <SOAP-ENV:Body><MyAtomicComplexTypeElement xmlns="urn:Test" >
            <test>Test</test>
            <test2 >Test2</test2>
        </MyAtomicComplexTypeElement>
    </SOAP-ENV:Body></SOAP-ENV:Envelope>};

    my $parser = SOAP::WSDL::Expat::MessageParser->new({
        body_parts => [ 'MyAtomicComplexTypeElement' ],
    });

    $parser->parse( $xml );

    is $parser->get_data(), q{<MyAtomicComplexTypeElement xmlns="urn:Test">}
        . q{<test>Test</test><test2>Test2</test2></MyAtomicComplexTypeElement>}
        , 'Content comparison';
}

sub test_complex_skip_element {
    my $xml = q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
        <SOAP-ENV:Body><MyAtomicComplexTypeElement xmlns="urn:Test" >
            <test>Test</test>
            <test2 >Test2</test2>
            <test3 >Test2</test3>
        </MyAtomicComplexTypeElement>
    </SOAP-ENV:Body></SOAP-ENV:Envelope>};

    my $parser = SOAP::WSDL::Expat::MessageParser->new({
        body_parts => [ 'MyAtomicComplexTypeElement' ],
        strict => 0,
    });

    is $parser->{ strict }, 0;
    $parser->parse( $xml );

    is $parser->get_data(), q{<MyAtomicComplexTypeElement xmlns="urn:Test">}
        . q{<test>Test</test><test2>Test2</test2></MyAtomicComplexTypeElement>}
        , 'Content comparison';
}

sub test_typemap {
    my $xml = q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
        <SOAP-ENV:Body><MyAtomicComplexTypeElement xmlns="urn:Test" >
            <test>Test</test>
            <test2 >Test2</test2>
        </MyAtomicComplexTypeElement>
    </SOAP-ENV:Body></SOAP-ENV:Envelope>};

    my $parser = SOAP::WSDL::Expat::MessageParser->new({
        class_resolver => 'FakeResolver',
    });

    $parser->parse( $xml );

    is $parser->get_data(), q{<MyAtomicComplexTypeElement xmlns="urn:Test">}
        . q{<test>Test</test><test2>Test2</test2></MyAtomicComplexTypeElement>}
        , 'Content comparison';
}

sub test_skip_typemap {
    my $xml = q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
        <SOAP-ENV:Body><MyAtomicComplexTypeElement xmlns="urn:Test" >
            <test>Test</test>
            <test2 >Test2</test2>
            <test3 >Test2</test3>
        </MyAtomicComplexTypeElement>
    </SOAP-ENV:Body></SOAP-ENV:Envelope>};

    my $parser = SOAP::WSDL::Expat::MessageParser->new({
        class_resolver => 'FakeResolver',
        strict => 0,
    });

    $parser->parse( $xml );

    is $parser->get_data(), q{<MyAtomicComplexTypeElement xmlns="urn:Test">}
        . q{<test>Test</test><test2>Test2</test2></MyAtomicComplexTypeElement>}
        , 'Content comparison';
}

sub test_xsi_type {
    my $xml = q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
        xmlns:tns="urn:Test" >
        <SOAP-ENV:Body><MyAtomicComplexTypeElement xmlns="urn:Test" >
            <test xsi:type="tns:MyFooBar">
                <bar>1</bar>
                <foo>2</foo>
            </test>
            <test2 >Test2</test2>
        </MyAtomicComplexTypeElement>
    </SOAP-ENV:Body></SOAP-ENV:Envelope>};

    my $parser = SOAP::WSDL::Expat::MessageParser->new({
        body_parts => [ 'MyAtomicComplexTypeElement' ],
        prefix_resolver => SOAP::WSDL::Generator::PrefixResolver->new({
            namespace_prefix_map => {
                'urn:Test' => 'My',
            }
        }),
    });

    $parser->parse( $xml );

    my $body = $parser->get_data();
    is $body->get_test()->get_bar(), 1, 'xsi:type element value';
    is $body->get_test()->get_foo(), 2, 'xsi:type element value';
}

sub test_xsi_type_unqualified {
    my $xml = q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
        <SOAP-ENV:Body><MyAtomicComplexTypeElement xmlns="urn:Test" >
            <test xsi:type="MyFooBar">
                <bar>1</bar>
                <foo>2</foo>
            </test>
            <test2 >Test2</test2>
        </MyAtomicComplexTypeElement>
    </SOAP-ENV:Body></SOAP-ENV:Envelope>};

    my $parser = SOAP::WSDL::Expat::MessageParser->new({
        body_parts => [ 'MyAtomicComplexTypeElement' ],
    });

    $parser->parse( $xml );

    my $body = $parser->get_data();
    is $body->get_test()->get_bar(), 1, 'xsi:type element value';
    is $body->get_test()->get_foo(), 2, 'xsi:type element value';
}


sub test_attrs {
    my $xml_attr = q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
        <SOAP-ENV:Body><MyElementAttrs xmlns="urn:Test" test="Test" test2="Test2">
        <test>Test</test>
        <test2></test2>
        </MyElementAttrs></SOAP-ENV:Body></SOAP-ENV:Envelope>};

    my $parser = SOAP::WSDL::Expat::MessageParser->new({
        body_parts => [ 'MyElementAttrs' ],
    });

    $parser->parse($xml_attr);

    is $parser->get_data(),
        q{<MyElementAttrs xmlns="urn:Test" test="Test" test2="Test2"><test>Test</test><test2></test2></MyElementAttrs>},
        'Content with attributes';

}

sub test_unresolved {
    my $parser = SOAP::WSDL::Expat::MessageParser->new({
            body_parts => [ 'MyElementAttrs' ],
    });

    my $xml_error = q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
        <SOAP-ENV:Body><MyElementAttrs xmlns="urn:Test" test="Test" test2="Test2">
        <test>Test</test>
        <test2 ></test2>
        <foo>Bar</foo>
        </MyElementAttrs></SOAP-ENV:Body></SOAP-ENV:Envelope>};

    eval { $parser->parse($xml_error) };
    like $@, qr{\A Cannot \s resolve \s class \s for \s element \s foo }x, 'XML error';
}


sub test_simple_element {
    my $parser = SOAP::WSDL::Expat::MessageParser->new({
            body_parts => [ 'MySimpleElement' ],
    });

    my $body = $parser->parse(
        q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
        <SOAP-ENV:Body><MySimpleElement xmlns="urn:Test">3</MySimpleElement></SOAP-ENV:Body></SOAP-ENV:Envelope>});
    is $body->get_value(), 3;
}