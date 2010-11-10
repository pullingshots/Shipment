package MyTypemap;
sub get_typemap { return {} };

package HandlerClass;
sub bar {
    return 'Verdammte Axt';
}

sub exception {
    die "EXCEPTION";
}


package main;
use Test::More;
eval "require IO::Scalar"
    or plan skip_all => 'IO::Scalar required for testing...';

plan tests => 16;

use_ok(SOAP::WSDL::Server);
use_ok(SOAP::WSDL::Server::CGI);

my $server = SOAP::WSDL::Server::CGI->new({
    class_resolver => 'MyTypemap',
});
$server->set_action_map_ref({
    'testaction' => 'testmethod',
});

{
    no warnings qw(once);
    *IO::Scalar::BINMODE = sub {};
}
my $output = q{};
my $fh = IO::Scalar->new(\$output);
my $stdout = *STDOUT;
my $stdin = *STDIN;

# don't try to print() anything from here on - it gehts caught in $output,
#and does not make it to STDOUT...

*STDOUT = $fh;
{
    local %ENV;
    $server->handle();

    like $output, qr{ \A Status: \s 411 \s Length \s Required}x;
    $output = q{};

    $server->set_action_map_ref({
        'foo' => 'bar',
    });
    $server->set_dispatch_to( 'HandlerClass' );

    $ENV{'CONTENT_LENGTH'} = '0e0';
    $server->handle();
    like $output, qr{Not \s found: \s No \s SOAPAction \s given}xms
        ,'error without SOAPAction header';
    $output = q{};

    # error with bad SOAPAction
    $ENV{REQUEST_METHOD} = 'POST';
    $ENV{HTTP_SOAPACTION} = 'test';
    $server->handle();
    like $output, qr{No \s method \s found \s for \s the \s SOAPAction}xms
        , 'error with bad SOAPAction';
    $output = q{};
    delete $ENV{HTTP_SOAPACTION};   # delete uc variant - server concats

    # Continue
    $ENV{EXPECT} = '100-Continue';
    $ENV{HTTP_SOAPAction} = 'foo';
    $server->handle();
    like $output, qr{100 \s Continue}xms, 'Continue';
    $output = q{};
    delete $ENV{EXPECT};

    # error with bad EXPECT and bad SOAPAction
    $ENV{EXPECT} = 'FOO';
    $ENV{HTTP_SOAPAction} = 'test';
    $server->handle();
    like $output, qr{No \s method \s found \s for \s the \s SOAPAction}xms
        , 'error with bad EXPECT and bad SOAPAction';
    $output = q{};
    delete $ENV{EXPECT};

    $server->set_action_map_ref({
        'bar' => 'bar',
    });

    # No handler
    $server->set_dispatch_to(undef);
    my $input = q{<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body></SOAP-ENV:Body></SOAP-ENV:Envelope>};
    my $ih = IO::Scalar->new(\$input);
    $ih->seek(0, 0);

    *STDIN = $ih;
    $ENV{HTTP_SOAPAction} = 'bar';
    $ENV{CONTENT_LENGTH} = length $input;
    $server->handle();
    like $output, qr{ No \s handler}xms
        , 'No handler';
    $output = q{};
    $ih->seek(0, 0);

    $server->set_dispatch_to( 'HandlerClass' );

    # bad content
    $input = 'Foobar';
    $ih->seek(0, 0);
    $ENV{HTTP_SOAPAction} = 'bar';
    $ENV{CONTENT_LENGTH} = 6;
    $server->handle();
    like $output, qr{ Error \s deserializing \s message}xms
        , 'bad content';
    $output = q{};
    $ih->seek(0, 0);

    $ENV{REQUEST_METHOD} = 'POST';
    $ENV{HTTP_SOAPAction} = 'bar';
    $ENV{'CONTENT_LENGTH'} = '0e0';
    $server->handle();
    like $output, qr{ Error \s deserializing }xsm
        , 'error with bad request content';
    $output = q{};

    delete $ENV{HTTP_SOAPACTION};

    # empty request
    $input = q{<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body></SOAP-ENV:Body></SOAP-ENV:Envelope>};
    $ENV{HTTP_SOAPAction} = q{"bar"};
    $ENV{CONTENT_LENGTH} = length $input;
    $server->handle();
    use Data::Dumper;
    like $output, qr{ \A Status: \s 200 \s OK}xms
        , "empty request";
    $output = q{};
    $ih->seek(0, 0);


    $server->set_dispatch_to( 'HandlerClass' );
    $server->set_action_map_ref({
        'bar' => 'bar',
        'exception' => 'exception',
    });

    # non-serializable exception
    $input = q{<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body></SOAP-ENV:Body></SOAP-ENV:Envelope>};
    $ENV{SERVER_SOFTWARE} ='IIS Foobar';
    $ENV{HTTP_SOAPAction} = q{"exception"};
    $ENV{CONTENT_LENGTH} = length $input;
    $server->handle();
    use Data::Dumper;
    like $output, qr{EXCEPTION}xms,
        'non-serializable exception';
    $output = q{};
    $ih->seek(0, 0);

    # IIS response
    $input = q{<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body></SOAP-ENV:Body></SOAP-ENV:Envelope>};
    $ENV{SERVER_SOFTWARE} ='IIS Foobar';
    $ENV{HTTP_SOAPAction} = q{"bar"};
    $ENV{CONTENT_LENGTH} = length $input;
    $server->handle();
    use Data::Dumper;
    like $output, qr{ \A HTTP/1.0 \s 200 \s OK}xms, 'IIS response';
    $output = q{};
    $ih->seek(0, 0);

    # IIS HTTP/1.1 response
    $input = q{<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body></SOAP-ENV:Body></SOAP-ENV:Envelope>};
    $ENV{SERVER_SOFTWARE} ='IIS Foobar';
    $ENV{SERVER_PROTOCOL} ='HTTP/1.1';
    $ENV{HTTP_SOAPAction} = q{"bar"};
    $ENV{CONTENT_LENGTH} = length $input;
    $server->handle();
    use Data::Dumper;
    like $output, qr{ \A HTTP/1.1 \s 200 \s OK}xms, 'IIS response';
    $output = q{};
    $ih->seek(0, 0);

    # response
    $input = q{<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body></SOAP-ENV:Body></SOAP-ENV:Envelope>};
    $ENV{SERVER_SOFTWARE} ='Apache';
    $ENV{HTTP_SOAPAction} = q{"bar"};
    $ENV{CONTENT_LENGTH} = length $input;
    $server->handle();
    use Data::Dumper;
    like $output, qr{ \A Status: \s 200 \s OK}xms, 'response';
    $output = q{};
    $ih->seek(0, 0);

    # response
    $input = q{<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body></SOAP-ENV:Body></SOAP-ENV:Envelope>};
    delete $ENV{SERVER_SOFTWARE};
    $ENV{HTTP_SOAPAction} = q{"bar"};
    $ENV{CONTENT_LENGTH} = length $input;
    $server->handle();
    use Data::Dumper;
    like $output, qr{ \A Status: \s 200 \s OK}xms, 'response';
    $output = q{};
    $ih->seek(0, 0);

}

# restore handles
*STDOUT = $stdout;
*STDIN = $stdin;
# print $output;
