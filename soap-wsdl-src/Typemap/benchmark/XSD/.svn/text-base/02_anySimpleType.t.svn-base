use strict;
use warnings;
use Benchmark;
use lib '../../lib';
use lib '../../../Class-Std-Fast/lib';

use SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType;

my $obj = SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType->new();

timethese 10000, {
    'new' => sub { SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType->new() },
    'new + params' => sub { SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType->new({
        value => 'Teststring',
    }) },
    'set_FOO' => sub { $obj->set_value('Test') },
};

my $data;
timethese 1000000, {
    'set_FOO' => sub { $obj->set_value('Test') },
    'get_FOO' => sub { $data = $obj->get_value() },
};

__END__

Benchmark: timing 10000 iterations of new, new + params, set_FOO...
       new:  0 wallclock secs ( 0.83 usr +  0.00 sys =  0.83 CPU) @ 12048.19/s (n=10000)
new + params:  1 wallclock secs ( 0.58 usr +  0.00 sys =  0.58 CPU) @ 17241.38/s (n=10000)
   set_FOO:  0 wallclock secs ( 0.01 usr +  0.00 sys =  0.01 CPU) @ 1000000.00/s (n=10000)
            (warning: too few iterations for a reliable count)
Benchmark: timing 1000000 iterations of get_FOO, set_FOO...
   get_FOO:  1 wallclock secs ( 1.79 usr +  0.01 sys =  1.80 CPU) @ 555555.56/s (n=1000000)
   set_FOO:  2 wallclock secs ( 1.44 usr +  0.03 sys =  1.47 CPU) @ 680272.11/s (n=1000000)

## Fast:
Benchmark: timing 10000 iterations of new, new + params, set_FOO...
       new:  1 wallclock secs ( 0.67 usr +  0.01 sys =  0.68 CPU) @ 14705.88/s (n=10000)
new + params:  1 wallclock secs ( 0.54 usr +  0.00 sys =  0.54 CPU) @ 18518.52/s (n=10000)
   set_FOO:  0 wallclock secs ( 0.01 usr +  0.00 sys =  0.01 CPU) @ 1000000.00/s (n=10000)
            (warning: too few iterations for a reliable count)
Benchmark: timing 1000000 iterations of get_FOO, set_FOO...
   get_FOO:  2 wallclock secs ( 1.11 usr +  0.00 sys =  1.11 CPU) @ 900900.90/s (n=1000000)
   set_FOO:  2 wallclock secs ( 0.80 usr +  0.00 sys =  0.80 CPU) @ 1250000.00/s (n=1000000)

## Fast qw(2);
Benchmark: timing 10000 iterations of new, new + params, set_FOO...
       new:  1 wallclock secs ( 0.17 usr +  0.00 sys =  0.17 CPU) @ 58823.53/s (n=10000)
            (warning: too few iterations for a reliable count)
new + params:  0 wallclock secs ( 0.19 usr +  0.00 sys =  0.19 CPU) @ 52631.58/s (n=10000)
            (warning: too few iterations for a reliable count)
   set_FOO:  0 wallclock secs ( 0.01 usr +  0.00 sys =  0.01 CPU) @ 1000000.00/s (n=10000)
            (warning: too few iterations for a reliable count)
Benchmark: timing 1000000 iterations of get_FOO, set_FOO...
   get_FOO:  1 wallclock secs ( 1.12 usr +  0.00 sys =  1.12 CPU) @ 892857.14/s (n=1000000)
   set_FOO:  0 wallclock secs ( 0.80 usr +  0.01 sys =  0.81 CPU) @ 1234567.90/s (n=1000000)

