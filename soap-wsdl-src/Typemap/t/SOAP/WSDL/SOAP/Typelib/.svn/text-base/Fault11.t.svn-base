package TestFaultDetails;
use strict;
use warnings;

{    # BLOCK to scope variables

    sub get_xmlns { 'urn:HelloWorld' }

    __PACKAGE__->__set_name('TestFaultDetails');
    __PACKAGE__->__set_nillable();
    __PACKAGE__->__set_minOccurs();
    __PACKAGE__->__set_maxOccurs();
    __PACKAGE__->__set_ref();

    use base qw(
      SOAP::WSDL::XSD::Typelib::Element
      SOAP::WSDL::XSD::Typelib::ComplexType
    );
    use Class::Std::Fast::Storable constructor => 'none';
    use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

    Class::Std::initialize();

    {    # BLOCK to scope variables

        my %sayHelloResult_of : ATTR(:get<sayHelloResult>);

        __PACKAGE__->_factory( [qw(
                  sayHelloResult
                  )
            ],
            {sayHelloResult => \%sayHelloResult_of,},
            {sayHelloResult => 'SOAP::WSDL::XSD::Typelib::Builtin::string',}
        );

    }    # end BLOCK
}    # end of BLOCK
1;

package main;
{
    use strict;
    use warnings;
    use Test::More tests => 3;

    use_ok qw(SOAP::WSDL::SOAP::Typelib::Fault11);

    my $fault = SOAP::WSDL::SOAP::Typelib::Fault11->new( {
            faultcode   => 'SOAP-ENV:Client',
            faultstring => 'Test serialization of fault with details',
            faultactor  => 'any',
            detail => TestFaultDetails->new( {sayHelloResult => 'Hello',} )}
    );
    # TODO test with Test::XML
    like $fault->serialize_qualified(), qr{xmlns="urn:HelloWorld"},
      'Serialized fault contains sub-detail element namespace';

    $fault = SOAP::WSDL::SOAP::Typelib::Fault11->new( {
            faultcode   => 'SOAP-ENV:Client',
            faultstring => 'Test serialization of fault with details',
            faultactor  => 'any',
            detail      => SOAP::WSDL::SOAP::Typelib::Fault11Detail->new( {
                    value =>
                      TestFaultDetails->new( {sayHelloResult => 'Hello',} )} )
        }
    );
    # TODO test with Test::XML
    like $fault->serialize_qualified(), qr{xmlns="urn:HelloWorld"},
      'Serialized fault contains sub-detail element namespace';

}

