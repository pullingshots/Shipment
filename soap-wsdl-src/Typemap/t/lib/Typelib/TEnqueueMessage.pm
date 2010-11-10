package Typelib::TEnqueueMessage;
use strict;
use base qw(Typelib::Base);

my %MMessage_of :ATTR(:name<MMessage> :default<()>);

my %attributes_of :ATTR();

%attributes_of = (
    MMessage => \%MMessage_of, 
);

# make a add_BLA method for every attribute
__PACKAGE__->mk_add_mutators( \%attributes_of );


1;
