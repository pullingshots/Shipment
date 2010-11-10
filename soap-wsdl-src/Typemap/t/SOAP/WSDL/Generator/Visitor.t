use Test::More tests => 15;;
use SOAP::WSDL::Generator::Visitor;

my $visitor = SOAP::WSDL::Generator::Visitor->new();

is undef, $visitor->visit_Definitions();
is undef, $visitor->visit_Binding();
is undef, $visitor->visit_Message();
is undef, $visitor->visit_Operation();
is undef, $visitor->visit_OpMessage();
is undef, $visitor->visit_Part();
is undef, $visitor->visit_Port();
is undef, $visitor->visit_PortType();
is undef, $visitor->visit_Service();
is undef, $visitor->visit_SoapOperation();
is undef, $visitor->visit_Types();

# XML Schema stuff
is undef, $visitor->visit_XSD_Schema();
is undef, $visitor->visit_XSD_ComplexType();
is undef, $visitor->visit_XSD_Element();
is undef, $visitor->visit_XSD_SimpleType();
