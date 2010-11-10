use strict; use warnings;
use Test::More tests => 8;

use_ok qw(SOAP::WSDL::Base);

my $obj = SOAP::WSDL::Base->new();

ok $obj->push_annotation('foo');
ok $obj->push_annotation('foo');
ok $obj->push_annotation('foo');

ok $obj->set_namespace('foo');
ok $obj->push_namespace('foo');

eval { $obj->find_namespace('uri:example','foo') };
like $@, qr{get_targetNamespace};

eval { $obj->find_namespace(['uri:example','foo']) };
like $@, qr{get_targetNamespace};