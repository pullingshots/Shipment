package SOAP::WSDL::XSD::Typelib::Builtin::decimal;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none', cache => 1;
use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);

sub as_num :NUMERIFY :BOOLIFY {
    return $_[0]->get_value();
}

Class::Std::Fast::initialize();   # make :NUMERIFY :BOOLIFY overloading serializable

1;
