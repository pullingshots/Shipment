use strict;
use warnings;

package MyEmptyType;
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);
__PACKAGE__->_factory([],{},{});

package MyEmptyType2;
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);
__PACKAGE__->_factory();

package MyAttribute;
use base qw(SOAP::WSDL::XSD::Typelib::Attribute
    SOAP::WSDL::XSD::Typelib::Builtin::string
);

package MyType;
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);
{
    my %test_of :ATTR(:get<test>);

    __PACKAGE__->_factory(
        [ 'test' ],
        { test => \%test_of, },
        { test => 'SOAP::WSDL::XSD::Typelib::Builtin::string', },

    );
}

package MyElement;
use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    MyType
);

__PACKAGE__->__set_name( 'MyElement' );

sub __get_attr_class { 'MyElement::_ATTR' };

package MyElement::_ATTR;
use base qw(SOAP::WSDL::XSD::Typelib::AttributeSet);
{
    my %test_of     :ATTR(:get<test>);
    my %test2_of    :ATTR(:get<test2>);
    __PACKAGE__->_factory(
        [ 'test', 'test2' ],
        {
            test => \%test_of,
            test2 => \%test2_of,
        },
        {
            test => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
            test2 => 'MyAttribute',
        },
        { test => 'test' }
    );
}

package MyType2;

use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

my %test2_of :ATTR(:get<test>);

__PACKAGE__->_factory(
[ 'test' ],
{
    test => \%test2_of,
},
{
    test => 'MyType',
}
);

package MyElementSimpleContent;
{
    use base qw(
        SOAP::WSDL::XSD::Typelib::Element
        SOAP::WSDL::XSD::Typelib::ComplexType
        SOAP::WSDL::XSD::Typelib::Builtin::string
    );

    __PACKAGE__->__set_name( 'MyElementSimpleContent' );

    sub __get_attr_class { 'MyElement::_ATTR' };
	sub get_xmlns { 'http://www.w3.org/2001/XMLSchema' }
}
package main;
use Test::More tests => 127;
use Storable;

my $have_warn = eval 'use Test::Warn; 1;';

my $obj;

for my $class (qw{MyEmptyType MyEmptyType2}) {
    $obj = $class->new();
    is $obj->serialize, '', "$class object serializes to q{}";
    is $obj->serialize({ name => 'test'}), '<test/>', "$class object serializes to <test/> with name=test";
}

$obj = MyType->new({});
isa_ok $obj, 'MyType';
is $obj->get_test, undef, 'undefined element content';

my $hash_of_ref = $obj->as_hash_ref();
is scalar keys %{ $hash_of_ref }, 0;

SKIP: {
    skip 'Cannot test warnings without Test::Warn', 1 if not $have_warn;
    Test::Warn::warning_like(
        sub { $obj->add_test() },
        qr{\Aattempting \s to \s add \s empty \s value \s to \s MyType}xms,
    );
#   warning_is is broken in 0.11
#   Test::Warn::warning_is(
#       sub { $obj->add_test() },
#       'attempting to add empty value to MyType',
#   );
}

$obj = MyType->new({ test => 'Test1'});
isa_ok $obj, 'MyType';
isa_ok $obj->get_test, 'SOAP::WSDL::XSD::Typelib::Builtin::string';
is $obj->get_test, 'Test1', 'element content';

$obj = MyType->new({
    test => SOAP::WSDL::XSD::Typelib::Builtin::string->new({
        value => 'Test2'
    })
});

isa_ok $obj, 'MyType';
isa_ok $obj->get_test, 'SOAP::WSDL::XSD::Typelib::Builtin::string';
is $obj->get_test, 'Test2', 'element content';

$obj = MyType->new({
    test => { value => 'Test2' } # just a trick - pass it unaltered to new...
});
isa_ok $obj, 'MyType';
isa_ok $obj->get_test, 'SOAP::WSDL::XSD::Typelib::Builtin::string';
is $obj->get_test, 'Test2', 'element content';

$hash_of_ref = $obj->as_hash_ref();
is $hash_of_ref->{ test }, 'Test2';
ok ! ref $hash_of_ref->{ test };

$obj = MyType->new({
    test => [
        SOAP::WSDL::XSD::Typelib::Builtin::string->new({
            value => 'Test'
        }),

        SOAP::WSDL::XSD::Typelib::Builtin::string->new({
            value => 'Test2'
        })
    ],
});

