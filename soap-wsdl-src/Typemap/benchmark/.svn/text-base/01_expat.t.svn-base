#!/usr/bin/perl -w
use strict;
use warnings;
use lib '../lib';
use lib '../../Class-Std-Fast/lib';
use lib '/home/martin/workspace/SOAP-WSDL_XS-local/blib/lib';
use lib '/home/martin/workspace/SOAP-WSDL_XS-local/blib/arch';
use lib '../t/lib';
# use SOAP::WSDL::SAX::MessageHandler;

#use Class::Std::Fast_XS;

use Benchmark qw(cmpthese timethese);
use SOAP::WSDL::Expat::MessageParser;
use SOAP::WSDL::Expat::Message2Hash;
use SOAP::WSDL::Expat::MessageParser_XS;
use SOAP::WSDL::Deserializer::XSD_XS;
use SOAP::Lite;
use XML::Simple;
use XML::LibXML;
use MyComplexType;
use MyElement;
use MySimpleType;

my $xml = q{<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body>
    <MyAtomicComplexTypeElement xmlns="urn:Test" >
        <test2 >Test2</test2>
        <test2 >Test3</test2>
        <test2 >Test4</test2>
        <test2 >Test5</test2>
        <test2 >Test6</test2>
        <test2 >Test7</test2>
        <test2 >Test8</test2>
        <test2 >Test9</test2>
        <test2 >Test10</test2>
        <test2 >Test11</test2>
        <test2 >Test12</test2>
        <test2 >Test13</test2>
        <test2 >Test55</test2>
        <test2 >Test14</test2>
        <test2 >Test15</test2>
        <test2 >Test16</test2>
        <test2 >Test17</test2>
        <test2 >Test18</test2>
        <test2 >Test19</test2>
        <test2 >Test20</test2>
        <test2 >Test21</test2>
        <test2 >Test22</test2>
        <test2 >Test23</test2>
        <test2 >Test24</test2>
        <test2 >Test25</test2>
        <test2 >Test565</test2>
        <test2 >Test27</test2>
        <test2 >Test28</test2>
        <test2 >Test29</test2>
        <test2 >Test30</test2>
        <test2 >Test31</test2>
        <test2 >Test32</test2>
        <test2 >Test33</test2>
        <test2 >Test34</test2>
        <test2 >Test35</test2>
        <test2 >Test36</test2>
        <test2 >Test37</test2>
        <test2 >Test38</test2>
        <test2 >Test55</test2>
    </MyAtomicComplexTypeElement>
</SOAP-ENV:Body></SOAP-ENV:Envelope>};



my $parser = SOAP::WSDL::Expat::MessageParser->new({
    class_resolver => 'FakeResolver',
	body_parts => [ qw(MyAtomicComplexTypeElement) ],
});

my $hash_parser = SOAP::WSDL::Expat::Message2Hash->new();

$XML::Simple::PREFERRED_PARSER = 'XML::Parser';

print "xml length: ${ \length $xml } bytes\n";

my $libxml = XML::LibXML->new();
$libxml->keep_blanks(0);
my @data;

my $deserializer = SOAP::Deserializer->new();

my $parser_xs = SOAP::WSDL::Deserializer::XSD_XS->new({
    class_resolver => 'FakeResolver',
	response_body_parts => [ qw(MyAtomicComplexTypeElement) ],
});

#print SOAP::WSDL::Expat::MessageParser_XS::_parse_string($xml,
#    { MyAtomicComplexTypeElement => 'MyAtomicComplexTypeElement' }
#);
#print $parser_xs->deserialize($xml);
# exit;

sub libxml_test {
        my $dom = $libxml->parse_string( $xml );
        push @data, dom2hash( $dom->firstChild );
};

sub dom2hash {
    for ($_[0]->childNodes) {
        if (exists $_[1]->{ $_->nodeName }) {
            if (ref $_[1]->{ $_->nodeName } eq 'ARRAY') {
                if ($_->nodeName eq '#text') {
                    push @{ $_[1] } ,$_->textContent;
                }
                else {
                    push @{ $_[1]->{ $_->nodeName } }, dom2hash( $_, {} );
                }
            }
            else {
                if ($_->nodeName eq '#text') {
                    $_[1] = [ $_[1], $_->textContent() ];
                }
                else {
                    $_[1]->{ $_->nodeName } = [ $_[1]->{ $_->nodeName } ,
                        dom2hash( $_, {} ) ];
                }
            }
        }
        else {
            if ($_->nodeName eq '#text') {
                $_[1] = $_->textContent();
            }
            else {
                $_[1]->{ $_->nodeName } = dom2hash( $_, {} );
            }
        }
    }
    return $_[1];
}

cmpthese 5000,
{
#  'SOAP::WSDL (Hash)' => sub { push @data, $hash_parser->parse( $xml ) },
  'SOAP::WSDL (XSD)' => sub { push @data, $parser->parse( $xml ) },
  'SOAP::WSDL_XS (XSD)' => sub { push @data, SOAP::WSDL::Expat::MessageParser_XS::_parse_string($xml,
    { MyAtomicComplexTypeElement => 'MyAtomicComplexTypeElement' } ) },
#  'XML::Simple (Hash)' => sub { push @data, XMLin $xml },
  'XML::LibXML (DOM)' => sub { push @data,  $libxml->parse_string( $xml ) },
  'XML::LibXML (Hash)' => \&libxml_test,
#  'SOAP::Lite' => sub { push @data, $deserializer->deserialize( $xml ) },
};

# data classes reside in t/lib/Typelib/
BEGIN {
    package FakeResolver;
    {
        my %class_list = (
            'MyAtomicComplexTypeElement' => 'MyAtomicComplexTypeElement',
            'MyAtomicComplexTypeElement/test2' => 'MyTestElement2',
        );

        sub get_typemap { return \%class_list; };

        sub get_map { return \%class_list };

        sub new { return bless {}, 'FakeResolver' };

        sub get_class {
            my $name = join('/', @{ $_[1] });
            return ($class_list{ $name }) ? $class_list{ $name }
                : warn "no class found for $name";
        };
    };
};


__END__

Output on my machine:

 xml length: 641 bytes
                       Rate SOAP::Lite XML::Simple (Hash) SOAP::WSDL (XSD) XML::LibXML (Hash) SOAP::WSDL (Hash) SOAP::WSDL_XS (XSD) XML::LibXML (DOM)
 SOAP::Lite            446/s         --               -54%             -72%               -73%              -80%                -95%              -96%
 XML::Simple (Hash)    963/s       116%                 --             -39%               -41%              -57%                -89%              -91%
 SOAP::WSDL (XSD)     1587/s       256%                65%               --                -3%              -29%                -81%              -86%
 XML::LibXML (Hash)   1629/s       265%                69%               3%                 --              -27%                -81%              -85%
 SOAP::WSDL (Hash)    2222/s       398%               131%              40%                36%                --                -74%              -80%
 SOAP::WSDL_XS (XSD)  8475/s      1798%               780%             434%               420%              281%                  --              -24%
 XML::LibXML (DOM)   11111/s      2389%              1053%             600%               582%              400%                 31%                --

xml length: 1481 bytes
                      Rate SOAP::WSDL (XSD) XML::LibXML (Hash) SOAP::WSDL_XS (XSD) XML::LibXML (DOM)
SOAP::WSDL (XSD)     424/s               --               -36%                -90%              -95%
XML::LibXML (Hash)   662/s              56%                 --                -84%              -92%
SOAP::WSDL_XS (XSD) 4098/s             867%               519%                  --              -48%
XML::LibXML (DOM)   7812/s            1744%              1080%                 91%                --
