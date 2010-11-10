use lib 'lib';
use lib '../lib';
use MyInterfaces::BarCode::BarCodeSoap;
my $interface = MyInterfaces::BarCode::BarCodeSoap->new();
my $barcode = $interface->GenerateBarCode(  {
           BarCodeParam =>     { # MyTypes::BarCodeData
             Height =>  42, # int
             Width =>  120, # int
             Angle =>  90, # int
             Ratio =>  1, # int
             Module =>  1, # int
             Left =>  10, # int
             Top =>  10, # int
             CheckSum =>  0, # boolean
             FontName =>  'Arial', # string
             BarColor =>  'black', # string
             BGColor =>  'white', # string
             FontSize =>  6.25, # float
             barcodeOption => 'Both', # BarcodeOption
             barcodeType => 'CodeMSI', # BarcodeType
             checkSumMethod => 'None', # CheckSumMethod
             showTextPosition => 'TopLeft', # ShowTextPosition
             BarCodeImageFormat => 'PNG', # ImageFormats
           },
           BarCodeText =>  'JustSomeText', # string
         },
        );
die $barcode if not ($barcode);
print $barcode;