isa_ok $obj, 'MyType';
isa_ok $obj->get_test, 'ARRAY';
is $obj->get_test()->[0], 'Test', 'element content (list content [0])';
is $obj->get_test()->[1], 'Test2', 'element content (list content [1])';

$hash_of_ref = $obj->as_hash_ref();
is $hash_of_ref->{ test }->[0], 'Test';
ok ! ref $hash_of_ref->{ test }->[0];
is $hash_of_ref->{ test }->[1], 'Test2';

my $nested = MyType2->new({
    test => $obj,
});

is $nested->get_test, $obj, 'getter';
$nested = MyType2->new({
    test => [$obj, $obj],
});

is $nested->get_test->[0], $obj;

# use Data::Dumper;
# print Data::Dumper::Dumper $nested->as_hash_ref();

is $nested->as_hash_ref()->{ test }->[ 0 ]->{ test }->[0], 'Test'
    , 'as_hash_ref with nested elements';

$nested = MyType2->new({
    test => {
        test => [
            SOAP::WSDL::XSD::Typelib::Builtin::string->new({
                value => 'Test'
            }),

            SOAP::WSDL::XSD::Typelib::Builtin::string->new({
                value => 'Test2'
            })
        ],
    },
});

$hash_of_ref = $nested->as_hash_ref();
is $hash_of_ref->{ test }->{ test }->[1], 'Test2';


$obj = MyType->new();
isa_ok $obj, 'MyType';
is $obj->get_test, undef, 'undefined element content';

$obj->add_test(
    SOAP::WSDL::XSD::Typelib::Builtin::string->new({ value => 'TestString0'})
);
is $obj->get_test, 'TestString0', 'added element content';

for my $count (1..5) {
    $obj->add_test(
        SOAP::WSDL::XSD::Typelib::Builtin::string->new({ value => "TestString$count" })
    );

    is ref $obj->get_test(), 'ARRAY', 'element content structure';
    is @{ $obj->get_test() }, $count+1, "element list length: " . ($count + 1);

    for my $index (0..$count-1) {
        is $obj->get_test->[$index], "TestString$index", "element content [$index]";
    }
}

$obj->set_test();
is $obj->get_test, (), 'removed element content';

$obj = MyEmptyType->new();
is $obj->attr(), undef;

$obj = MyElement->new();
isa_ok $obj->attr() , 'SOAP::WSDL::XSD::Typelib::AttributeSet';

my $attr = $obj->attr({ test => 'TestAttribute',
    test2 => 'TestAttribute2'
});
isa_ok $attr, 'SOAP::WSDL::XSD::Typelib::AttributeSet';
is $attr->serialize(), q{ test="TestAttribute" test2="TestAttribute2"}, 'attribute serialization';

is $obj->serialize(),
    q{<MyElement test="TestAttribute" test2="TestAttribute2"/>},
    'Serialization with attributes';

$obj->attr()->set_test2('test');
is $obj->serialize(),
    q{<MyElement test="TestAttribute" test2="test"/>},
    'Serialization with attributes';

#
# cloning attributes...
#
ok exists $obj->as_hash_ref()->{ xmlattr }, 'as_hash_ref attributes';
is $obj->as_hash_ref()->{ xmlattr }->{ test }, 'TestAttribute', 'as_hash_ref attribute value';
is $obj->as_hash_ref()->{ xmlattr }->{ test2 }, 'test', 'as_hash_ref attribute value';

my $clone = ref($obj)->new($obj->as_hash_ref());
isnt $$clone, $$obj, 'clone is new object';
isnt ${ $clone->attr() }, ${ $obj->attr() }, 'cloned attrs are a new object';

is $clone->attr()->get_test(), 'TestAttribute';
#
# end cloning attributes
#

$obj = MyType->new();

isa_ok $obj, 'MyType';
is $obj->get_test, undef;

