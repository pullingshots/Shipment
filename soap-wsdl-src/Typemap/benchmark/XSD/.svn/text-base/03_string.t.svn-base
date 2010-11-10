use strict;
use warnings;
use Benchmark;
use lib '../../lib';
use lib '../../../Class-Std-Fast/lib';

use SOAP::WSDL::XSD::Typelib::Builtin::string;

my $obj = SOAP::WSDL::XSD::Typelib::Builtin::string->new();

timethese 20000, {
    'new' => sub { SOAP::WSDL::XSD::Typelib::Builtin::string->new() },
    'new + params' => sub { SOAP::WSDL::XSD::Typelib::Builtin::string->new({
            value => 'Teststring',
        })
    },
};

$obj->set_value('Foobar');
timethese 20000, {
    serialize => sub { $obj->serialize() }
};

my $data;
timethese 1000000, {
    'set_FOO' => sub { $obj->set_value('Test') },
    'get_FOO' => sub { $data = $obj->get_value() },
};



__END__

Benchmark: timing 20000 iterations of new, new + params...
       new:  1 wallclock secs ( 0.41 usr +  0.00 sys =  0.41 CPU) @ 48780.49/s (n=20000)
new + params:  1 wallclock secs ( 0.53 usr +  0.01 sys =  0.54 CPU) @ 37037.04/s (n=20000)
Benchmark: timing 1000000 iterations of get_FOO, set_FOO...
   get_FOO:  2 wallclock secs ( 1.43 usr +  0.01 sys =  1.44 CPU) @ 694444.44/s (n=1000000)
   set_FOO:  0 wallclock secs ( 1.43 usr +  0.01 sys =  1.44 CPU) @ 694444.44/s (n=1000000)


::Fast
---
Benchmark: timing 20000 iterations of new, new + params...
       new:  0 wallclock secs ( 0.44 usr +  0.01 sys =  0.45 CPU) @ 44444.44/s (n=20000)
new + params:  1 wallclock secs ( 0.55 usr +  0.00 sys =  0.55 CPU) @ 36363.64/s (n=20000)
Benchmark: timing 1000000 iterations of get_FOO, set_FOO...
   get_FOO:  0 wallclock secs ( 0.81 usr +  0.00 sys =  0.81 CPU) @ 1234567.90/s (n=1000000)
   set_FOO:  2 wallclock secs ( 0.87 usr +  0.01 sys =  0.88 CPU) @ 1136363.64/s (n=1000000)

::Fast with inlined ID
Benchmark: timing 20000 iterations of new, new + params...
       new:  0 wallclock secs ( 0.41 usr +  0.00 sys =  0.41 CPU) @ 48780.49/s (n=20000)
new + params:  1 wallclock secs ( 0.52 usr +  0.00 sys =  0.52 CPU) @ 38461.54/s (n=20000)
Benchmark: timing 1000000 iterations of get_FOO, set_FOO...
   get_FOO:  2 wallclock secs ( 0.80 usr +  0.00 sys =  0.80 CPU) @ 1250000.00/s (n=1000000)
   set_FOO:  2 wallclock secs ( 0.89 usr + -0.01 sys =  0.88 CPU) @ 1136363.64/s (n=1000000)