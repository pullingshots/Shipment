use strict;
use warnings;
use lib '../lib';
use Test::More tests => 9;
use Date::Parse;
use Date::Format;

sub timezone {
    # strptime sets empty values to undef - and strftime doesn't like that...
    # strptime doesn't like map iterators so we create an anon array
    my $tz = strftime('%z', @{[map { defined $_ ? $_ : 0 } strptime shift]} );
    substr $tz, -2, 0, ':';
    return $tz;
}

use_ok('SOAP::WSDL::XSD::Typelib::Builtin::dateTime');

print "# timezone is " . timezone( scalar localtime(time) ) . "\n";
my $obj;
my %dates = (
    '2007-12-31 12:32' => '2007-12-31T12:32:00',
    '2007-08-31 00:32' => '2007-08-31T00:32:00',
    '30 Aug 2007'      => '2007-08-30T00:00:00',
);

$obj = SOAP::WSDL::XSD::Typelib::Builtin::dateTime->new();
$obj = SOAP::WSDL::XSD::Typelib::Builtin::dateTime->new({});
$obj = SOAP::WSDL::XSD::Typelib::Builtin::dateTime->new({ value => '2007-08-31T00:32:00' });

while ( my ($date, $converted) = each %dates ) {
    $obj = SOAP::WSDL::XSD::Typelib::Builtin::dateTime->new();
    $obj->set_value( $date );

    local $^W;  # really turn off warnings for the next line
    is $obj->get_value() , $converted . timezone($date), 'conversion with timezone';
}
$obj->set_value('2007-12-31T00:00:00.0000000+01:00');
is $obj->get_value(), '2007-12-31T00:00:00.0000000+01:00';

$obj->set_value(undef);
is $obj->get_value(), undef;
eval { print $obj->set_value(0) };
ok $@, 'Die on illegal datetime ' . $@;
eval { print $obj->set_value('A') };
ok $@, 'Die on illegal datetime';
eval { print $obj->set_value('8') };
ok $@, 'Die on illegal datetime';
