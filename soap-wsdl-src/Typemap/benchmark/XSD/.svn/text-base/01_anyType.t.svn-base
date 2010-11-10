use strict;
use warnings;
use Benchmark;
use lib '../../lib';
use SOAP::WSDL::XSD::Typelib::Builtin::anyType;

my $obj = SOAP::WSDL::XSD::Typelib::Builtin::anyType->new();

timethese 10000, {
    'new' => sub { SOAP::WSDL::XSD::Typelib::Builtin::anyType->new() },
};