{
    no warnings;
    my $foo;
    eval { $foo = @{ $obj->get_test() } };
    if (! $@) {
        is $foo, undef;
    }
    else {
        like $@ , qr{Can't \s use \s an \s undefined}x, 'get_ELEMENT still undef on ARRAYIFY';
    }

    $obj->set_test(
        SOAP::WSDL::XSD::Typelib::Builtin::string->new({ value => 'TestString0'})
    );
}
is $obj->get_test, 'TestString0';
eval { is @{ $obj->get_test() }, 1, 'ARRAYIFY get_ELEMENT' };
fail 'cannot ARRAYIFY get_ELEMENT' if ($@);

my @serialized = (
'<test>TestString0</test><test>TestString1</test>',
'<test>TestString0</test><test>TestString1</test><test>TestString2</test>',
'<test>TestString0</test><test>TestString1</test><test>TestString2</test><test>TestString3</test>',
'<test>TestString0</test><test>TestString1</test><test>TestString2</test><test>TestString3</test><test>TestString4</test>',
'<test>TestString0</test><test>TestString1</test><test>TestString2</test><test>TestString3</test><test>TestString4</test><test>TestString5</test>',
);

for my $count (1..5) {
    $obj->add_test(
        SOAP::WSDL::XSD::Typelib::Builtin::string->new({ value => "TestString$count" })
    );

    is ref $obj->get_test(), 'ARRAY';
    is @{ $obj->get_test() }, $count+1;

    for my $index (0..$count-1) {
        is $obj->get_test->[$index], "TestString$index";
    }
    is $obj->serialize(), $serialized[$count -1], "serialized $serialized[$count -1]";

}

{
    my $clone = Storable::thaw( Storable::freeze( $obj ));
    is $clone->get_test()->[0], 'TestString0', 'clone via freeze/thaw';
}

## failure tests

eval {
    $obj = MyType->new({
    test => [
            SOAP::WSDL::XSD::Typelib::Builtin::string->new({
                value => 'Test'
            }),

            \&CORE::die,
        ],
    });
};
like $@, qr{cannot \s use \s CODE}xms, 'error passing a code reference as list value to new()';

eval {
    $obj = MyType->new({
        test => \&CORE::die,
    });
};
like $@, qr{cannot \s use \s CODE}xms, 'error passing a code reference to new()';

$obj = MyType->new({ xmlns => 'fubar'});
ok defined $obj;
TODO: {
    local $TODO = "Support XML namespaces";
    is $obj->get_xmlns(), 'fubar';
}

eval {
    $obj = MyType->new({
        foobar => 'fubar'
    });
};
like $@, qr{unknown \s field \s foobar \s in \s MyType }xms;


eval { $obj->set_FOO(42) };
like $@, qr{Can't \s locate \s object \s method}x, 'error on calling unknown object method';

TODO: {
    local $TODO = "Identify calls to class methods";

    eval { MyType->set_FOO(42) };
    like $@, qr{Can't \s locate \s class \s method}x,  'error on calling unknown class method';
}

ok ! MyType->can('set_FOO'), 'MyType->can("setFOO")';

ok ! UNIVERSAL::can('MyType', 'set_FOO'), 'UNIVERSAL::can("MyTypes", "set_FOO")';

eval { MyType->new({ FOO => 42 }) };
like $@, qr{unknown \s field \s}xm, 'error passing unknown field to constructor';

eval {
    # catch warning -
    local $SIG{__WARN__} = sub {};
    SOAP::WSDL::XSD::Typelib::ComplexType::AUTOMETHOD()
};
like $@, qr{Cannot \s call}xm, 'error calling AUTOMETHOD as function';

eval { SOAP::WSDL::XSD::Typelib::ComplexType->_factory([], { test => {} }, {}) };
like $@, qr{ No \s class \s given \s for \s }xms;

eval { SOAP::WSDL::XSD::Typelib::ComplexType->_factory([], { test => {} }, { test => 'HopeItDoesntExistOnYourSystem'}) };
like $@, qr{ Can't \s locate \s HopeItDoesntExistOnYourSystem.pm }xms;

# print Dumper

$obj = MyElementSimpleContent->new({ value => 'foo' });
$obj->attr({ test => 'foo', test2 => 'bar' });
is $obj->serialize_qualified(), '<MyElementSimpleContent xmlns="http://www.w3.org/2001/XMLSchema" test="foo" test2="bar">foo</MyElementSimpleContent>';

$clone = ref($obj)->new($obj->as_hash_ref());
isnt $$clone, $$obj, 'clone is new object';
isnt ${ $clone->attr() }, ${ $obj->attr() }, 'cloned attrs are a new object';

is $clone->get_value(), 'foo';

ok ! exists $obj->as_hash_ref(1)->{ xmlattr };

{
    local $SOAP::WSDL::XSD::Typelib::ComplexType::AS_HASH_REF_WITHOUT_ATTRIBUTES = 1;
    ok ! exists $obj->as_hash_ref()->{ xmlattr };
    ok ! exists $obj->as_hash_ref(1)->{ xmlattr };
}
