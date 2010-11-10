package SOAP::WSDL::XSD::Typelib::Builtin::dateTime;

use strict;
use warnings;

use Date::Parse;
use Date::Format;


use Class::Std::Fast::Storable constructor => 'none', cache => 1;
use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);

sub set_value {

    # use set_value from base class if we have a XML-DateTime format
    #2037-12-31T00:00:00.0000000+01:00
    return $_[0]->SUPER::set_value( $_[1] ) if not defined $_[1];
    return $_[0]->SUPER::set_value( $_[1] )
      if (
        $_[1] =~ m{ ^\d{4} \- \d{2} \- \d{2}
            T \d{2} \: \d{2} \: \d{2} (:? \. \d{1,7} )?
            [\+\-] \d{2} \: \d{2} $
        }xms
      );

    # strptime sets empty values to undef - and strftime doesn't like that...
    my @time_from = strptime( $_[1] );

    die "Illegal date" if not defined $time_from[5];

    # strftime doesn't like undefs
    @time_from = map { !defined $_ ? 0 : $_ } @time_from;

    my $time_str;
    if ( $time_from[-1] ) {
        $time_str = sprintf(
            '%04d-%02d-%02dT%02d:%02d:%02d.0000000%+03d:%02d',
            $time_from[5] + 1900,
            $time_from[4] + 1,
            $time_from[3],
            $time_from[2],
            $time_from[1],
            $time_from[0],
            int( $time_from[6] / 3600 ),
            int( $time_from[6] % 3600 ) / 60
        );
    }
    else {
        $time_str = strftime( '%Y-%m-%dT%H:%M:%S%z', @time_from );
        substr $time_str, -2, 0, ':';
    }

    $_[0]->SUPER::set_value($time_str);
}

1;
