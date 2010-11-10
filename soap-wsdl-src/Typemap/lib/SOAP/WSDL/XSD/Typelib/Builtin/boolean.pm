package SOAP::WSDL::XSD::Typelib::Builtin::boolean;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none', cache => 1;

use version; our $VERSION = qv('2.00.99_3');

use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);

sub serialize {
    $_[1] ||= {};
    my $value =$_[0]->get_value();
    return $_[0]->start_tag({ %{$_[1]}, nil => 1})
            if not defined $value;
    return join q{}
        , $_[0]->start_tag($_[1])
        , $value && $value ne 'false' ? 'true' : 'false'
        , $_[0]->end_tag($_[1]);
}

sub as_string :STRINGIFY {
    my $value = $_[0]->get_value();
    return q{} if not defined $value;
    return ($value && $value ne 'false') ? 1 : 0;
}

sub as_num :NUMERIFY :BOOLIFY {
    my $value = $_[0]->get_value();
    return ($value && $value ne 'false') ? 1 : 0;
}

sub set_value {
    $_[0]->SUPER::set_value( defined $_[1]
        ? ($_[1] ne 'false' && ($_[1]) )
            ? 1 : 0
        : 0);
}

sub delete_value { $_[0]->SUPER::set_value(undef) }

Class::Std::Fast::initialize();   # make :BOOLIFY overloading serializable

1;
