package Mod_Perl2Test;
use strict; use warnings;
use Class::Std::Fast;

sub sayHello {
    my ($self, $body, $header) = @_;
    my $name = $body->get_name();
    my $givenName = $body->get_givenName();

    die "FOO" if ($name eq '__DIE__');

    return MyElements::sayHelloResponse->new({
        sayHelloResult => "Hello $givenName $name"
    })}
1;