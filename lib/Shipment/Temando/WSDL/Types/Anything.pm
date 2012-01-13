package Shipment::Temando::WSDL::Types::Anything;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(0);

sub get_xmlns { 'http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %class_of :ATTR(:get<class>);
my %subclass_of :ATTR(:get<subclass>);
my %mode_of :ATTR(:get<mode>);
my %tlSubclass_of :ATTR(:get<tlSubclass>);
my %packaging_of :ATTR(:get<packaging>);
my %palletType_of :ATTR(:get<palletType>);
my %palletNature_of :ATTR(:get<palletNature>);
my %containerDimensions_of :ATTR(:get<containerDimensions>);
my %containerNature_of :ATTR(:get<containerNature>);
my %containerRegistered_of :ATTR(:get<containerRegistered>);
my %qualifierFreightGeneralDangerousGoods_of :ATTR(:get<qualifierFreightGeneralDangerousGoods>);
my %qualifierFreightGeneralFragile_of :ATTR(:get<qualifierFreightGeneralFragile>);
my %qualifierFreightGeneralRefrigerated_of :ATTR(:get<qualifierFreightGeneralRefrigerated>);
my %qualifierVehicleMake_of :ATTR(:get<qualifierVehicleMake>);
my %qualifierVehicleModel_of :ATTR(:get<qualifierVehicleModel>);
my %qualifierVehicleDescription_of :ATTR(:get<qualifierVehicleDescription>);
my %qualifierVehicleRunning_of :ATTR(:get<qualifierVehicleRunning>);
my %qualifierVehicleRegistered_of :ATTR(:get<qualifierVehicleRegistered>);
my %qualifierVehicleYear_of :ATTR(:get<qualifierVehicleYear>);
my %qualifierVehicleRegistration_of :ATTR(:get<qualifierVehicleRegistration>);
my %qualifierBoatMake_of :ATTR(:get<qualifierBoatMake>);
my %qualifierBoatModel_of :ATTR(:get<qualifierBoatModel>);
my %qualifierBoatSeaworthy_of :ATTR(:get<qualifierBoatSeaworthy>);
my %qualifierBoatTrailer_of :ATTR(:get<qualifierBoatTrailer>);
my %qualifierBoatHullType_of :ATTR(:get<qualifierBoatHullType>);
my %qualifierLivestockType_of :ATTR(:get<qualifierLivestockType>);
my %qualifierAnimalVaccinated_of :ATTR(:get<qualifierAnimalVaccinated>);
my %qualifierAnimalRegistered_of :ATTR(:get<qualifierAnimalRegistered>);
my %qualifierAnimalType_of :ATTR(:get<qualifierAnimalType>);
my %qualifierAnimalBreed_of :ATTR(:get<qualifierAnimalBreed>);
my %qualifierAnimalSex_of :ATTR(:get<qualifierAnimalSex>);
my %qualifierAnimalAge_of :ATTR(:get<qualifierAnimalAge>);
my %qualifierAnimalCrate_of :ATTR(:get<qualifierAnimalCrate>);
my %distanceMeasurementType_of :ATTR(:get<distanceMeasurementType>);
my %weightMeasurementType_of :ATTR(:get<weightMeasurementType>);
my %length_of :ATTR(:get<length>);
my %width_of :ATTR(:get<width>);
my %height_of :ATTR(:get<height>);
my %weight_of :ATTR(:get<weight>);
my %quantity_of :ATTR(:get<quantity>);
my %description_of :ATTR(:get<description>);

__PACKAGE__->_factory(
    [ qw(        class
        subclass
        mode
        tlSubclass
        packaging
        palletType
        palletNature
        containerDimensions
        containerNature
        containerRegistered
        qualifierFreightGeneralDangerousGoods
        qualifierFreightGeneralFragile
        qualifierFreightGeneralRefrigerated
        qualifierVehicleMake
        qualifierVehicleModel
        qualifierVehicleDescription
        qualifierVehicleRunning
        qualifierVehicleRegistered
        qualifierVehicleYear
        qualifierVehicleRegistration
        qualifierBoatMake
        qualifierBoatModel
        qualifierBoatSeaworthy
        qualifierBoatTrailer
        qualifierBoatHullType
        qualifierLivestockType
        qualifierAnimalVaccinated
        qualifierAnimalRegistered
        qualifierAnimalType
        qualifierAnimalBreed
        qualifierAnimalSex
        qualifierAnimalAge
        qualifierAnimalCrate
        distanceMeasurementType
        weightMeasurementType
        length
        width
        height
        weight
        quantity
        description

    ) ],
    {
        'class' => \%class_of,
        'subclass' => \%subclass_of,
        'mode' => \%mode_of,
        'tlSubclass' => \%tlSubclass_of,
        'packaging' => \%packaging_of,
        'palletType' => \%palletType_of,
        'palletNature' => \%palletNature_of,
        'containerDimensions' => \%containerDimensions_of,
        'containerNature' => \%containerNature_of,
        'containerRegistered' => \%containerRegistered_of,
        'qualifierFreightGeneralDangerousGoods' => \%qualifierFreightGeneralDangerousGoods_of,
        'qualifierFreightGeneralFragile' => \%qualifierFreightGeneralFragile_of,
        'qualifierFreightGeneralRefrigerated' => \%qualifierFreightGeneralRefrigerated_of,
        'qualifierVehicleMake' => \%qualifierVehicleMake_of,
        'qualifierVehicleModel' => \%qualifierVehicleModel_of,
        'qualifierVehicleDescription' => \%qualifierVehicleDescription_of,
        'qualifierVehicleRunning' => \%qualifierVehicleRunning_of,
        'qualifierVehicleRegistered' => \%qualifierVehicleRegistered_of,
        'qualifierVehicleYear' => \%qualifierVehicleYear_of,
        'qualifierVehicleRegistration' => \%qualifierVehicleRegistration_of,
        'qualifierBoatMake' => \%qualifierBoatMake_of,
        'qualifierBoatModel' => \%qualifierBoatModel_of,
        'qualifierBoatSeaworthy' => \%qualifierBoatSeaworthy_of,
        'qualifierBoatTrailer' => \%qualifierBoatTrailer_of,
        'qualifierBoatHullType' => \%qualifierBoatHullType_of,
        'qualifierLivestockType' => \%qualifierLivestockType_of,
        'qualifierAnimalVaccinated' => \%qualifierAnimalVaccinated_of,
        'qualifierAnimalRegistered' => \%qualifierAnimalRegistered_of,
        'qualifierAnimalType' => \%qualifierAnimalType_of,
        'qualifierAnimalBreed' => \%qualifierAnimalBreed_of,
        'qualifierAnimalSex' => \%qualifierAnimalSex_of,
        'qualifierAnimalAge' => \%qualifierAnimalAge_of,
        'qualifierAnimalCrate' => \%qualifierAnimalCrate_of,
        'distanceMeasurementType' => \%distanceMeasurementType_of,
        'weightMeasurementType' => \%weightMeasurementType_of,
        'length' => \%length_of,
        'width' => \%width_of,
        'height' => \%height_of,
        'weight' => \%weight_of,
        'quantity' => \%quantity_of,
        'description' => \%description_of,
    },
    {
        'class' => 'Shipment::Temando::WSDL::Types::Class',
        'subclass' => 'Shipment::Temando::WSDL::Types::Subclass',
        'mode' => 'Shipment::Temando::WSDL::Types::Mode',
        'tlSubclass' => 'Shipment::Temando::WSDL::Types::TlSubclass',
        'packaging' => 'Shipment::Temando::WSDL::Types::Packaging',
        'palletType' => 'Shipment::Temando::WSDL::Types::PalletType',
        'palletNature' => 'Shipment::Temando::WSDL::Types::PalletNature',
        'containerDimensions' => 'Shipment::Temando::WSDL::Types::ContainerDimensions',
        'containerNature' => 'Shipment::Temando::WSDL::Types::ContainerNature',
        'containerRegistered' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'qualifierFreightGeneralDangerousGoods' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'qualifierFreightGeneralFragile' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'qualifierFreightGeneralRefrigerated' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'qualifierVehicleMake' => 'Shipment::Temando::WSDL::Types::VehicleMake',
        'qualifierVehicleModel' => 'Shipment::Temando::WSDL::Types::VehicleModel',
        'qualifierVehicleDescription' => 'Shipment::Temando::WSDL::Types::VehicleDescription',
        'qualifierVehicleRunning' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'qualifierVehicleRegistered' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'qualifierVehicleYear' => 'Shipment::Temando::WSDL::Types::VehicleYear',
        'qualifierVehicleRegistration' => 'Shipment::Temando::WSDL::Types::VehicleRegistration',
        'qualifierBoatMake' => 'Shipment::Temando::WSDL::Types::BoatMake',
        'qualifierBoatModel' => 'Shipment::Temando::WSDL::Types::BoatModel',
        'qualifierBoatSeaworthy' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'qualifierBoatTrailer' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'qualifierBoatHullType' => 'Shipment::Temando::WSDL::Types::BoatHullType',
        'qualifierLivestockType' => 'Shipment::Temando::WSDL::Types::LivestockType',
        'qualifierAnimalVaccinated' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'qualifierAnimalRegistered' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'qualifierAnimalType' => 'Shipment::Temando::WSDL::Types::AnimalType',
        'qualifierAnimalBreed' => 'Shipment::Temando::WSDL::Types::AnimalBreed',
        'qualifierAnimalSex' => 'Shipment::Temando::WSDL::Types::Sex',
        'qualifierAnimalAge' => 'Shipment::Temando::WSDL::Types::AnimalAge',
        'qualifierAnimalCrate' => 'Shipment::Temando::WSDL::Types::AnimalCrate',
        'distanceMeasurementType' => 'Shipment::Temando::WSDL::Types::DistanceMeasurementType',
        'weightMeasurementType' => 'Shipment::Temando::WSDL::Types::WeightMeasurementType',
        'length' => 'Shipment::Temando::WSDL::Types::Length',
        'width' => 'Shipment::Temando::WSDL::Types::Width',
        'height' => 'Shipment::Temando::WSDL::Types::Height',
        'weight' => 'Shipment::Temando::WSDL::Types::Weight',
        'quantity' => 'Shipment::Temando::WSDL::Types::Quantity',
        'description' => 'Shipment::Temando::WSDL::Types::ItemDescription',
    },
    {

        'class' => 'class',
        'subclass' => 'subclass',
        'mode' => 'mode',
        'tlSubclass' => 'tlSubclass',
        'packaging' => 'packaging',
        'palletType' => 'palletType',
        'palletNature' => 'palletNature',
        'containerDimensions' => 'containerDimensions',
        'containerNature' => 'containerNature',
        'containerRegistered' => 'containerRegistered',
        'qualifierFreightGeneralDangerousGoods' => 'qualifierFreightGeneralDangerousGoods',
        'qualifierFreightGeneralFragile' => 'qualifierFreightGeneralFragile',
        'qualifierFreightGeneralRefrigerated' => 'qualifierFreightGeneralRefrigerated',
        'qualifierVehicleMake' => 'qualifierVehicleMake',
        'qualifierVehicleModel' => 'qualifierVehicleModel',
        'qualifierVehicleDescription' => 'qualifierVehicleDescription',
        'qualifierVehicleRunning' => 'qualifierVehicleRunning',
        'qualifierVehicleRegistered' => 'qualifierVehicleRegistered',
        'qualifierVehicleYear' => 'qualifierVehicleYear',
        'qualifierVehicleRegistration' => 'qualifierVehicleRegistration',
        'qualifierBoatMake' => 'qualifierBoatMake',
        'qualifierBoatModel' => 'qualifierBoatModel',
        'qualifierBoatSeaworthy' => 'qualifierBoatSeaworthy',
        'qualifierBoatTrailer' => 'qualifierBoatTrailer',
        'qualifierBoatHullType' => 'qualifierBoatHullType',
        'qualifierLivestockType' => 'qualifierLivestockType',
        'qualifierAnimalVaccinated' => 'qualifierAnimalVaccinated',
        'qualifierAnimalRegistered' => 'qualifierAnimalRegistered',
        'qualifierAnimalType' => 'qualifierAnimalType',
        'qualifierAnimalBreed' => 'qualifierAnimalBreed',
        'qualifierAnimalSex' => 'qualifierAnimalSex',
        'qualifierAnimalAge' => 'qualifierAnimalAge',
        'qualifierAnimalCrate' => 'qualifierAnimalCrate',
        'distanceMeasurementType' => 'distanceMeasurementType',
        'weightMeasurementType' => 'weightMeasurementType',
        'length' => 'length',
        'width' => 'width',
        'height' => 'height',
        'weight' => 'weight',
        'quantity' => 'quantity',
        'description' => 'description',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Types::Anything

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Anything from the namespace http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * class (min/maxOccurs: 0/1)


=item * subclass (min/maxOccurs: 0/1)


=item * mode (min/maxOccurs: 0/1)


=item * tlSubclass (min/maxOccurs: 0/1)


=item * packaging (min/maxOccurs: 0/1)


=item * palletType (min/maxOccurs: 0/1)


=item * palletNature (min/maxOccurs: 0/1)


=item * containerDimensions (min/maxOccurs: 0/1)


=item * containerNature (min/maxOccurs: 0/1)


=item * containerRegistered (min/maxOccurs: 0/1)


=item * qualifierFreightGeneralDangerousGoods (min/maxOccurs: 0/1)


=item * qualifierFreightGeneralFragile (min/maxOccurs: 0/1)


=item * qualifierFreightGeneralRefrigerated (min/maxOccurs: 0/1)


=item * qualifierVehicleMake (min/maxOccurs: 0/1)


=item * qualifierVehicleModel (min/maxOccurs: 0/1)


=item * qualifierVehicleDescription (min/maxOccurs: 0/1)


=item * qualifierVehicleRunning (min/maxOccurs: 0/1)


=item * qualifierVehicleRegistered (min/maxOccurs: 0/1)


=item * qualifierVehicleYear (min/maxOccurs: 0/1)


=item * qualifierVehicleRegistration (min/maxOccurs: 0/1)


=item * qualifierBoatMake (min/maxOccurs: 0/1)


=item * qualifierBoatModel (min/maxOccurs: 0/1)


=item * qualifierBoatSeaworthy (min/maxOccurs: 0/1)


=item * qualifierBoatTrailer (min/maxOccurs: 0/1)


=item * qualifierBoatHullType (min/maxOccurs: 0/1)


=item * qualifierLivestockType (min/maxOccurs: 0/1)


=item * qualifierAnimalVaccinated (min/maxOccurs: 0/1)


=item * qualifierAnimalRegistered (min/maxOccurs: 0/1)


=item * qualifierAnimalType (min/maxOccurs: 0/1)


=item * qualifierAnimalBreed (min/maxOccurs: 0/1)


=item * qualifierAnimalSex (min/maxOccurs: 0/1)


=item * qualifierAnimalAge (min/maxOccurs: 0/1)


=item * qualifierAnimalCrate (min/maxOccurs: 0/1)


=item * distanceMeasurementType (min/maxOccurs: 0/1)


=item * weightMeasurementType (min/maxOccurs: 0/1)


=item * length (min/maxOccurs: 0/1)


=item * width (min/maxOccurs: 0/1)


=item * height (min/maxOccurs: 0/1)


=item * weight (min/maxOccurs: 0/1)


=item * quantity (min/maxOccurs: 0/1)


=item * description (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Temando::WSDL::Types::Anything
   class => $some_value, # Class
   subclass => $some_value, # Subclass
   mode => $some_value, # Mode
   tlSubclass => $some_value, # TlSubclass
   packaging => $some_value, # Packaging
   palletType => $some_value, # PalletType
   palletNature => $some_value, # PalletNature
   containerDimensions => $some_value, # ContainerDimensions
   containerNature => $some_value, # ContainerNature
   containerRegistered => $some_value, # YesNoOption
   qualifierFreightGeneralDangerousGoods => $some_value, # YesNoOption
   qualifierFreightGeneralFragile => $some_value, # YesNoOption
   qualifierFreightGeneralRefrigerated => $some_value, # YesNoOption
   qualifierVehicleMake => $some_value, # VehicleMake
   qualifierVehicleModel => $some_value, # VehicleModel
   qualifierVehicleDescription => $some_value, # VehicleDescription
   qualifierVehicleRunning => $some_value, # YesNoOption
   qualifierVehicleRegistered => $some_value, # YesNoOption
   qualifierVehicleYear => $some_value, # VehicleYear
   qualifierVehicleRegistration => $some_value, # VehicleRegistration
   qualifierBoatMake => $some_value, # BoatMake
   qualifierBoatModel => $some_value, # BoatModel
   qualifierBoatSeaworthy => $some_value, # YesNoOption
   qualifierBoatTrailer => $some_value, # YesNoOption
   qualifierBoatHullType => $some_value, # BoatHullType
   qualifierLivestockType => $some_value, # LivestockType
   qualifierAnimalVaccinated => $some_value, # YesNoOption
   qualifierAnimalRegistered => $some_value, # YesNoOption
   qualifierAnimalType => $some_value, # AnimalType
   qualifierAnimalBreed => $some_value, # AnimalBreed
   qualifierAnimalSex => $some_value, # Sex
   qualifierAnimalAge => $some_value, # AnimalAge
   qualifierAnimalCrate => $some_value, # AnimalCrate
   distanceMeasurementType => $some_value, # DistanceMeasurementType
   weightMeasurementType => $some_value, # WeightMeasurementType
   length => $some_value, # Length
   width => $some_value, # Width
   height => $some_value, # Height
   weight => $some_value, # Weight
   quantity => $some_value, # Quantity
   description => $some_value, # ItemDescription
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

