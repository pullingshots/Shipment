package SOAP::WSDL::XSD::Typelib::Builtin::gMonth;
use strict;
use warnings;

# Speed up. Class::Std::new is slow - and we don't need it's functionality...
use Class::Std::Fast::Storable constructor => 'none', cache => 1;
use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);

1;
