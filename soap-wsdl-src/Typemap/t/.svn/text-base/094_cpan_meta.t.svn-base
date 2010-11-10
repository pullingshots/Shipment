use Test::More;

if (not $ENV{RELEASE_TESTING} ) {
    my $msg = 'Author test.  Set $ENV{RELEASE_TESTING} to a true value to run.';
    plan( skip_all => $msg );
}

eval { require Test::CPAN::Meta }
    or plan skip_all => "Test::CPAN::Meta required for testing META.yml";

Test::CPAN::Meta::meta_yaml_ok();