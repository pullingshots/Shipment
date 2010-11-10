package MyTypemap;
sub get_typemap { return {} }

package main;
use Test::More;
use CGI;

plan tests => 8;

use_ok(SOAP::WSDL::Server);
use_ok(SOAP::WSDL::Server::Simple);

my $server = SOAP::WSDL::Server::Simple->new( {class_resolver => 'MyTypemap',} );
$server->set_action_map_ref( {'testaction' => 'testmethod',} );

test_fault_output();
test_deserializer_fault();
test_simple_fault();
test_success();

#
# test _output by forcing a fault (passing a empty CGI object)
# IO::Scalar required
#

sub test_fault_output {
    no warnings qw(once);
  SKIP: {
        eval "require IO::Scalar"
          or skip 'IO::Scalar required for testing...', 1;

        # set up a IO::Scalar handle as STDOUT
        local *IO::Scalar::BINMODE = sub { };
        my $output = q{};
        my $fh     = IO::Scalar->new( \$output );
        {
            local *STDOUT = $fh;
            # don't try to print() anything from here on - it gehts caught in $output,
            #and does not make it to STDOUT...

            $server->handle( CGI->new() );
        }
        like $output, qr{No \s handler}xms;

    }
}

sub test_deserializer_fault {
    *SOAP::WSDL::Server::Simple::_output = sub {
        like $_[1]->content(), qr{Error \s deserializing \s message}xms,
          'Fault on (wrong) content';
    };

    local $ENV{REQUEST_METHOD}  = 'POST';
    local $ENV{HTTP_SOAPACTION} = 'testaction';

    $server->set_dispatch_to('main');

    $server->handle(
        CGI->new( {
                POSTDATA => q{<SOAP-ENV:Envelope
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
        ><SOAP-ENV:Body>
            <TestOperation xmlns="http://www.example.org/example/">
                <Name>Kutter</Name>
                <Vorname>Martin</Vorname>
                <Anrede>Herr</Anrede>
            </TestOperation>
        </SOAP-ENV:Body>
     </SOAP-ENV:Envelope>}
            } ) );
}

sub test_simple_fault {
    *SOAP::WSDL::Server::Simple::_output = sub {
        is $_[1]->code, 500;
        like $_[1]->content(), qr{Something \s is \s rotten}xms,
          'Fault on (wrong) content';
    };

    local $ENV{REQUEST_METHOD}  = 'POST';
    local $ENV{HTTP_SOAPAction} = 'testaction';

    local *SOAP::WSDL::Server::handle = sub { die 'Something is rotten' };

    $server->handle(
        CGI->new( {
                POSTDATA => q{<SOAP-ENV:Envelope
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
        ><SOAP-ENV:Body>
            <TestOperation xmlns="http://www.example.org/example/">
                <Name>Kutter</Name>
                <Vorname>Martin</Vorname>
                <Anrede>Herr</Anrede>
            </TestOperation>
        </SOAP-ENV:Body>
     </SOAP-ENV:Envelope>}
            } ) );
}

sub test_success {
    *SOAP::WSDL::Server::Simple::_output = sub {
        is $_[1]->code(),      200;
        like $_[1]->content(), qr{Everything \s OK}xms,
          'Status 200 on OK content';
    };

    local $ENV{REQUEST_METHOD}  = 'POST';
    local $ENV{HTTP_SOAPAction} = 'testaction';

    local *SOAP::WSDL::Server::handle = sub { 'Everything OK' };

    $server->handle(
        CGI->new( {
                POSTDATA => q{<SOAP-ENV:Envelope
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
        ><SOAP-ENV:Body>
            <TestOperation xmlns="http://www.example.org/example/">
                <Name>Kutter</Name>
                <Vorname>Martin</Vorname>
                <Anrede>Herr</Anrede>
            </TestOperation>
        </SOAP-ENV:Body>
     </SOAP-ENV:Envelope>}
            } ) );
}
