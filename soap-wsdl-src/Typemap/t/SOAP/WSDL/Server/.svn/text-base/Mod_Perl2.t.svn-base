use strict;
use warnings;
use diagnostics;
# ugly use lib to let it run from everywhere
use lib '../../../../example/lib';
use lib '../example/lib';
use lib 'example/lib';
use lib 'lib';
use lib 't/lib';
use warnings;
use Test::More; #qw(no_plan);

use MyElements::sayHello;

eval { require Test::MockObject }
    or plan skip_all => 'Test::MockObject required for faking mod_perl';
plan tests => 13;

my @ERROR_FROM = ();
my $REQUEST = 'Foo',
my $RESPONSE;
my %DIR_CONFIG_OF = (
    dispatch_to => 'Mod_Perl2Test',
    soap_service => 'MyServer::HelloWorld::HelloWorldSoap',

);


# Ouch, testing mod_perl without mod_perl is pain in the arse.
#
# This is what we have to mock
#
#use Apache2::RequestIO  (); # $r->read()
#use Apache2::RequestRec (); # $r->headers_in
#use Apache2::RequestUtil(); # $r->dir_config()
#use APR::Table          (); # $r->headers_in->get()
#use Apache2::Log        (); # $r->log
#use Apache2::Const -compile => qw(
#                                    OK
#                                    SERVER_ERROR
#                                    HTTP_LENGTH_REQUIRED
#                                );

my $mock = Test::MockObject->new();
$mock->fake_module('Apache2::Const' =>
    OK => sub { 1 },
    SERVER_ERROR => sub { 500 },
    HTTP_LENGTH_REQUIRED => sub { 411 },
    import => sub {},
);
$mock->fake_module('Apache2::Headers' =>
    new => sub { my $class = shift; return bless { @_ }, $class },
    get => sub { return $_[0]->{ $_[1] } },
);
$mock->fake_module('Apache2::Log' =>
    new     => sub { return bless {}, 'Apache2::Log' },
    error   => sub { shift; push @ERROR_FROM, @_ },
    warn    => sub { shift; push @ERROR_FROM, @_ },
);
$mock->fake_module('Apache2::RequestIO');
$mock->fake_module('Apache2::RequestRec' =>
    new => sub { return bless {}, 'Apache2::RequestRec' },
    log => sub { return Apache2::Log->new() },
    dir_config  => sub { return $DIR_CONFIG_OF{$_[1]}},
    headers_in  => sub { return Apache2::Headers->new(
        'content-length' => length($REQUEST),
        'SOAPAction'     => 'urn:HelloWorld#sayHello',
        )
    },
    'read'          => sub { $_[1] = $REQUEST; my $length = length($REQUEST); $REQUEST = q{}; return $length; },
    method          => sub { 'POST' },
    uri             => sub { 'http://example.org/soap-wsdl/helloWorld/' },
    content_type    => sub {},
    'print'         => sub { shift; $RESPONSE .= join(q{}, @_) },
);
$mock->fake_module('Apache2::RequestUtil');
$mock->fake_module('APR::Table');

use_ok qw(SOAP::WSDL::Server::Mod_Perl2);

ok my $obj = SOAP::WSDL::Server::Mod_Perl2->new(), 'instantiate object';

my $r = Apache2::RequestRec->new();

# block for scoping local
{
    # dirty but useful...
    local $DIR_CONFIG_OF{dispatch_to} = undef;
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $ERROR_FROM[0], qr{\A No \s 'dispatch_to' \s variable \s set \s in \s httpd.conf }x
        , 'error on bad dispatch_to';
    @ERROR_FROM = ();
}

# block for scoping local
{
    # dirty but useful...
    local $DIR_CONFIG_OF{dispatch_to} = 'main';
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $ERROR_FROM[0], qr{\A Failed \s to \s require \s \[main\] }x, 'error on bad dispatch_to';
    @ERROR_FROM = ();
}

# block for scoping local
{
    # dirty but useful...
    local $DIR_CONFIG_OF{soap_service} = undef;
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $ERROR_FROM[0], qr{\A No \s 'soap_service' \s variable \s set \s in \s httpd.conf }x
        , 'error on bad dispatch_to';
    @ERROR_FROM = ();
}

# block for scoping local
{
    # dirty but useful...
    local $DIR_CONFIG_OF{soap_service} = 'soap_service';
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $ERROR_FROM[0], qr{\A Failed \s to \s require \s \[soap_service\] }x, 'error on bad dispatch_to';
    @ERROR_FROM = ();
}


# block for scoping local
{
    # dirty but useful...
    local $DIR_CONFIG_OF{transport_class} = 'transport_class';
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $ERROR_FROM[0], qr{\A Failed \s to \s require \s \[transport_class\] }x, 'error on bad transport_class';
    @ERROR_FROM = ();
}

# block for scoping local
{
    # dirty but useful...
    local $DIR_CONFIG_OF{transport_class} = 'SOAP::WSDL::Server::Mod_Perl2';
    $REQUEST = q{Foobar};
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $ERROR_FROM[0], qr{\A Failed \s to \s handle \s request }x, 'error on bad request';
    @ERROR_FROM = ();
}

# just a block - got used to it.
{
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $ERROR_FROM[0], qr{\A No \s content-length \s provided }x, 'error on missing content-length';
    @ERROR_FROM = ();
}

{

    my $hello = MyElements::sayHello->new({ name => 'Kutter', givenName => 'Martin' });
    $REQUEST = '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body >'
        . $hello->serialize_qualified()
        . '</SOAP-ENV:Body></SOAP-ENV:Envelope>';
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $RESPONSE, qr{Hello \s Martin \sKutter}x, 'SOAP response';
    @ERROR_FROM = ();
}

{
    my $hello = MyElements::sayHello->new({ name => '__DIE__',  });
    $REQUEST = '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body >'
        . $hello->serialize_qualified()
        . '</SOAP-ENV:Body></SOAP-ENV:Envelope>';
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $ERROR_FROM[0], qr{Failed \s to \s handle \s request: \s FOO}x, 'SOAP response';
}

{
    my $hello = MyElements::sayHello->new({ name => '__DIE__',  });
        $REQUEST = '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
            <SOAP-ENV:Body >'
                . $hello->serialize_qualified()
                . '<FOOBAR/>'
            . '</SOAP-ENV:Body></SOAP-ENV:Envelope>';
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $ERROR_FROM[0], qr{Failed \s to \s handle \s request: \s FOO}x, 'SOAP response';
}


# This test breaks the read() method. Be sure to add tests needing it above.
{
    no warnings qw(redefine once);
    $REQUEST = 'FOOBAR';
    *Apache2::RequestRec::read = sub { $_[1] = "BA"; $REQUEST = q{}; return length($REQUEST) };
    my $hello = MyElements::sayHello->new({ name => 'Kutter',  });
    $REQUEST = '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body >'
        . $hello->serialize_qualified()
        . '</SOAP-ENV:Body></SOAP-ENV:Envelope>';
    SOAP::WSDL::Server::Mod_Perl2::handler($r);
    like $ERROR_FROM[0], qr{Failed \s to \s handle \s request: \s FOO}x, 'SOAP response';
}
