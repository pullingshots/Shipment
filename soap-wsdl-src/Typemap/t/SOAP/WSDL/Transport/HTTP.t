use Test::More tests => 8;
use strict;
use utf8;

use SOAP::WSDL::Transport::HTTP;

my $transport = SOAP::WSDL::Transport::HTTP->new();

ok $transport->is_success(1);
ok $transport->code(200);
ok $transport->status('200 OK');
ok $transport->message('OK');

my $result = $transport->send_receive(envelope => 'Test', action => 'foo');

ok ! $transport->is_success();

$result = $transport->send_receive(encoding => 'utf-8', envelope => 'ÄÖÜ',
    action => 'foo');
ok ! $transport->is_success();

$result = $transport->send_receive(encoding => 'utf-8', envelope => 'ÄÖÜ',
    action => 'foo', content_type => 'application/xml');
ok ! $transport->is_success();

{
    no warnings qw(redefine);
    my $request_sub =\&LWP::UserAgent::request;
    *LWP::UserAgent::request = sub {
        my $self = shift;
        my $request = shift;
        is $request->header('Content-Type'), 'text/xml; charset=utf-8';
        return HTTP::Response->new( 200 );
    };

    $result = $transport->send_receive(envelope => 'Test', action => 'foo');
    *LWP::UserAgent::request = $request_sub;
}
