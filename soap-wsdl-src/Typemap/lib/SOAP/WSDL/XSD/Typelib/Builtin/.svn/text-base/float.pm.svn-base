package SOAP::WSDL::XSD::Typelib::Builtin::float;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none', cache => 1;
use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);

sub as_num :NUMERIFY {
    return $_[0]->get_value();
}

Class::Std::initialize();   # make :NUMERIFY overloading serializable

1;

