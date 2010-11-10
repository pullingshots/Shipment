use strict;
use warnings;
use Test::More;
use File::Find;
if ( not $ENV{RELEASE_TESTING} ) {
    my $msg = 'Author test.  Set $ENV{RELEASE_TESTING} to a true value to run.';
    plan( skip_all => $msg );
}

require Test::Pod::Content;
import Test::Pod::Content;

my $dir = 'blib/lib';
if (-d '../t') {
    $dir = '../lib';
}

my @filelist = ();
find( \&filelist, $dir);

sub filelist {
    my $name = $_;
    return if (-d $name);
    return if $File::Find::name =~m{\.svn}x;
    return if $File::Find::name !~m{\.pm$}x;

    # skip builtin XSD types - they contain no pod
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Typelib/Builtin/.+}xms;
    # skip data classes - they contain no pod
    return if $File::Find::name =~m{SOAP/WSDL/Base\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/Binding\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/Message\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/Operation\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/OpMessage\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/Part\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/Port\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/PortType\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/SOAP/Address\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/SOAP/Body\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/SOAP/Header\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/SOAP/HeaderFault\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/SOAP/Operation\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/Service\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/TypeLookup\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/Types\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Builtin\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/ComplexType\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/SimpleType\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Element\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Schema\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Attribute\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Typelib/Attribute\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Typelib/AttributeSet\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Group\.pm$}xms;

    return if $File::Find::name =~m{SOAP/WSDL/XSD/TotalDigits\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Annotation\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/AttributeGroup\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Enumeration\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/FractionDigits\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Length\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/MaxExclusive\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/MaxInclusive\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/MaxLength\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/MinLength\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/MinInclusive\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/MinExclusive\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/Pattern\.pm$}xms;
    return if $File::Find::name =~m{SOAP/WSDL/XSD/WhiteSpace\.pm$}xms;

    push @filelist, $File::Find::name;
}

plan tests => scalar @filelist;

for my $file (sort @filelist) {
    pod_section_like( $file, 'LICENSE AND COPYRIGHT', qr{ This \s file \s is \s part \s of
        \s SOAP-WSDL\. \s You \s may \s distribute/modify \s it \s under \s
        the \s same \s terms \s as \s perl \s itself
    }xms, "$file License notice");
}
