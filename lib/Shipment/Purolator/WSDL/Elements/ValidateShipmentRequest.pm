
package Shipment::Purolator::WSDL::Elements::ValidateShipmentRequest;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://purolator.com/pws/datatypes/v1' }

__PACKAGE__->__set_name('ValidateShipmentRequest');
__PACKAGE__->__set_nillable(1);
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();
use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    Shipment::Purolator::WSDL::Types::ValidateShipmentRequestContainer
);

}

1;


=pod

=head1 NAME

Shipment::Purolator::WSDL::Elements::ValidateShipmentRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
ValidateShipmentRequest from the namespace http://purolator.com/pws/datatypes/v1.







=head1 METHODS

=head2 new

 my $element = Shipment::Purolator::WSDL::Elements::ValidateShipmentRequest->new($data);

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDL::Types::ValidateShipmentRequestContainer
   Shipment =>  { # Shipment::Purolator::WSDL::Types::Shipment
     SenderInformation =>  { # Shipment::Purolator::WSDL::Types::SenderInformation
       Address =>  { # Shipment::Purolator::WSDL::Types::Address
         Name =>  $some_value, # string
         Company =>  $some_value, # string
         Department =>  $some_value, # string
         StreetNumber =>  $some_value, # string
         StreetSuffix =>  $some_value, # string
         StreetName =>  $some_value, # string
         StreetType =>  $some_value, # string
         StreetDirection =>  $some_value, # string
         Suite =>  $some_value, # string
         Floor =>  $some_value, # string
         StreetAddress2 =>  $some_value, # string
         StreetAddress3 =>  $some_value, # string
         City =>  $some_value, # string
         Province =>  $some_value, # string
         Country =>  $some_value, # string
         PostalCode =>  $some_value, # string
         PhoneNumber =>  { # Shipment::Purolator::WSDL::Types::PhoneNumber
           CountryCode =>  $some_value, # string
           AreaCode =>  $some_value, # string
           Phone =>  $some_value, # string
           Extension =>  $some_value, # string
         },
         FaxNumber => {}, # Shipment::Purolator::WSDL::Types::PhoneNumber
       },
       TaxNumber =>  $some_value, # string
     },
     ReceiverInformation =>  { # Shipment::Purolator::WSDL::Types::ReceiverInformation
       Address => {}, # Shipment::Purolator::WSDL::Types::Address
       TaxNumber =>  $some_value, # string
     },
     PackageInformation =>  { # Shipment::Purolator::WSDL::Types::PackageInformation
       ServiceID =>  $some_value, # string
       Description =>  $some_value, # string
       TotalWeight =>  { # Shipment::Purolator::WSDL::Types::TotalWeight
         Value =>  $some_value, # int
         WeightUnit => $some_value, # WeightUnit
       },
       TotalPieces =>  $some_value, # int
       PiecesInformation =>  { # Shipment::Purolator::WSDL::Types::ArrayOfPiece
         Piece =>  { # Shipment::Purolator::WSDL::Types::Piece
           Weight =>  { # Shipment::Purolator::WSDL::Types::Weight
             Value =>  $some_value, # decimal
             WeightUnit => $some_value, # WeightUnit
           },
           Length =>  { # Shipment::Purolator::WSDL::Types::Dimension
             Value =>  $some_value, # decimal
             DimensionUnit => $some_value, # DimensionUnit
           },
           Width => {}, # Shipment::Purolator::WSDL::Types::Dimension
           Height => {}, # Shipment::Purolator::WSDL::Types::Dimension
           Options =>  { # Shipment::Purolator::WSDL::Types::ArrayOfOptionIDValuePair
             OptionIDValuePair =>  { # Shipment::Purolator::WSDL::Types::OptionIDValuePair
               ID =>  $some_value, # string
               Value =>  $some_value, # string
             },
           },
         },
       },
       DangerousGoodsDeclarationDocumentIndicator =>  $some_value, # boolean
       OptionsInformation =>  { # Shipment::Purolator::WSDL::Types::OptionsInformation
         Options => {}, # Shipment::Purolator::WSDL::Types::ArrayOfOptionIDValuePair
         ExpressChequeAddress => {}, # Shipment::Purolator::WSDL::Types::Address
       },
     },
     InternationalInformation =>  { # Shipment::Purolator::WSDL::Types::InternationalInformation
       DocumentsOnlyIndicator =>  $some_value, # boolean
       ContentDetails =>  { # Shipment::Purolator::WSDL::Types::ArrayOfContentDetail
         ContentDetail =>  { # Shipment::Purolator::WSDL::Types::ContentDetail
           Description =>  $some_value, # string
           HarmonizedCode =>  $some_value, # string
           CountryOfManufacture =>  $some_value, # string
           ProductCode =>  $some_value, # string
           UnitValue =>  $some_value, # decimal
           Quantity =>  $some_value, # int
           NAFTADocumentIndicator =>  $some_value, # boolean
           FDADocumentIndicator =>  $some_value, # boolean
           FCCDocumentIndicator =>  $some_value, # boolean
           SenderIsProducerIndicator =>  $some_value, # boolean
           TextileIndicator =>  $some_value, # boolean
           TextileManufacturer =>  $some_value, # string
         },
       },
       BuyerInformation =>  { # Shipment::Purolator::WSDL::Types::BuyerInformation
         Address => {}, # Shipment::Purolator::WSDL::Types::Address
         TaxNumber =>  $some_value, # string
       },
       PreferredCustomsBroker =>  $some_value, # string
       DutyInformation =>  { # Shipment::Purolator::WSDL::Types::DutyInformation
         BillDutiesToParty => $some_value, # BillDutiesToParty
         BusinessRelationship => $some_value, # BusinessRelationship
         Currency => $some_value, # DutyCurrency
       },
       ImportExportType => $some_value, # ImportExportType
       CustomsInvoiceDocumentIndicator =>  $some_value, # boolean
     },
     ReturnShipmentInformation =>  { # Shipment::Purolator::WSDL::Types::ReturnShipmentInformation
       NumberOfReturnShipments =>  $some_value, # int
       ReturnShipment =>  { # Shipment::Purolator::WSDL::Types::ReturnShipment
         SenderInformation => {}, # Shipment::Purolator::WSDL::Types::SenderInformation
         ReceiverInformation => {}, # Shipment::Purolator::WSDL::Types::ReceiverInformation
         PackageInformation => {}, # Shipment::Purolator::WSDL::Types::PackageInformation
         PaymentInformation =>  { # Shipment::Purolator::WSDL::Types::PaymentInformation
           PaymentType => $some_value, # PaymentType
           RegisteredAccountNumber =>  $some_value, # string
           BillingAccountNumber =>  $some_value, # string
           CreditCardInformation =>  { # Shipment::Purolator::WSDL::Types::CreditCardInformation
             Type => $some_value, # CreditCardType
             Number =>  $some_value, # string
             Name =>  $some_value, # string
             ExpiryMonth =>  $some_value, # int
             ExpiryYear =>  $some_value, # int
             CVV =>  $some_value, # string
           },
         },
         PickupInformation =>  { # Shipment::Purolator::WSDL::Types::PickupInformation
           PickupType => $some_value, # PickupType
         },
         NotificationInformation =>  { # Shipment::Purolator::WSDL::Types::NotificationInformation
           ConfirmationEmailAddress =>  $some_value, # string
           AdvancedShippingNotificationEmailAddress1 =>  $some_value, # string
           AdvancedShippingNotificationEmailAddress2 =>  $some_value, # string
           AdvancedShippingNotificationMessage =>  $some_value, # string
         },
         TrackingReferenceInformation =>  { # Shipment::Purolator::WSDL::Types::TrackingReferenceInformation
           Reference1 =>  $some_value, # string
           Reference2 =>  $some_value, # string
           Reference3 =>  $some_value, # string
           Reference4 =>  $some_value, # string
         },
         OtherInformation =>  { # Shipment::Purolator::WSDL::Types::OtherInformation
           CostCentre =>  $some_value, # string
           SpecialInstructions =>  $some_value, # string
         },
       },
     },
     PaymentInformation => {}, # Shipment::Purolator::WSDL::Types::PaymentInformation
     PickupInformation => {}, # Shipment::Purolator::WSDL::Types::PickupInformation
     NotificationInformation => {}, # Shipment::Purolator::WSDL::Types::NotificationInformation
     TrackingReferenceInformation => {}, # Shipment::Purolator::WSDL::Types::TrackingReferenceInformation
     OtherInformation => {}, # Shipment::Purolator::WSDL::Types::OtherInformation
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

