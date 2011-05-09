
package Shipment::UPS::WSDL::ShipElements::ShipmentRequest;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0' }

__PACKAGE__->__set_name('ShipmentRequest');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Request_of :ATTR(:get<Request>);
my %Shipment_of :ATTR(:get<Shipment>);
my %LabelSpecification_of :ATTR(:get<LabelSpecification>);

__PACKAGE__->_factory(
    [ qw(        Request
        Shipment
        LabelSpecification

    ) ],
    {
        'Request' => \%Request_of,
        'Shipment' => \%Shipment_of,
        'LabelSpecification' => \%LabelSpecification_of,
    },
    {
        'Request' => 'Shipment::UPS::WSDL::ShipElements::Request',

        'Shipment' => 'Shipment::UPS::WSDL::ShipTypes::ShipmentType',
        'LabelSpecification' => 'Shipment::UPS::WSDL::ShipTypes::LabelSpecificationType',
    },
    {

        'Request' => '',
        'Shipment' => 'Shipment',
        'LabelSpecification' => 'LabelSpecification',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::UPS::WSDL::ShipElements::ShipmentRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
ShipmentRequest from the namespace http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Request

 $element->set_Request($data);
 $element->get_Request();


Note: The name of this property has been altered, because it didn't match
perl's notion of variable/subroutine names. The altered name is used in
perl code only, XML output uses the original name:

 



=item * Shipment

 $element->set_Shipment($data);
 $element->get_Shipment();




=item * LabelSpecification

 $element->set_LabelSpecification($data);
 $element->get_LabelSpecification();





=back


=head1 METHODS

=head2 new

 my $element = Shipment::UPS::WSDL::ShipElements::ShipmentRequest->new($data);

Constructor. The following data structure may be passed to new():

 {
   Request =>  { # Shipment::UPS::WSDL::ShipTypes::RequestType
     RequestOption =>  $some_value, # string
     TransactionReference =>  { # Shipment::UPS::WSDL::ShipTypes::TransactionReferenceType
       CustomerContext =>  $some_value, # string
       TransactionIdentifier =>  $some_value, # string
     },
   },
   Shipment =>  { # Shipment::UPS::WSDL::ShipTypes::ShipmentType
     Description =>  $some_value, # string
     ReturnService =>  { # Shipment::UPS::WSDL::ShipTypes::ReturnServiceType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     DocumentsOnlyIndicator =>  $some_value, # string
     Shipper =>  { # Shipment::UPS::WSDL::ShipTypes::ShipperType
       ShipperNumber =>  $some_value, # string
       FaxNumber =>  $some_value, # string
       EMailAddress =>  $some_value, # string
       Address =>  { # Shipment::UPS::WSDL::ShipTypes::ShipAddressType
         AddressLine =>  $some_value, # string
         City =>  $some_value, # string
         StateProvinceCode =>  $some_value, # string
         PostalCode =>  $some_value, # string
         CountryCode =>  $some_value, # string
       },
     },
     ShipTo =>  { # Shipment::UPS::WSDL::ShipTypes::ShipToType
       FaxNumber =>  $some_value, # string
       EMailAddress =>  $some_value, # string
       Address =>  { # Shipment::UPS::WSDL::ShipTypes::ShipToAddressType
         ResidentialAddressIndicator =>  $some_value, # string
       },
       LocationID =>  $some_value, # string
     },
     ShipFrom =>  { # Shipment::UPS::WSDL::ShipTypes::ShipFromType
       FaxNumber =>  $some_value, # string
       Address => {}, # Shipment::UPS::WSDL::ShipTypes::ShipAddressType
     },
     PaymentInformation =>  { # Shipment::UPS::WSDL::ShipTypes::PaymentInfoType
       ShipmentCharge =>  { # Shipment::UPS::WSDL::ShipTypes::ShipmentChargeType
         Type =>  $some_value, # string
         BillShipper =>  { # Shipment::UPS::WSDL::ShipTypes::BillShipperType
           AccountNumber =>  $some_value, # string
           CreditCard =>  { # Shipment::UPS::WSDL::ShipTypes::CreditCardType
             Type =>  $some_value, # string
             Number =>  $some_value, # string
             ExpirationDate =>  $some_value, # string
             SecurityCode =>  $some_value, # string
             Address =>  { # Shipment::UPS::WSDL::ShipTypes::CreditCardAddressType
               AddressLine =>  $some_value, # string
               City =>  $some_value, # string
               StateProvinceCode =>  $some_value, # string
               PostalCode =>  $some_value, # string
               CountryCode =>  $some_value, # string
             },
           },
         },
         BillReceiver =>  { # Shipment::UPS::WSDL::ShipTypes::BillReceiverType
           AccountNumber =>  $some_value, # string
           Address =>  { # Shipment::UPS::WSDL::ShipTypes::BillReceiverAddressType
             PostalCode =>  $some_value, # string
           },
         },
         BillThirdParty =>  { # Shipment::UPS::WSDL::ShipTypes::BillThirdPartyChargeType
           AccountNumber =>  $some_value, # string
           Address =>  { # Shipment::UPS::WSDL::ShipTypes::AccountAddressType
             PostalCode =>  $some_value, # string
             CountryCode =>  $some_value, # string
           },
         },
         ConsigneeBilledIndicator =>  $some_value, # string
       },
       SplitDutyVATIndicator =>  $some_value, # string
     },
     FRSPaymentInformation =>  { # Shipment::UPS::WSDL::ShipTypes::FRSPaymentInfoType
       Type =>  { # Shipment::UPS::WSDL::ShipTypes::PaymentType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       AccountNumber =>  $some_value, # string
       Address => {}, # Shipment::UPS::WSDL::ShipTypes::AccountAddressType
     },
     GoodsNotInFreeCirculationIndicator =>  $some_value, # string
     ShipmentRatingOptions =>  { # Shipment::UPS::WSDL::ShipTypes::RateInfoType
       NegotiatedRatesIndicator =>  $some_value, # string
       FRSShipmentIndicator =>  $some_value, # string
     },
     MovementReferenceNumber =>  $some_value, # string
     ReferenceNumber =>  { # Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType
       BarCodeIndicator =>  $some_value, # string
       Code =>  $some_value, # string
       Value =>  $some_value, # string
     },
     Service =>  { # Shipment::UPS::WSDL::ShipTypes::ServiceType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     InvoiceLineTotal =>  { # Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType
       CurrencyCode =>  $some_value, # string
       MonetaryValue =>  $some_value, # string
     },
     ShipmentServiceOptions =>  {
     },
     Package =>  { # Shipment::UPS::WSDL::ShipTypes::PackageType
       Description =>  $some_value, # string
       Packaging =>  { # Shipment::UPS::WSDL::ShipTypes::PackagingType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       Dimensions =>  { # Shipment::UPS::WSDL::ShipTypes::DimensionsType
         UnitOfMeasurement =>  { # Shipment::UPS::WSDL::ShipTypes::ShipUnitOfMeasurementType
           Code =>  $some_value, # string
           Description =>  $some_value, # string
         },
         Length =>  $some_value, # string
         Width =>  $some_value, # string
         Height =>  $some_value, # string
       },
       PackageWeight =>  { # Shipment::UPS::WSDL::ShipTypes::PackageWeightType
         UnitOfMeasurement => {}, # Shipment::UPS::WSDL::ShipTypes::ShipUnitOfMeasurementType
         Weight =>  $some_value, # string
       },
       LargePackageIndicator =>  $some_value, # string
       ReferenceNumber => {}, # Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType
       AdditionalHandlingIndicator =>  $some_value, # string
       PackageServiceOptions =>  { # Shipment::UPS::WSDL::ShipTypes::PackageServiceOptionsType
         DeliveryConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::DeliveryConfirmationType
           DCISType =>  $some_value, # string
           DCISNumber =>  $some_value, # string
         },
         DeclaredValue =>  { # Shipment::UPS::WSDL::ShipTypes::PackageDeclaredValueType
           Type =>  { # Shipment::UPS::WSDL::ShipTypes::DeclaredValueType
             Code =>  $some_value, # string
             Description =>  $some_value, # string
           },
           CurrencyCode =>  $some_value, # string
           MonetaryValue =>  $some_value, # string
         },
         COD =>  { # Shipment::UPS::WSDL::ShipTypes::PSOCODType
           CODFundsCode =>  $some_value, # string
           CODAmount => {}, # Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType
         },
         VerbalConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::VerbalConfirmationType
           ContactInfo =>  { # Shipment::UPS::WSDL::ShipTypes::ContactInfoType
             Name =>  $some_value, # string
             Phone =>  { # Shipment::UPS::WSDL::ShipTypes::ShipPhoneType
               Number =>  $some_value, # string
               Extension =>  $some_value, # string
             },
           },
         },
         ShipperReleaseIndicator =>  $some_value, # string
         Notification =>  { # Shipment::UPS::WSDL::ShipTypes::PSONotificationType
           NotificationCode =>  $some_value, # string
           EMail =>  { # Shipment::UPS::WSDL::ShipTypes::EmailDetailsType
             EMailAddress =>  $some_value, # string
             UndeliverableEMailAddress =>  $some_value, # string
             FromEMailAddress =>  $some_value, # string
             FromName =>  $some_value, # string
             Memo =>  $some_value, # string
             Subject =>  $some_value, # string
             SubjectCode =>  $some_value, # string
           },
         },
         ReturnsFlexibleAccessIndicator =>  $some_value, # string
       },
       Commodity =>  { # Shipment::UPS::WSDL::ShipTypes::CommodityType
         FreightClass =>  $some_value, # string
         NMFC =>  { # Shipment::UPS::WSDL::ShipTypes::NMFCType
           PrimeCode =>  $some_value, # string
           SubCode =>  $some_value, # string
         },
       },
     },
   },
   LabelSpecification =>  { # Shipment::UPS::WSDL::ShipTypes::LabelSpecificationType
     LabelImageFormat =>  { # Shipment::UPS::WSDL::ShipTypes::LabelImageFormatType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     HTTPUserAgent =>  $some_value, # string
     LabelStockSize =>  { # Shipment::UPS::WSDL::ShipTypes::LabelStockSizeType
       Height =>  $some_value, # string
       Width =>  $some_value, # string
     },
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

