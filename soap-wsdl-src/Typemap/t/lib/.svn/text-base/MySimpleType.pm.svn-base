#!/usr/bin/perl
package MySimpleType;
use Class::Std::Fast::Storable constructor => 'none';
use SOAP::WSDL::XSD::Typelib::Builtin;
use SOAP::WSDL::XSD::Typelib::SimpleType;
# restriction base implemented via inheritance
# derive by restriction
# restriction base
use base qw(
    SOAP::WSDL::XSD::Typelib::SimpleType::restriction
    SOAP::WSDL::XSD::Typelib::Builtin::string
);


# example simpleType derived by list.
# XSD would be:
# <simpleType name="MySimpleListType">
#    <list itemTipe="xsd:string">
# </simpleType>
package MySimpleListType;
use Class::Std::Fast::Storable constructor => 'none';
# restriction base implemented via inheritance
use SOAP::WSDL::XSD::Typelib::Builtin;
# derive by list
# list itemType
use base qw(
    SOAP::WSDL::XSD::Typelib::SimpleType
    SOAP::WSDL::XSD::Typelib::Builtin::list
    SOAP::WSDL::XSD::Typelib::Builtin::string
);

package MyAtomicSimpleType;
use Class::Std::Fast::Storable constructor => 'none';
# restriction base implemented via inheritance
use SOAP::WSDL::XSD::Typelib::Builtin;
# derive by restriction
# restriction with atomic simpleType
use base qw(
    SOAP::WSDL::XSD::Typelib::SimpleType::restriction
    MySimpleType
);

package MyAtomicSimpleListType;
use Class::Std::Fast::Storable constructor => 'none';
# restriction base implemented via inheritance
use SOAP::WSDL::XSD::Typelib::Builtin;
# derive by restriction
# restriction with atomic simpleType
use base qw(
    SOAP::WSDL::XSD::Typelib::SimpleType::restriction
    MySimpleListType
);
1;
