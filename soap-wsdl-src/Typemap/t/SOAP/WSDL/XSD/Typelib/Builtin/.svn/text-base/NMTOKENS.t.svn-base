use Test::More tests => 8;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::NMTOKENS;
my $NMTOKENS = SOAP::WSDL::XSD::Typelib::Builtin::NMTOKENS->new();
is $NMTOKENS->get_value(), undef, 'get undef value';
$NMTOKENS = SOAP::WSDL::XSD::Typelib::Builtin::NMTOKENS->new({});
is $NMTOKENS->get_value(), undef, 'get undef value after new with {}';
ok $NMTOKENS = SOAP::WSDL::XSD::Typelib::Builtin::NMTOKENS->new({ value => [ 127 , 'Test' ] });

is $NMTOKENS->serialize(), '127 Test', 'stringification';

ok $NMTOKENS = SOAP::WSDL::XSD::Typelib::Builtin::NMTOKENS->new({ value => 'Test' })
    , 'constructor';
is "$NMTOKENS", "Test", 'stringification';

$NMTOKENS = SOAP::WSDL::XSD::Typelib::Builtin::NMTOKENS->new({ value => undef });

#{
#    my $found = 0;
#    local $SIG{__WARN__} = sub {
#        # die $_[0];
#        $found++ if $_[0] =~m{Use \s of \s uninitialized \s value}x;
#    };
#    ok ! "$NMTOKENS";
#    is $found, 1;
#}

ok $NMTOKENS->isa('SOAP::WSDL::XSD::Typelib::Builtin::NMTOKEN'), 'inheritance';
ok $NMTOKENS->isa('SOAP::WSDL::XSD::Typelib::Builtin::list'), 'inheritance';
