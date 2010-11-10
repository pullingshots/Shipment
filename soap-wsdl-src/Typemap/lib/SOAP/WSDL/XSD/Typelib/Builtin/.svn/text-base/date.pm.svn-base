package SOAP::WSDL::XSD::Typelib::Builtin::date;
use strict;
use warnings;
use Date::Parse;
use Date::Format;

use Class::Std::Fast::Storable constructor => 'none', cache => 1;
use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);

sub set_value {
    # use set_value from base class if we have a XML-DateTime format
    #2037-12-31+01:00
    if (
        $_[1] =~ m{ ^\d{4} \- \d{2} \- \d{2}
            (:? [\+\-] \d{2} \: \d{2} )$
        }xms
    ) {
        $_[0]->SUPER::set_value($_[1])
    }
    # converting a date is hard work: It needs a timezone, because
    # 2007-12-30+12:00 and 2007-12-31-12:00 mean the same day - just in
    # different locations.
    # strftime actually prints out the correct date, but always prints the
    # local timezone with %z.
    # So, if our timezone is not 0, we strftime it without timezone and
    # append it by hand by the following formula:
    # The timezone hours are the int (timesone seconds / 3600)
    # The timezone minutes (if someone ever specifies something like that)
    # are int( (seconds % 3600) / 60 )
    # say, int( (seconds modulo 3600) / 60 )
    #
    # If we have no timezone (meaning the timezone is
    else {
        # strptime sets empty values to undef - and strftime doesn't like that...
        my @time_from =  strptime($_[1]);
        my $time_zone_seconds = $time_from[6];
        @time_from = map { (! defined $_) ? 0 : $_ } @time_from;
#        use Data::Dumper;
#        warn Dumper \@time_from, sprintf('%+03d%02d', $time_from[6] / 3600, $time_from[6] % 60 );
        my $time_str;
        if (defined $time_zone_seconds) {
            $time_str = sprintf('%04d-%02d-%02d%+03d:%02d', $time_from[5]+1900, $time_from[4]+1, $time_from[3], int($time_from[6] / 3600), int($time_from[6] % 3600) / 60);
        }
        else {
            $time_str = strftime( '%Y-%m-%d%z', @time_from );
            substr $time_str, -2, 0, ':';
        }

#          ? strftime( '%Y-%m-%d', @time_from )
#            . sprintf('%+03d%02d', int($time_from[6] / 3600), int ( ($time_from[6] % 3600) / 60 ) )
#          : do {
#              strftime( '%Y-%m-%d%z', @time_from );
#          };
#        substr $time_str, -2, 0, ':';
        $_[0]->SUPER::set_value($time_str);
    }
}

1;

