use Benchmark qw(cmpthese timethis timethese);
use POSIX ();
use Date::Format ();

my @time_from = localtime;

#use lib '../../lib';

use SOAP::WSDL::XSD::Typelib::Builtin::dateTime;

my $date = SOAP::WSDL::XSD::Typelib::Builtin::dateTime->new();
timethese 10000, {
 'sprintf' =>   sub { $date->set_value('Dec 24 2004 CET'); }
};

__END__

print "Comparing POSIX::strftime and Date::Format::strftime '%Y-%m-%dT%H:%M:%S%z'\n\n";
print 'POSIX: ', POSIX::strftime('%Y-%m-%dT%H:%M:%S%z', @time_from), "\n";
print 'Date::Format: ', Date::Format::strftime('%Y-%m-%dT%H:%M:%S%z', @time_from), "\n";


cmpthese 100000, {
    POSIX => sub { POSIX::strftime('%Y-%m-%dT%H:%M:%S%z', @time_from) },
    'Date::Format' => sub { Date::Format::strftime('%Y-%m-%dT%H:%M:%S%z', @time_from) },
};

__END__

results with perl-5.8.8 on Ubuntu 8.04 on a Thinkpad T42 (1.7GHz Dothan):

                 Rate Date::Format        POSIX
Date::Format  10684/s           --         -93%
POSIX        153846/s        1340%           --

