package SOAP::WSDL::XSD::Typelib::Builtin::time;
use strict;
use warnings;
use Date::Parse;
use Date::Format;
use Class::Std::Fast::Storable constructor => 'none', cache => 1;
use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);

use version; our $VERSION = qv('2.00.99_3');

sub set_value {
    # use set_value from base class if we have a XML-Time format
    # 00:00:00.0000000+01:00
    if (
        $_[1] =~ m{ ^ \d{2} \: \d{2} \: \d{2} (:? \. \d{1,7} )?
            [\+\-] \d{2} \: \d{2} $
        }xms
    ) {
        $_[0]->SUPER::set_value($_[1])
    }
    # use a combination of strptime and strftime for converting the date
    # Unfortunately, strftime outputs the time zone as [+-]0000, whereas XML
    # whants it as [+-]00:00
    # We leave out the optional nanoseconds part, as it would always be empty.
    else {
        # strptime sets empty values to undef - and strftime doesn't like that...
        # we even need to set it to 1 to prevent a "Day '0' out of range 1..31" warning..

        # we need to set the current date for correct TZ conversion -
        # could be daylight savings time
        my @now = localtime;
        my @time_from = map { my $alternative = shift @now;
            ! defined $_
                ? $alternative
                : $_ } strptime($_[1]);
        undef $time_from[-1];
        my $time_str = strftime( '%H:%M:%S%z', @time_from );
        substr $time_str, -2, 0, ':';
        $_[0]->SUPER::set_value($time_str);
    }
}

1;
