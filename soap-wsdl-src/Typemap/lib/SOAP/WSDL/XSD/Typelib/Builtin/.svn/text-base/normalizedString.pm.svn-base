package SOAP::WSDL::XSD::Typelib::Builtin::normalizedString;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none', cache => 1;
use base qw(SOAP::WSDL::XSD::Typelib::Builtin::string);

# replace all \t, \r, \n by \s
sub set_value {
    my $value = $_[1];
    $value =~ s{ [\r\n\t]+ }{ }xmsg if defined($value);
    $_[0]->SUPER::set_value($value);
}
Class::Std::initialize();
1;
