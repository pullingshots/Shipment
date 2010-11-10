package Typelib::TMessage;
use strict;
use base qw(Typelib::Base);
use Class::Std::Fast constructor => 'basic';

my %MRecipientURI_of   :ATTR(:name<MRecipientURI> :default<()>);
my %MMessageContent_of :ATTR(:name<MMessageContent> :default<()>);
my %MSenderAddress_of  :ATTR(:name<MSenderAddress> :default<()>);
my %MSubject_of        :ATTR(:name<MSubject> :default<()>);
my %MDeliveryReportRecipientURI_of :ATTR(:name<MDeliveryReportRecipientURI> :default<()>);
my %MKeepalive_of      :ATTR(:name<MKeepalive> :default<()>);

my %attributes_of       :ATTR();

%attributes_of = (
    MRecipientURI => \%MRecipientURI_of, 
    MMessageContent => \%MMessageContent_of,
    MSenderAddress => \%MSenderAddress_of,
    MSubject => \%MSubject_of,
    MDeliveryReportRecipientURI => \%MDeliveryReportRecipientURI_of,
    MKeepalive => \%MKeepalive_of,
);

# make a add_BLA method for every attribute
__PACKAGE__->mk_add_mutators( \%attributes_of );

Class::Std::Fast::initialize();
1;