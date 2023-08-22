import 'dart:io';
import 'dart:ui';
import 'package:pdf/pdf.dart' as pdf;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_generate/Modal/InsideInventory.dart';
import 'package:printing/printing.dart';
import 'Modal/Model.dart';
import 'HealthIndicatorTemplate.dart';
import 'PDFScreen.dart';
import 'add_signature_screen.dart';
import 'package:pdf_generate/Utils.dart';

class pre_order_print_view extends StatefulWidget {
  Uint8List? imageData;
  bool isChecked = false;
  final Function(Uint8List) generatePDFFromCallBack;

  pre_order_print_view(this.imageData, this.generatePDFFromCallBack);

  @override
  _pre_order_print_viewState createState() => _pre_order_print_viewState();
}

class ProfileModel {
  String? name;
  String? address;
  String? mobileNumber;
  String? callerName;
  String? callerNumber;
  String? srNumber;
  String? recivedOn;

  String? regNo;
  String? vin;
  String? model;
  String? firstRangeDate;
  String? milage;
  String? drop;
  String? lastService;
  String? lastServiceMilage;

  ProfileModel(
      {this.name,
      this.address,
      this.mobileNumber,
      this.callerName,
      this.callerNumber,
      this.srNumber,
      this.recivedOn,
      this.regNo,
      this.vin,
      this.model,
      this.firstRangeDate,
      this.milage,
      this.drop,
      this.lastService,
      this.lastServiceMilage});
}

class GenericConfigs {
  String? field_one;
  String? field_two;
  String? field_three;
  String? field_four;

  GenericConfigs(
      {this.field_one, this.field_two, this.field_three, this.field_four});
}

class PaymentTypeModel {
  String? paymentMode;
  bool? isSelcted;

  PaymentTypeModel({
    this.paymentMode,
    this.isSelcted,
  });
}

class _pre_order_print_viewState extends State<pre_order_print_view> with RouteAware {
  final engineCompartment = [
    GenericConfigs(
        field_one: "1",
        field_two: "Fluid level and Quality",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "2",
        field_two: "Hose Connection and leakage",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "3",
        field_two: "V-Belt Connection",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "4",
        field_two: "Battery Connection",
        field_three: "",
        field_four: ""),
  ];

  final isOnlyHealthCard = false;

  final insideCabinList = [
    GenericConfigs(
        field_one: "1",
        field_two: "Power Window Operation",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "2",
        field_two: "Horn Operation",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "3",
        field_two: "Seat Belt Operation",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "4",
        field_two: "Interior Illumination",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "5",
        field_two: "Radio Operation",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "6",
        field_two: "ORVMS Operation",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "7",
        field_two: "Wiper and Windshield Operation",
        field_three: "",
        field_four: "")
  ];
  final underBodyList = [
    GenericConfigs(
        field_one: "1",
        field_two: "Fuel leakage (if any)",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "2",
        field_two: "Condition of engine & Transmission Mountings",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "3",
        field_two: "Condition of Suspension Bushes and Links",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "4",
        field_two: "Tyre Condition(Damage, Bulge, cut if any)",
        field_three: "",
        field_four: ""),
    GenericConfigs(
        field_one: "5",
        field_two: "External Damages",
        field_three: "",
        field_four: ""),
  ];
  final customerConcernList = [
    GenericConfigs(field_one: "1", field_two: "Service", field_three: ""),
  ];
  final serviceAdviceDetails = [
    GenericConfigs(
        field_one: "Raj Kumar",
        field_two: "",
        field_three: "cde16@silverarrows.in",
        field_four: "10/05/23 15:00"),
  ];
  final ProfileModel singleProfile = ProfileModel(
      name: "Absolute772",
      address:
          "101 Street, Florida, 247 FBI Building and CIA HeadQuarters, United State, Pin-112009",
      mobileNumber: "+12 98765456789",
      callerName: "Absolute772",
      callerNumber: "+91 9784239393",
      srNumber: "+21 3432434343",
      recivedOn: "12/12/15 12:00:00",
      regNo: "DLC2BC1810",
      vin: "W13232424343434",
      model: "Mercedics Benz - C200",
      firstRangeDate: "23/01/2015",
      milage: "29830",
      drop: "Yes",
      lastService: "12/12/15 12:00:00",
      lastServiceMilage: "2295345");

  pw.Widget singleRow(String name, String value, double xWidth) {
    return pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.SizedBox(
                width: xWidth,
                child: pw.Text(name,
                    style: pw.TextStyle(fontSize: contentFontSize))),
            pw.Text(": $value", style: pw.TextStyle(fontSize: contentFontSize))
          ],
        ));
  }

  pw.Widget singleTableFourCols(
      String rowTitle1, String rowTitle2, String rowTitle3, String rowTitle4,
      {required List<GenericConfigs> source}) {
    return pw.Table(
      border: pw.TableBorder.all(width: 1),
      columnWidths: {
        0: pw.FractionColumnWidth(0.1),
        1: pw.FractionColumnWidth(0.2),
        2: pw.FractionColumnWidth(0.25),
        3: pw.FractionColumnWidth(0.3),
      },
      children: List<pw.TableRow>.generate(source.length + 1, (index) {
        if (index == 0) {
          return _buildPdfRows([rowTitle1, rowTitle2, rowTitle3, rowTitle4],
              isHeader: true);
        } else {
          return _buildPdfRows([
            source[index - 1].field_one ?? "",
            source[index - 1].field_two ?? "",
            source[index - 1].field_three ?? "",
            source[index - 1].field_four ?? ""
          ]);
        }
      }),
    );
  }

  pw.Widget singleRowWithImageAndTitle(String name) {
    return pw.Row(children: [
      pw.Image(static_image['check_box']!),
      pw.SizedBox(width: 3),
      pw.Text(name, style: const pw.TextStyle(fontSize: 8))
    ]);
  }

  late final BuildContext builderContext;

  var contentPadding = 20.0;
  var fontSize = 17.0;
  var headingFontSize = 10.0;
  var contentFontSize = 8.0;

  List<InsideInventory> insideInventories = [
    InsideInventory(type: "Body Cover", value: false),
    InsideInventory(type: "Pen Drive", value: false),
    InsideInventory(type: "Bonnet Star", value: true),
    InsideInventory(type: "Registration Paper", value: false),
    InsideInventory(type: "Service Book", value: false),
    InsideInventory(type: "Tool Kit", value: true),
    InsideInventory(type: "Spare Wheel", value: true),
    InsideInventory(type: "Jack", value: false),
    InsideInventory(type: "Mats", value: true),
    InsideInventory(type: "CDs", value: false),
    InsideInventory(type: "First Aid Kit", value: false),
    InsideInventory(type: "Keychain", value: false),
    InsideInventory(type: "Idol", value: true),
    InsideInventory(type: "Hub Caps", value: true),
    InsideInventory(type: "Test mats", value: true),
    InsideInventory(type: "Any other belongings", value: ""),
    InsideInventory(type: "Fuel Level", value: "92%")
  ];
  List<PaymentTypeModel> paymentModes = [
    PaymentTypeModel(paymentMode: "Cash", isSelcted: false),
    PaymentTypeModel(paymentMode: "Credit Card", isSelcted: false),
    PaymentTypeModel(paymentMode: "Credit", isSelcted: false),
    PaymentTypeModel(paymentMode: "Cheque", isSelcted: false),
    PaymentTypeModel(paymentMode: "RTGS", isSelcted: false),
  ];
  List<ServiceCheckPoint> nextServiceCheckPoints = [
    ServiceCheckPoint(isSelected: false, checkPointName: 'Oil and Fluids'),
    ServiceCheckPoint(isSelected: false, checkPointName: 'Oil Filter'),
    ServiceCheckPoint(isSelected: false, checkPointName: 'Air Filter'),
    ServiceCheckPoint(isSelected: false, checkPointName: 'Transmission Filter'),
    ServiceCheckPoint(isSelected: false, checkPointName: 'AC Filter'),
    ServiceCheckPoint(isSelected: false, checkPointName: 'Wiper'),
    ServiceCheckPoint(isSelected: false, checkPointName: 'V-Belt'),
    ServiceCheckPoint(isSelected: false, checkPointName: 'Spark Plug'),
  ];
  HealthCardData healthCardData = HealthCardData(
      healthMeter: models,
      batteryCondition:
          BatteryCondition(hasGoodCondition: false, changeBattery: false),
      voltage: "240",
      genuineData: GenuineData(isGenuine: false, isNonGenuine: false),
      isNoFaults: false,
      remarks: "Remark added",
      personalizedAdvice: "Please come for servicing on time.",
      nextMaintenanceInterval: NextMaintenanceInterval(
          futureKilometers: "234567", nextDueDate: "12/4/2024"),
      serviceCheckPointList: [ServiceCheckPoint()]);
  List<Map<String, dynamic>> items = [
    {
      "description": "Content 1",
      "rate": "\$50/hr",
      "hours": "4",
      "amount": "\$200.00"
    },
    {
      "description": "Content 2",
      "rate": "\$100/hr",
      "hours": "9",
      "amount": "\$450.00"
    },
    {
      "description": "Content 3",
      "rate": "\$80/hr",
      "hours": "16",
      "amount": "\$290.00"
    },
    {
      "description": "Content 4",
      "rate": "\$120/hr",
      "hours": "25",
      "amount": "\$180.00"
    },
    {
      "description": "Content 5",
      "rate": "\$200/hr",
      "hours": "36",
      "amount": "\$360.00"
    },
    {
      "description": "Content 1",
      "rate": "\$50/hr",
      "hours": "4",
      "amount": "\$200.00"
    },
    {
      "description": "Content 2",
      "rate": "\$100/hr",
      "hours": "9",
      "amount": "\$450.00"
    },
    {
      "description": "Content 3",
      "rate": "\$80/hr",
      "hours": "16",
      "amount": "\$290.00"
    },
    {
      "description": "Content 4",
      "rate": "\$120/hr",
      "hours": "25",
      "amount": "\$180.00"
    },
    {
      "description": "Content 5",
      "rate": "\$200/hr",
      "hours": "36",
      "amount": "\$360.00"
    },
    {
      "description": "Content 1",
      "rate": "\$50/hr",
      "hours": "4",
      "amount": "\$200.00"
    },
    {
      "description": "Content 2",
      "rate": "\$100/hr",
      "hours": "9",
      "amount": "\$450.00"
    },
    {
      "description": "Content 3",
      "rate": "\$80/hr",
      "hours": "16",
      "amount": "\$290.00"
    },
    {
      "description": "Content 4",
      "rate": "\$120/hr",
      "hours": "25",
      "amount": "\$180.00"
    },
    {
      "description": "Content 5",
      "rate": "\$200/hr",
      "hours": "36",
      "amount": "\$360.00"
    },
    {
      "description": "Content 1",
      "rate": "\$50/hr",
      "hours": "4",
      "amount": "\$200.00"
    },
    {
      "description": "Content 2",
      "rate": "\$100/hr",
      "hours": "9",
      "amount": "\$450.00"
    },
    {
      "description": "Content 3",
      "rate": "\$80/hr",
      "hours": "16",
      "amount": "\$290.00"
    },
    {
      "description": "Content 4",
      "rate": "\$120/hr",
      "hours": "25",
      "amount": "\$180.00"
    },
    {
      "description": "Content 5",
      "rate": "\$200/hr",
      "hours": "36",
      "amount": "\$360.00"
    },
    {
      "description": "Content 1",
      "rate": "\$50/hr",
      "hours": "4",
      "amount": "\$200.00"
    },
    {
      "description": "Content 2",
      "rate": "\$100/hr",
      "hours": "9",
      "amount": "\$450.00"
    },
    {
      "description": "Content 3",
      "rate": "\$80/hr",
      "hours": "16",
      "amount": "\$290.00"
    },
    {
      "description": "Content 4",
      "rate": "\$120/hr",
      "hours": "25",
      "amount": "\$180.00"
    },
    {
      "description": "Content 5",
      "rate": "\$200/hr",
      "hours": "36",
      "amount": "\$360.00"
    },
    {
      "description": "Content 1",
      "rate": "\$50/hr",
      "hours": "4",
      "amount": "\$200.00"
    },
    {
      "description": "Content 2",
      "rate": "\$100/hr",
      "hours": "9",
      "amount": "\$450.00"
    },
    {
      "description": "Content 3",
      "rate": "\$80/hr",
      "hours": "16",
      "amount": "\$290.00"
    },
    {
      "description": "Content 4",
      "rate": "\$120/hr",
      "hours": "25",
      "amount": "\$180.00"
    },
    {
      "description": "Content 5",
      "rate": "\$200/hr",
      "hours": "36",
      "amount": "\$360.00"
    },
  ];
  List<String> imageArray = [
    'assets/images/IMG_4641.PNG',
    'assets/images/IMG_4641.PNG',
    'assets/images/IMG_4642.PNG',
    'assets/images/IMG_4643.PNG',
    'assets/images/IMG_4644.PNG'
  ];
  bool isTermsConditionAccepted = false;
  Map<String, pw.ImageProvider> static_image = {};
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  @override
  void initState() {
    super.initState();
    getStaticImages();
    builderContext = context;
    imageProviders = getImageProviderFromImageArray();
    if (widget.imageData != null) {
      generatePDF();
    }
    healthCardData.serviceCheckPointList = nextServiceCheckPoints;
  }

  void getStaticImages() async {
    static_image = {
      "check_box_empty":
          await imageFromPath("assets/images/check_box_empty.png"),
      "done": await imageFromPath("assets/images/done.png"),
      "check_box": await imageFromPath("assets/images/check_box.png"),
      "benz_logo": await imageFromPath("assets/images/benz_logo.png"),
      "fullTriangle": await imageFromPath("assets/images/Group 12.png"),
      "halfTriangle": await imageFromPath("assets/images/Group 13.png"),
      "emptyTriangle": await imageFromPath("assets/images/Group 14.png"),
      "blankTriangle": await imageFromPath("assets/images/Group 15.png"),
      "unselected_checkBox":
          await imageFromPath("assets/images/check box selected.png"),
      "damage": await imageFromPath("assets/images/damage_icon.png"),
      "scratch": await imageFromPath("assets/images/scratch_black_icon.png"),
      "dent": await imageFromPath("assets/images/dent_icon.png"),
      "missing": await imageFromPath("assets/images/missing_icon.png"),
      "corrosion": await imageFromPath("assets/images/corrosion_icon.png"),
    };
  }

  List<pw.ImageProvider> imageProviders = [];

  List<pw.MemoryImage> getImageProviderFromImageArray() {
    List<pw.MemoryImage> memoryImageArray = [];
    imageArray.forEach((element) async {
      final memoryImage = await imageFromPath(element.toString());
      memoryImageArray.add(memoryImage);
    });
    return memoryImageArray;
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document(
      pageMode: PdfPageMode.fullscreen,
    );

    final car_imagePath = "assets/images/car.png";
    final ByteData car_imageByteData = await rootBundle.load(car_imagePath);
    final Uint8List car_imageData = car_imageByteData.buffer.asUint8List();
    final car_image = pw.MemoryImage(car_imageData);

    final newAKRows = <pw.Widget>[];
    final rowItemCount = 2;

    for (var i = 0; i < imageArray.length; i += rowItemCount) {
      final currentImage = await imageFromPath(imageArray[i]);
      final endIndex = i + rowItemCount;
      final rowItems = imageArray
          .sublist(i, endIndex.clamp(0, imageArray.length))
          .map((item) {
        return pw.Container(
          width: (MediaQuery.of(builderContext).size.width - 500) / 2,
          height: 150,
          child: pw.Center(
            child: pw.Image(currentImage),
          ),
        );
      }).toList();

      final newRowItems = pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: rowItems,
      );
      newAKRows.add(newRowItems);
    }

    final images = getImageProviderFromImageArray();

    pw.Image getImageForSpecItemValue(String specItemValue) {
      double value = double.parse(specItemValue);

      if (value >= 1 && value < 2) {
        return pw.Image(static_image["emptyTriangle"]!);
      } else if (value >= 2 && value < 4) {
        return pw.Image(static_image["halfTriangle"]!);
      } else if (value >= 4 && value <= 6) {
        return pw.Image(static_image["fullTriangle"]!);
      } else {
        return pw.Image(static_image["blankTriangle"]!);
      }
    }

    // Assuming you have an array called `items` with a count of 8
    List<String> items = [
      'item1',
      'item2',
      'item3',
      'item4',
      'item5',
      'item6',
      'item7',
      'item8'
    ];

    int columns = 4;
    int rows = 2;

    List<pw.Row> gridRows = [];

    for (int i = 0; i < rows; i++) {
      // Create a list to store the widgets in the current row
      List<pw.Widget> rowWidgets = [];

      // Iterate through the columns
      for (int j = 0; j < columns; j++) {
        int index = i * columns + j;
        if (index < items.length) {
          // Create a widget for the current item
          pw.Widget widget = pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Image(
                    height: 10, width: 10, static_image["check_box_empty"]!),
              ),
              pw.SizedBox(width: 3),
              pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 20),
                  child: pw.Text(items[index],
                      style: const pw.TextStyle(fontSize: 8))),
              pw.SizedBox(width: 20),
            ],
          );
          rowWidgets.add(widget);
        }
      }

      // Create a Row with the widgets for the current row
      pw.Row row = pw.Row(children: rowWidgets);

      // Add the row to the list of rows
      gridRows.add(row);
    }

    pw.Column grid = pw.Column(children: gridRows);

    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(contentPadding * 2),
        // Add margin here
        pageFormat: PdfPageFormat.a4,
        header: (context) {
          // PDF Header
          return pdfHeader();
        },
        footer: (context) {
          // PDF Footer
          return pdfFooter();
        },
        build: (context) {
          return  buildPDfContent(grid);
        }));

    final pdfData = await pdf.save();

    // Save the PDF to a temporary file
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/pre_order_print.pdf");
    await file.writeAsBytes(pdfData);
    // return file;

    // Share PDF via sharing platforms.
    // await Printing.sharePdf(bytes: pdfData, filename: 'pre_order_print.pdf');

    // Open the PDF File using the flutter_pdfview plugin
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PDFScreen(
          filePath: file.path,
          imageData: null,
          regeneratePDF: onDataReceived,
        ),
      ),
    );
  }

  // Building the whole content of pdf
  List<pw.Widget> buildPDfContent(pw.Column grid) {
    return <pw.Widget>[
      // Customer and Vehicle Details
      customerAndVehiclePDFDetails(),

      // To be check if only health card is to be printed
      (isOnlyHealthCard) ? pw.SizedBox() : otherPDFDetails(),

      healthCardPDFDetails(grid),

      termsAndConditionPDFDetails(),

      showPaymentOptionInPdf(),

      // Signature Image
      signaturePDFView(),
    ];
  }

  pw.Widget otherPDFDetails() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        outsideInventoryPDFDetails(),
        pw.NewPage(),
        insideInventoryPDFDetails(),
        pdfTableWith(
            title: "Engine Compartment", source: engineCompartment),
        pdfTableWith(title: "Inside Cabin", source: insideCabinList),
        pw.NewPage(),
        pdfTableWith(title: "Under Body", source: underBodyList),
        remarksPDFDetails(),
        customerConcernPDFDetails(),
        pdfTableWith(
            title: "Service Advisor Details",
            source: serviceAdviceDetails,
            isAdvisorDetails: true),
        pw.NewPage(),
      ]
    );
  }


  pw.Widget pdfHeader() {
    return pw.Column(children: [
      pw.SizedBox(height: 5),
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Row(children: [
              pw.Image(height: 15, width: 15, static_image["benz_logo"]!),
              pw.SizedBox(width: 4),
              pw.Text("Merdes-Benz",
                  style: pw.TextStyle(fontSize: contentFontSize + 2)),
            ]),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text("PRE ORDER",
                      style: pw.TextStyle(
                          fontSize: contentFontSize + 2,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Text("SA082324SER00649",
                      style: pw.TextStyle(
                          fontSize: contentFontSize + 2,
                          fontWeight: pw.FontWeight.bold)),
                ])
          ]),

      pw.SizedBox(height: 10),

      // Heading
      pw.Center(
        child: pw.Column(
          children: [
            pw.Text("Silver Arrow - Workshop Delhi 52 Sohna Road",
                style: pw.TextStyle(
                    fontSize: contentFontSize + 2,
                    fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(
              height: 5,
            ),
            pw.Text("52B Rama Road, New Delhi DL. Ph no: 01148200500",
                style: pw.TextStyle(fontSize: contentFontSize)),
          ],
        ),
      ),

      pw.SizedBox(height: 5),
      pw.Divider(
        color: PdfColors.black,
        height: 2,
      ),

      pw.SizedBox(height: 10),
    ]);
  }

  pw.Widget pdfFooter() {
    return pw.Column(children: [
      pw.SizedBox(height: 10),
      pw.Divider(
        color: PdfColors.black,
        height: 2,
      ),
      pw.SizedBox(height: 5),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
        pw.Image(height: 15, width: 15, static_image["benz_logo"]!),
        pw.SizedBox(width: 4),
        pw.Text("Merdes-Benz ",
            style: pw.TextStyle(fontSize: contentFontSize + 2)),
        pw.SizedBox(width: 4),
        pw.Text(
            "are registered trademarks of Mercedes-Benz AG, Stuttgart, Germany",
            style: pw.TextStyle(fontSize: contentFontSize)),
      ]),
      pw.SizedBox(height: 5),
    ]);
  }


  // void sendEmail() async {
  //   // final file = await generatePDF();
  //   final Uri params = Uri(
  //     scheme: 'mailto',
  //     queryParameters: {
  //       'subject': 'Email subject',
  //       'body': 'Please find the attached PDF.',
  //       'attachment': file.path
  //     },
  //   );
  //
  //   final gmailUrl = 'googlegmail:///co?${params.toString()}';
  //   final url = Uri.encodeFull(gmailUrl);
  //
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  pw.Widget termsAndConditionPDFDetails() {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pdfSectionHeading(title: "Terms and Conditions"),
          pw.SizedBox(height: 3),
          pw.Text(
              style: pw.TextStyle(fontSize: contentFontSize),
              "1. We am solely responsible for the test drives done outside the premises o fdealershio\n2. I/We indemnifyand keept h e Authorized Dealer indemnified againstany costs. risk.liabilitv. responsibility for loss o rdamaget o the vehicle and/ or life or property of al persons arising o u tof test driving of the vehicle by me/us or my/our Authorized Representative. I/We confirmthat I/we have obtained the requisite insurance for the vehicle together with the accessories, components, articlesand/or things containedtherein and theDealer shall i nn owav be liable for any loss. damage or iniury caused to m e/us.\n3. W e will not hold the Dealer responsible/liable for a n delav ni delivery or ni c a r i n g out renairs or procurement of sparenarts for reasons bevond its control\n4. W e undertake to take deliverv of thevehicle within 48 hoursof intimation of completiono frepair or maintenance services. In the event of delavon mw/our part. I/Weagree to dav the stoqqrage charges (Rs1000/-IRuDees One Thousand only) per day.\n5. We are agree to pay to Rs 10000/- (Rupees Ten Thousand only or 5% of the total estimated amount.\n6. I/We undertake to make cavment of all charges before takine deliverv of the vehicleand in the event.the delivery si taken without settlement of the bill. I/We undertake to settlethe billwithin 7davs of taking delivery ofthe vehicle. In the event, the bill is not settled within a period of 7 days,the Authorized Dealer may lew an interest @ 41 %p.a. on the outstanding bill amountfrom the date on whichthe vehicle was ready for delivery until payment.\n7. / eacree thatt h e Authorized Dealerm a vexerciselieno n thevehicle until all the above mentioned dies are settled to its satisfaction\n8. I/Weagree that I will a v anv advance amount asreguired by the Authorized Dealer based on the estimated cost before commencement ofthe repairs/maintenance services\n9. / W ehereby authorize the AuthorizedDealer to deliver t h evehicle to m y/our Authorized Representative\n1O. We agree that any disoutes arisingfrom or o u tof this work order shall be settled mutually. ni case, mutuallyacceotable settlement si not arrived at. such disoute shall be sublect to exclusive junsciction of t h ecourt where t h eAuthorized dealer's Registered Office is located\n11. We agrap and understand that t h eWarranty terms and Conditions areconcurrent tothese Termsa n dConditions\n12. I/We hereby grant free consent to the Authorized Dealer, Mercedes-Benz IndiaPrivate Limited and/or their authorized third parties to contactme/us through SMS, call, email, WhatsApp or anyother electronic, telecommunication or physical medium,from time to time. to provide information me/us the status of repair work. estimated cost of repair work,details of repairs/replacement, vehicle location tracking, invoice and payment andfor to obtain mu four feedbackinrelationtot h eservicesprovided b yt h eAuthorized Dealer\n13. I/We authorize the Authorized Dealer, Mercedes-Benz India PrivateLimitedand/or their authorizedthird partiesot send lal or any communication no information no the status fo repair work,estimated cost of repair work, detailso frepairs/replacement. vehicle location trackine. invoiceand oavment to m y/our Authorized Representative\n14. W e hereby authorize theAuthorized Dealer to track the location o fm yo u rvehicle during the pick up from and drop t othe designated place\n15. I/Weagree and understand that the communicationthrough WhatsApp, SMS, email or anyotherelectronicor telecommunication medium will allow me /us toaccess various information pertaining to services availed any third party\n16. I/We herebv declare that I/wea m fullv awarethat communication throughWhatsAoD. SMS.emailor any other electronic or telecommunicationmedium mav not be secure and the Authorized Dealer shall inn o war be responsible for a n personal data privacy infringements caused by a n vact ro omission of anv other third p a r t ywhich m a v be involved ni making t h ecommunication media services available to me / us and to the Dealer. r a m affixing my signature below in evidence of agreeing to the above t e r m sa n dconditions absolutely and unconditionally"),
          pw.SizedBox(height: contentFontSize),
        ]);
  }

  // Action to be performed after getting signature.
  void onDataReceived(Uint8List data) {
    if (data != null) {
      widget.imageData = data;
      generatePDF();
    }
  }

  pw.ImageProvider uint8listToImage(Uint8List data) {
    return pw.MemoryImage(data);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: customtext(title: "PDF View"),
          actions: [
            ElevatedButton(
                onPressed: generatePDF, child: Icon(Icons.picture_as_pdf)),
            // Generate PDF

            ElevatedButton(
                onPressed: () {}, child: customtext(title: 'Send Mail'))
            //Text("Send Mail"))
            // Send Mail On Button Click
          ],
        ),
        body: _buildContentView(context));
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(children: [
        const SizedBox(height: 5),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Image.asset(height: 15, width: 15, "assets/images/benz_logo.png",),
                const SizedBox(width: 4),
                customtext(title: "Merdes-Benz"),
              ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    customtext(title: "PRE ORDER"),
                    customtext(title: "SA082324SER00649"),
                  ])
            ]),

        const SizedBox(height: 10),

        // Heading
        Center(
          child: Column(
            children: [
              customtext(title: "Silver Arrow - Workshop Delhi 52 Sohna Road"),
              const SizedBox(
                height: 5,
              ),
              customtext(title: "52B Rama Road, New Delhi DL. Ph no: 01148200500"),
            ],
          ),
        ),

        const SizedBox(height: 5),
        const Divider(
          color: Colors.black,
          height: 2,
        ),

        const SizedBox(height: 10),
      ]),
    );
  }

  // Footer for PDF View
  Widget buildFooter() {
    return Column(children: [
    const SizedBox(height: 10),
      const Divider(
        color: Colors.black,
        height: 2,
      ),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(height: 15, width: 15, "assets/images/benz_logo.png"),
        const SizedBox(width: 4),
        customtext(title: "Merdes-Benz"),
        const SizedBox(width: 4),
        customtext(title: "are registered trademarks of Mercedes-Benz AG, Stuttgart, Germany"),
      ]),
      const SizedBox(height: 5),
    ]);
  }

  // Main content of the screen
  Widget _buildContentView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [

        buildHeader(),
        headingData(),
        customerAndVehicleDetails(),
        outsideInventoriesDetails(),
        insideInventoryDetails(),
        engineCompartmentDetails(),
        insideCabinDetails(),
        underBodyDetails(),
        remarksDetails(),
        customerConcernDetails(),
        serviceAdvisorDetails(),
        termsAndConditions(),
        selectPaymentOption(),
        signatureView(),
        healthCardDetails(),
        buildFooter()
      ]),
    );
  }

  pw.Widget pdfSectionHeading({required String title}) {
    return pw.Text(
      title,
      style: pw.TextStyle(
          fontSize: headingFontSize, fontWeight: pw.FontWeight.bold),
    );
  }

  // Customer and vehicle details
  Widget customerAndVehicleDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customtext(
                          title: "CUSTOMER DETAILS",
                          fontWeight: FontWeight.bold),
                      Container(
                          height: 230,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Customer Name
                                singleRowCustomerVehicleDetail(
                                    "Customer Name", singleProfile.name ?? ""),
                                singleRowCustomerVehicleDetail(
                                    "Address", singleProfile.address ?? ""),
                                singleRowCustomerVehicleDetail("Mobile Number",
                                    singleProfile.mobileNumber ?? ""),
                                singleRowCustomerVehicleDetail("Caller Name",
                                    singleProfile.callerName ?? ""),
                                singleRowCustomerVehicleDetail("Caller Number",
                                    singleProfile.callerNumber ?? ""),
                                singleRowCustomerVehicleDetail(
                                    "SR Number", singleProfile.srNumber ?? ""),
                                singleRowCustomerVehicleDetail("Received On",
                                    singleProfile.recivedOn ?? ""),
                              ])),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customtext(
                          title: "VEHICLE DETAILS",
                          fontWeight: FontWeight.bold),
                      Container(
                          height: 230,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                singleRowCustomerVehicleDetail(
                                    "Reg No", singleProfile.regNo ?? ""),
                                singleRowCustomerVehicleDetail(
                                    "Vin", singleProfile.vin ?? ""),
                                singleRowCustomerVehicleDetail(
                                    "Model", singleProfile.model ?? ""),
                                singleRowCustomerVehicleDetail("1st Range Date",
                                    singleProfile.firstRangeDate ?? ""),
                                singleRowCustomerVehicleDetail(
                                    "Mileage", singleProfile.milage ?? ""),
                                singleRowCustomerVehicleDetail(
                                    "Drop", singleProfile.drop ?? ""),
                                singleRowCustomerVehicleDetail("Last Service",
                                    singleProfile.lastService ?? ""),
                                singleRowCustomerVehicleDetail(
                                    "Last Service Mileage",
                                    singleProfile.lastServiceMilage ?? "")
                              ])),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  pw.Widget customerAndVehiclePDFDetails() {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pdfSectionHeading(title: "Customer Details"),
                  pw.SizedBox(height: 3),
                  pw.Container(
                      height: 150,
                      decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: PdfColors.black, width: 1)),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            //Customer Name
                            singleRowCustomerVehiclePDFDetail(
                                "Customer Name", singleProfile.name ?? ""),
                            singleRowCustomerVehiclePDFDetail(
                                "Address", singleProfile.address ?? ""),
                            singleRowCustomerVehiclePDFDetail("Mobile Number",
                                singleProfile.mobileNumber ?? ""),
                            singleRowCustomerVehiclePDFDetail(
                                "Caller Name", singleProfile.callerName ?? ""),
                            singleRowCustomerVehiclePDFDetail("Caller Number",
                                singleProfile.callerNumber ?? ""),
                            singleRowCustomerVehiclePDFDetail(
                                "SR Number", singleProfile.srNumber ?? ""),
                            singleRowCustomerVehiclePDFDetail(
                                "Received On", singleProfile.recivedOn ?? ""),
                          ])),
                ],
              ),
            ),
            pw.SizedBox(
              width: 10,
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pdfSectionHeading(title: "Vehicle Details"),
                  pw.Container(
                      height: 150,
                      decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: PdfColors.black, width: 1)),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            singleRowCustomerVehiclePDFDetail(
                                "Reg No", singleProfile.regNo ?? ""),
                            singleRowCustomerVehiclePDFDetail(
                                "Vin", singleProfile.vin ?? ""),
                            singleRowCustomerVehiclePDFDetail(
                                "Model", singleProfile.model ?? ""),
                            singleRowCustomerVehiclePDFDetail("1st Range Date",
                                singleProfile.firstRangeDate ?? ""),
                            singleRowCustomerVehiclePDFDetail(
                                "Mileage", singleProfile.milage ?? ""),
                            singleRowCustomerVehiclePDFDetail(
                                "Drop", singleProfile.drop ?? ""),
                            singleRowCustomerVehiclePDFDetail("Last Service",
                                singleProfile.lastService ?? ""),
                            singleRowCustomerVehiclePDFDetail(
                                "Last Service Mileage",
                                singleProfile.lastServiceMilage ?? "")
                          ])),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  // Single row designed for customer and vehicle details.
  Widget singleRowCustomerVehicleDetail(String name, String value) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: (screenWidth - 40) * 0.12,
              child: Container(
                  child: customtext(title: name, fontSize: fontSize - 3)),
            ),
            SizedBox(
                width: 10,
                child:
                    customtext(title: ":", fontSize: fontSize - 3) //Text(":"),
                ),
            Expanded(
                child: Container(
                    child: customtext(
                        title: value, fontSize: fontSize - 3, maxLines: 3))),
          ],
        ));
  }

  pw.Widget singleRowCustomerVehiclePDFDetail(String name, String value) {
    return pw.Padding(
        padding: const pw.EdgeInsets.all(3),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(
              width: (screenWidth - 40) * 0.11,
              child: pw.Container(
                  child: pw.Text(name,
                      style: pw.TextStyle(fontSize: contentFontSize))),
            ),
            pw.SizedBox(
                width: 10,
                child: pw.Text(":",
                    style: pw.TextStyle(fontSize: contentFontSize)) //Text(":"),
                ),
            pw.Expanded(
                child: pw.Container(
                    child: pw.Text(value,
                        style: pw.TextStyle(fontSize: contentFontSize),
                        maxLines: 3))),
          ],
        ));
  }

  // Service Center name and address for heading of pdf view
  Widget headingData() {
    return Column(
      children: [
        customtext(
            title: "Silver Arrow - Workshop Delhi 52 Sohna Road",
            fontSize: fontSize + 2,
            fontWeight: FontWeight.bold),
        const SizedBox(
          height: 5,
        ),
        customtext(
            title: "52B Rama Road, New Delhi DL. Ph no: 01148200500",
            fontSize: fontSize - 2),
        const SizedBox(height: 25),
      ],
    );
  }

  // Outside Inventory Details
  Widget outsideInventoriesDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customtext(title: "OUTSIDE INVENTORIES", fontWeight: FontWeight.bold),
          Container(
            height:
                calculateGridViewHeight(2, 2, screenWidth - contentPadding, 4) +
                    4,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2)),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: getImageProviderFromImageArray().length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: Image.asset("assets/images/car.png"),
                  );
                }),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  pw.Widget outsideInventoryPDFDetails() {
    return pw.Container(
        child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pdfSectionHeading(title: "Outside Inventory"),
        pw.SizedBox(height: 3),
        pw.Container(
            decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 2)),
            child: pw.Column(children: [
              pw.SizedBox(
                height: 380,
                child: pw.GridView(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2,
                  mainAxisSpacing: 0,
                  children: List<pw.Widget>.generate(4, (index) {
                    return pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Container(
                            child: pw.Center(
                                child: pw.Image(imageProviders[
                                    index])))); // Create a widget for each item
                  }),
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                insideInventoryPDFIcon(
                    withTitle: "Damage", icon: static_image["damage"]!),
                insideInventoryPDFIcon(
                    withTitle: "Scratch", icon: static_image["scratch"]!),
                insideInventoryPDFIcon(
                    withTitle: "Dent", icon: static_image["dent"]!),
                insideInventoryPDFIcon(
                    withTitle: "Missing", icon: static_image["missing"]!),
                insideInventoryPDFIcon(
                    withTitle: "Corrosion", icon: static_image["corrosion"]!),
              ]),
              pw.SizedBox(height: 5),
            ])),
        pw.SizedBox(height: 15),
      ],
    ));
  }

  pw.Widget insideInventoryPDFIcon(
      {required String withTitle, required pw.ImageProvider icon}) {
    return pw.Row(children: [
      pw.SizedBox(width: 10),
      pw.Image(height: 10, width: 10, icon),
      pw.SizedBox(width: 4),
      pw.Text(withTitle, style: pw.TextStyle(fontSize: contentFontSize)),
      pw.SizedBox(width: 10)
    ]);
  }

  // Inside Inventory Details
  Widget insideInventoryDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customtext(title: "Inside Inventory", fontWeight: FontWeight.bold),
          SizedBox(
            height: 280,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (insideInventories.length / 4).ceil(),
              itemBuilder: (BuildContext context, int index) {
                final startIndex = index * 4;
                final endIndex = (startIndex + 4) >= insideInventories.length
                    ? insideInventories.length
                    : startIndex + 4;
                final rowItems =
                    insideInventories.sublist(startIndex, endIndex);

                if (endIndex == insideInventories.length - 1) {
                  // Create a separate row for second-to-last and last elements
                  return SizedBox(
                    width: screenWidth,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 42,
                                width: (screenWidth - contentPadding * 2) / 4,
                                child: _buildTableCell(rowItems[0])),
                            SizedBox(
                                height: 42,
                                width: (screenWidth - contentPadding * 2) / 4,
                                child: _buildTableCell(rowItems[1])),
                            Expanded(child: _buildTableCell(rowItems[2])),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: _buildTableCell(rowItems[3])),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  // Create a regular row for other elements
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      children: rowItems.map((item) {
                        return Expanded(
                            child: Container(child: _buildTableCell(item)));
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  pw.Widget insideInventoryPDFDetails() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pdfSectionHeading(title: "Inside  Inventory"),
        pw.SizedBox(height: 3),
        pw.Container(
          child: pw.ListView.builder(
            itemCount: (insideInventories.length / 4).ceil(),
            itemBuilder: (context, int index) {
              final startIndex = index * 4;
              final endIndex = (startIndex + 4) >= insideInventories.length
                  ? insideInventories.length
                  : startIndex + 4;
              final rowItems = insideInventories.sublist(startIndex, endIndex);

              if (endIndex == insideInventories.length - 1) {
                // Create a separate row for second-to-last and last elements
                return pw.Container(
                  width: MediaQuery.of(builderContext).size.width,
                  child: pw.Column(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Container(
                              width: 128.5,
                              child: _buildPdfTableCell(rowItems[0])),
                          pw.Container(
                              width: 129.5,
                              child: _buildPdfTableCell(rowItems[1])),
                          pw.Expanded(child: _buildPdfTableCell(rowItems[2])),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Container(
                              child: pw.Expanded(
                                  child: _buildPdfTableCell(rowItems[3]))),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                // Create a regular row for other elements
                return pw.Row(
                  children: rowItems.map((item) {
                    return pw.Expanded(
                        child: pw.Container(child: _buildPdfTableCell(item)));
                  }).toList(),
                );
              }
            },
          ),
        ),
        pw.SizedBox(height: 15)
      ],
    );
  }

  // Engine Compartment Details
  Widget engineCompartmentDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          customtext(title: "ENGINE COMPARTMENT", fontWeight: FontWeight.bold),
          // ENGINE COMPARTMENT
          Table(
            border: TableBorder.all(width: 2),
            columnWidths: const {
              0: FractionColumnWidth(0.03),
              1: FractionColumnWidth(0.25),
              2: FractionColumnWidth(0.06),
              3: FractionColumnWidth(0.45),
            },
            children: [
              _buildRows(["Sl No", "Criteria", "State", "Remarks"],
                  isHeader: true),
              for (var config in engineCompartment)
                _buildRows([
                  config.field_one ?? "",
                  config.field_two ?? "",
                  config.field_three ?? "",
                  config.field_four ?? "",
                ]),

              // _buildRows(["Sl No", "Criteria", "State", "Remarks"],
              //     isHeader: true),
              // _buildRows(["1", "Fluid Level and Quantity", "", ""]),
              // _buildRows(["2", "Hose connections and leakages", "", ""]),
              // _buildRows(["3", "V-Belt Condition", "", ""]),
              // _buildRows(["4", "Battery Condition", "", ""])
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  pw.Widget pdfTableWith(
      {required String title,
      required List<GenericConfigs> source,
      bool isAdvisorDetails = false}) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pdfSectionHeading(title: title),
          pw.SizedBox(height: 3),
          (isAdvisorDetails)
              ? singleTableFourCols(
                  source: source,
                  "Service Advisor Name",
                  "SA Contact No.",
                  "Service Advisor Email",
                  "Expected delivery date and time")
              : singleTableFourCols(
                  source: source, "Sl No", "Criteria", "State", "Remarks"),
          pw.SizedBox(height: 15),
        ]);
  }

  // Inside Cabin Details
  Widget insideCabinDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          customtext(title: "INSIDE CABIN", fontWeight: FontWeight.bold),
          Table(
            border: TableBorder.all(width: 2),
            columnWidths: const {
              0: FractionColumnWidth(0.03),
              1: FractionColumnWidth(0.25),
              2: FractionColumnWidth(0.06),
              3: FractionColumnWidth(0.45),
            },
            children: [
              _buildRows(["Sl No", "Criteria", "State", "Remarks"],
                  isHeader: true),
              for (var config in insideCabinList)
                _buildRows([
                  config.field_one ?? "",
                  config.field_two ?? "",
                  config.field_three ?? "",
                  config.field_four ?? "",
                ]),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  // Under Body Detils
  Widget underBodyDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          customtext(title: "UNDER BODY", fontWeight: FontWeight.bold),
          Table(
            border: TableBorder.all(width: 2),
            columnWidths: {
              0: FractionColumnWidth(0.03),
              1: FractionColumnWidth(0.25),
              2: FractionColumnWidth(0.06),
              3: FractionColumnWidth(0.45),
            },
            children: [
              _buildRows(["Sl No", "Criteria", "State", "Remarks"],
                  isHeader: true),
              for (var config in underBodyList)
                _buildRows([
                  config.field_one ?? "",
                  config.field_two ?? "",
                  config.field_three ?? "",
                  config.field_four ?? "",
                ]),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  // Remarks
  Widget remarksDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Remarks
          customtext(title: "REMARKS", fontWeight: FontWeight.bold),
          Table(
            border: TableBorder.all(width: 2),
            columnWidths: {
              0: FractionColumnWidth(0.05),
              1: FractionColumnWidth(0.885),
            },
            children: [
              _buildRows(["Remarks", ""], isHeader: false),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  pw.Widget remarksPDFDetails() {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pdfSectionHeading(title: "Remarks"),
          pw.SizedBox(height: 3),
          // REMARKS
          pw.Table(
            border: pw.TableBorder.all(width: 1),
            columnWidths: {
              0: pw.FractionColumnWidth(0.1),
              1: pw.FractionColumnWidth(0.75),
            },
            children: [
              _buildPdfRows(["Remarks", ""]),
            ],
          ),
          pw.SizedBox(height: 15),
        ]);
  }

  // Customer Concern Details
  Widget customerConcernDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // CUSTOMER CONCERNS
          customtext(title: "Customer Concerns", fontWeight: FontWeight.bold),
          Table(
            border: TableBorder.all(width: 2),
            columnWidths: const {
              0: FractionColumnWidth(0.08),
              1: FractionColumnWidth(0.3),
              2: FractionColumnWidth(0.61),
            },
            children: [
              _buildRows(["Sl No", "Concern", "Remarks"], isHeader: true),
              for (var config in customerConcernList)
                _buildRows([
                  config.field_one ?? "",
                  config.field_two ?? "",
                  config.field_three ?? "",
                ]),
            ],
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }

  pw.Widget customerConcernPDFDetails() {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pdfSectionHeading(title: "Customer Concerns"),
          pw.SizedBox(height: 3),
          // Customer Concerns
          pw.Table(
            border: pw.TableBorder.all(width: 1),
            columnWidths: {
              0: pw.FractionColumnWidth(0.08),
              1: pw.FractionColumnWidth(0.3),
              2: pw.FractionColumnWidth(0.3),
              3: pw.FractionColumnWidth(0),
            },
            children: [
              _buildPdfRows(["Sl No", "Concern", "Remarks", ""],
                  isHeader: true),
              for (var concern in customerConcernList)
                _buildPdfRows([
                  concern.field_one ?? "",
                  concern.field_two ?? "",
                  concern.field_three ?? "",
                  "",
                ]),
            ],
          ),
          pw.SizedBox(height: 15),
        ]);
  }

  // Service Advisor details
  Widget serviceAdvisorDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customtext(
              title: "SERVICE ADVISOR DETAILS", fontWeight: FontWeight.bold),
          Table(
            border: TableBorder.all(width: 2),
            columnWidths: {
              0: FractionColumnWidth(0.1),
              0: FractionColumnWidth(0.1),
              0: FractionColumnWidth(0.1),
              0: FractionColumnWidth(0.25),
            },
            children: [
              _buildRows([
                "Service Advisor Name",
                "SA Contact No.",
                "Service Advisor Email",
                "Expected delivery date and time"
              ], isHeader: true),
              for (var config in serviceAdviceDetails)
                _buildRows([
                  config.field_one.toString(),
                  config.field_two.toString(),
                  config.field_three.toString(),
                  config.field_four.toString()
                ]),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Terms and conditions
  Widget termsAndConditions() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customtext(
              title: "TERMS AND CONDITIONS", fontWeight: FontWeight.bold),
          const SizedBox(height: 5),
          Container(
            child: customtext(
                fontSize: fontSize - 6,
                maxLines: 100000000,
                title:
                    "1. We am solely responsible for the test drives done outside the premises o fdealershio\n2. I/We indemnifyand keept h e Authorized Dealer indemnified againstany costs. risk.liabilitv. responsibility for loss o rdamaget o the vehicle and/ or life or property of al persons arising o u tof test driving of the vehicle by me/us or my/our Authorized Representative. I/We confirmthat I/we have obtained the requisite insurance for the vehicle together with the accessories, components, articlesand/or things containedtherein and theDealer shall i nn owav be liable for any loss. damage or iniury caused to m e/us.\n3. W e will not hold the Dealer responsible/liable for a n delav ni delivery or ni c a r i n g out renairs or procurement of sparenarts for reasons bevond its control\n4. W e undertake to take deliverv of thevehicle within 48 hoursof intimation of completiono frepair or maintenance services. In the event of delavon mw/our part. I/Weagree to dav the storage charges (Rs1000/-IRuDees One Thousand only) per day.\n5. We are agree to pay to Rs 10000/- (Rupees Ten Thousand only or 5% of the total estimated amount.\n6. I/We undertake to make cavment of all charges before takine deliverv of the vehicleand in the event.the delivery si taken without settlement of the bill. I/We undertake to settlethe billwithin 7davs of taking delivery ofthe vehicle. In the event, the bill is not settled within a period of 7 days,the Authorized Dealer may lew an interest @ 41 %p.a. on the outstanding bill amountfrom the date on whichthe vehicle was ready for delivery until payment.\n7. / eacree thatt h e Authorized Dealerm a vexerciselieno n thevehicle until all the above mentioned dies are settled to its satisfaction\n8. I/Weagree that I will a v anv advance amount asreguired by the Authorized Dealer based on the estimated cost before commencement ofthe repairs/maintenance services\n9. / W ehereby authorize the AuthorizedDealer to deliver t h evehicle to m y/our Authorized Representative\n1O. We agree that any disoutes arisingfrom or o u tof this work order shall be settled mutually. ni case, mutuallyacceotable settlement si not arrived at. such disoute shall be sublect to exclusive junsciction of t h ecourt where t h eAuthorized dealer's Registered Office is located\n11. We agrap and understand that t h eWarranty terms and Conditions areconcurrent tothese Termsa n dConditions\n12. I/We hereby grant free consent to the Authorized Dealer, Mercedes-Benz IndiaPrivate Limited and/or their authorized third parties to contactme/us through SMS, call, email, WhatsApp or anyother electronic, telecommunication or physical medium,from time to time. to provide information me/us the status of repair work. estimated cost of repair work,details of repairs/replacement, vehicle location tracking, invoice and payment andfor to obtain mu four feedbackinrelationtot h eservicesprovided b yt h eAuthorized Dealer\n13. I/We authorize the Authorized Dealer, Mercedes-Benz India PrivateLimitedand/or their authorizedthird partiesot send lal or any communication no information no the status fo repair work,estimated cost of repair work, detailso frepairs/replacement. vehicle location trackine. invoiceand oavment to m y/our Authorized Representative\n14. W e hereby authorize theAuthorized Dealer to track the location o fm yo u rvehicle during the pick up from and drop t othe designated place\n15. I/Weagree and understand that the communicationthrough WhatsApp, SMS, email or anyotherelectronicor telecommunication medium will allow me /us toaccess various information pertaining to services availed any third party\n16. I/We herebv declare that I/wea m fullv awarethat communication throughWhatsAoD. SMS.emailor any other electronic or telecommunicationmedium mav not be secure and the Authorized Dealer shall inn o war be responsible for a n personal data privacy infringements caused by a n vact ro omission of anv other third p a r t ywhich m a v be involved ni making t h ecommunication media services available to me / us and to the Dealer. r a m affixing my signature below in evidence of agreeing to the above t e r m sa n dconditions absolutely and unconditionally"),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  // Checkbox for Payment Type and Terms & Conditions Acceptance CheckBox
  Widget selectPaymentOption() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customtext(
              title:
                  "I am affixing my signature below in evidence of agreeing to the above terms and conditions absolutely and unconditionally.",
              fontSize: 15),
          SizedBox(
            height: 40,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: paymentModes.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(
                        paymentModes[index].paymentMode.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Checkbox(
                          value: paymentModes[index].isSelcted,
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          onChanged: (currentValue) {
                            setState(() {
                              if (currentValue == true) {
                                // Deselect all checkboxes except the current one
                                for (int i = 0; i < paymentModes.length; i++) {
                                  if (i != index) {
                                    paymentModes[i].isSelcted = false;
                                  }
                                }
                              }
                              paymentModes[index].isSelcted =
                                  currentValue ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                      //const SizedBox(width: 10,)
                    ],
                  );
                }),
          ),
          const SizedBox(height: 10),

          // Terms & Conditions Acceptance CheckBox
          Row(
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.all<Color>(Colors.black),
                    value: isTermsConditionAccepted,
                    onChanged: (currentValue) {
                      setState(() {
                        isTermsConditionAccepted = currentValue ?? false;
                      });
                    }),
              ),
              Expanded(
                  child: Container(
                      child: Text(
                          "I hereby authorize the repairs as described to the executed using necessary material. I agree to bound by the Terms and Conditions.",
                          style: TextStyle(fontSize: 15)))),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget showPaymentOptionInPdf() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
            "I am affixing my signature below in evidence of agreeing to the above terms and conditions absolutely and unconditionally.",
            style: pw.TextStyle(fontSize: contentFontSize)),
        pw.SizedBox(
          height: 30,
          child: pw.ListView.builder(
              direction: pw.Axis.horizontal,
              itemCount: paymentModes.length,
              itemBuilder: (context, index) {
                return pw.Row(
                  children: [
                    titleWithCheckboxImage(
                        title: paymentModes[index].paymentMode.toString(),
                        isSelected: paymentModes[index].isSelcted ?? false),
                    pw.SizedBox(
                      width: 15,
                    )
                    //const SizedBox(width: 10,)
                  ],
                );
              }),
        ),
        pw.SizedBox(height: 5),
        // Terms & Conditions Acceptance CheckBox
        checkboxImageWithTitle(
            title:
                "I hereby authorize the repairs as described to the executed using necessary material. I agree to bound by the Terms and Conditions.",
            isSelected: isTermsConditionAccepted)
      ],
    );
  }

  Widget signatureView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 170,
          height: 160,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  child: Container(
                    color: widget.imageData != null
                        ? Colors.white
                        : Colors.grey.withOpacity(0.4),
                    height: 100,
                    width: 150,
                    child: widget.imageData != null
                        ? Image(
                            image: MemoryImage(widget.imageData!),
                            fit: BoxFit.fill,
                            width: 200, // Set the desired width of the image
                            height: 200, // Set the desired height of the image
                          )
                        : const SizedBox(),
                  ),
                  onTap: () {
                    showPopup(context);
                  },
                ),
                const Divider(
                  color: Colors.black,
                  height: 2,
                ),
                const Text("Customer's Signature")
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget signaturePDFView() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.SizedBox(
          child: pw.Padding(
            padding: const pw.EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                    color: (widget.imageData != null)
                        ? PdfColors.white
                        : PdfColors.grey100,
                    height: 100,
                    width: 150,
                    child: pw.Image(
                        uint8listToImage(widget.imageData ?? Uint8List(0)),
                        fit: pw.BoxFit.fill)),
                // pw.Divider(
                //   color: PdfColors.black,
                //   height: 1,
                //
                // ),

                pw.SizedBox(height: 1),
                pw.Text("Customer's Signature",
                    style: pw.TextStyle(fontSize: contentFontSize))
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Popup for adding signature
  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SignatureView(
          onButtonClicked: onPopupButtonClicked,
        );
      },
    );
  }

  // Action performed after adding signature
  void onPopupButtonClicked(Uint8List result) {
    if (result != null) {
      widget.generatePDFFromCallBack(result);
      setState(() {
        widget.imageData = result;
      });
    }
  }

  // Widget to show the health card.
  Widget healthCardDetails() {
    return SizedBox(
      width: (screenWidth - 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            "Health Card",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          buildHealthCardContent(),
        ],
      ),
    );
  }

  Widget buildHealthCardContent() {
    return Column(
      children: [
        ///First 3 objects
        SizedBox(
          height: 780,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: healthCardData.healthMeter.length,
              itemBuilder: (context, index) {
                return HealthIndicatorTemplate(
                  isSelected: false,
                  title: healthCardData.healthMeter[index].title,
                  regularBoxContent: healthCardData.healthMeter[index].specs,
                  onGoodValueChanged: (newValue) {
                    setState(() {
                      //healthCardData.batteryCondition.isGood = true;
                    });
                  },
                  onReplaceValueChanged: (newValue) {
                    setState(() {});
                  },
                );
              }),
        ),

        ///4th and 5th object
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: (screenWidth - 40) * 0.2,
              child: Column(
                children: [
                  _verticalRectangle(170, 'Battery\n(Report to be attached)'),
                  _verticalRectangle(
                      60, 'Vehicle Electronics\n(Report to be attached)'),
                ],
              ),
            ),
            SizedBox(
              width: (screenWidth - 40) * 0.4,
              child: Column(children: [
                _regularContainer(40, textChild('Voltage', 'volts')),
                _regularContainer(
                    130,
                    Column(
                      children: [
                        checkboxWithTitle(
                          isSelected:
                              healthCardData.batteryCondition.hasGoodCondition,
                          title: 'Good Condition Replacement (in yrs)',
                          onValueChanged: (newValue) {
                            setState(() {
                              healthCardData.batteryCondition.hasGoodCondition =
                                  newValue;
                              healthCardData.batteryCondition.changeBattery =
                                  false;
                            });
                          },
                        ),
                        checkboxWithTitle(
                          isSelected:
                              healthCardData.batteryCondition.changeBattery,
                          title: 'Change Battery',
                          onValueChanged: (newValue) {
                            setState(() {
                              healthCardData.batteryCondition.changeBattery =
                                  newValue!;
                              healthCardData.batteryCondition.hasGoodCondition =
                                  false;
                            });
                          },
                        )
                      ],
                    )),
                _regularContainer(
                  60,
                  checkboxWithTitle(
                    isSelected: healthCardData.isNoFaults,
                    title: 'No Fault',
                    onValueChanged: (newValue) {
                      setState(() {
                        healthCardData.isNoFaults = newValue ?? false;
                      });
                    },
                  ),
                ),
              ]),
            ),
            SizedBox(
              width: (screenWidth - 40) * 0.4,
              child: Column(children: [
                _regularContainer(40, textChild('', '')),
                _regularContainer(
                    130,
                    Column(
                      children: [
                        checkboxWithTitle(
                            isSelected: healthCardData.genuineData.isGenuine,
                            title: 'Genuine',
                            onValueChanged: (newValue) {
                              setState(() {
                                healthCardData.genuineData.isGenuine =
                                    newValue ?? false;
                                healthCardData.genuineData.isNonGenuine = false;
                              });
                            }),
                        checkboxWithTitle(
                            isSelected: healthCardData.genuineData.isNonGenuine,
                            title: 'Non-Genuine',
                            onValueChanged: (newValue) {
                              setState(() {
                                healthCardData.genuineData.isNonGenuine =
                                    newValue ?? false;
                                healthCardData.genuineData.isGenuine = false;
                              });
                            })
                      ],
                    )),
                _regularContainer(
                  60,
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0),
                    //EdgeInsets.fromLTRB(left: 8.0, top: 8, right: 8, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Please specify if any remarks: ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Container(
                            height: 36,
                            child: TextField(
                              style: TextStyle(fontSize: 12),
                              maxLines: 1,
                              decoration: InputDecoration(
                                  hintText: "Tap here to add Remarks"),
                            )),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),

        ///Remaining 5 objects
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _verticalRectangle(80,
                    'Personalized advice to customer on Vehicle performance and usage'),
                _verticalRectangle(40, 'Next maintenance interval'),
                _verticalRectangle(100, 'Next service check points'),
              ],
            ),
            Column(
              children: [
                _horizontalRectangle(80, Container()),
                _horizontalRectangle(
                    40,
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        customtext(title: 'KM', fontWeight: FontWeight.bold),
                        const SizedBox(
                          width: 120,
                        ),
                        customtext(title: 'Date', fontWeight: FontWeight.bold),
                        const SizedBox(
                          width: 120,
                        ),
                        customtext(title: '(Whichever comes early)')
                      ],
                    )),
                _horizontalRectangle(100, _lastContent()),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  pw.Widget healthCardPDFDetails(pw.Column grid) {
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pdfSectionHeading(title: "Health Card"),
          pw.SizedBox(height: 3),
          pw.Container(
              //width: MediaQuery.of(builderContext).size.width - 40,
              child: pw.ListView.builder(
                  itemCount: healthCardData.healthMeter.length,
                  itemBuilder: (context, index) {
                    List<SubModel> subModel =
                        healthCardData.healthMeter[index].specs;
                    return pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black),
                        ),
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.Container(
                                  width: 149,
                                  child: pw.Center(
                                    child: pw.Text(
                                        healthCardData.healthMeter[index].title,
                                        style: pw.TextStyle(
                                            fontSize: 8,
                                            fontWeight: pw.FontWeight.bold)),
                                  )),
                              pw.Container(
                                  child: pw.Row(children: [
                                pw.Container(
                                    width: (MediaQuery.of(builderContext)
                                                .size
                                                .width -
                                            40) *
                                        0.186,
                                    child: pw.ListView.builder(
                                        itemBuilder: (context, index) {
                                          return pw.Container(
                                              decoration: pw.BoxDecoration(
                                                border: pw.Border.all(),
                                              ),
                                              child: pw.SizedBox(
                                                  height: 30,
                                                  child: pw.Padding(
                                                      padding: const pw
                                                          .EdgeInsets.all(4),
                                                      child: pw.Row(children: [
                                                        pw.Text(
                                                            subModel[index]
                                                                .specItemName,
                                                            style: const pw
                                                                    .TextStyle(
                                                                fontSize: 8)),
                                                        pw.Spacer(),
                                                        pw.Text(
                                                            "${subModel[index].specItemValue}   mm",
                                                            style: pw.TextStyle(
                                                                fontSize:
                                                                    contentFontSize))
                                                      ]))));
                                        },
                                        itemCount: subModel.length)),
                                pw.Container(
                                    width: (MediaQuery.of(builderContext)
                                                .size
                                                .width -
                                            40) *
                                        0.186,
                                    child: pw.ListView.builder(
                                        itemBuilder: (context, index) {
                                          // List<SubModel> subModel =
                                          //     models[index].specs;
                                          List<pw.Image> listOfImages = [];
                                          // pw.Image image = getImageForSpecItemValue(subModel);
                                          // for (int i = 0; i <  models[index].specs.length; i++) {
                                          //   pw.Image image = getImageForSpecItemValue(subModel[i].specItemValue);
                                          //   listOfImages.add(image);
                                          // }

                                          return pw.Container(
                                              decoration: pw.BoxDecoration(
                                                border: pw.Border.all(),
                                              ),
                                              child: pw.SizedBox(
                                                  height: 30,
                                                  child: pw.Padding(
                                                      padding: const pw
                                                          .EdgeInsets.all(4),
                                                      child: pw.Row(
                                                          mainAxisAlignment: pw
                                                              .MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: [
                                                            checkboxImageWithTitle(
                                                                title:
                                                                    "Replace",
                                                                isSelected: subModel[
                                                                        index]
                                                                    .isReplaceable),
                                                            pw.Padding(
                                                                padding: const pw
                                                                        .EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 10),
                                                                child: pw.SizedBox(
                                                                    width: 50,
                                                                    child: getTriangleImage(
                                                                        subModel[index]
                                                                            .specItemValue))),
                                                            titleWithCheckboxImage(
                                                                title: "Good",
                                                                isSelected:
                                                                    subModel[
                                                                            index]
                                                                        .isGood),
                                                          ]))));
                                        },
                                        itemCount: subModel.length))
                              ])),
                            ]));
                  })),
          pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Row(children: [
                pw.Container(
                    width: 149,
                    padding: const pw.EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 10),
                    child: pw.Text("Battery \n (Report to be attached)",
                        style: const pw.TextStyle(fontSize: 8))),
                pw.Container(
                    width:
                        (MediaQuery.of(builderContext).size.width - 40) * 0.186,
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    // padding : const pw.EdgeInsets.only(left:10, right: 10, bottom: 10, top: 10),
                    child: pw.Container(
                        child: pw.Column(children: [
                      pw.Container(
                          width:
                              (MediaQuery.of(builderContext).size.width - 40) *
                                  0.186,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Row(children: [
                            pw.Text("Voltage",
                                style: const pw.TextStyle(fontSize: 8)),
                            pw.Spacer(),
                            pw.Text("7 volts",
                                style: const pw.TextStyle(fontSize: 8))
                          ])),
                      pw.SizedBox(height: 5),
                      pw.Container(
                          padding: const pw.EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: pw.Column(children: [
                            checkboxImageWithTitle(
                                title: "Good Condition Replacement(in yrs)",
                                isSelected: healthCardData
                                    .batteryCondition.hasGoodCondition),
                            pw.SizedBox(width: 5),
                            checkboxImageWithTitle(
                                title: "Change Battery",
                                isSelected: healthCardData
                                    .batteryCondition.changeBattery),
                          ]))
                    ]))),
                pw.Container(
                    width:
                        (MediaQuery.of(builderContext).size.width - 40) * 0.186,
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    // padding : const pw.EdgeInsets.only(left:10, right: 10, bottom: 10, top: 10),
                    child: pw.Container(
                        child: pw.Column(children: [
                      pw.Container(
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Row(children: [
                            pw.Text("dfdfdf",
                                style: const pw.TextStyle(
                                    fontSize: 8, color: PdfColors.white)),
                            pw.Spacer(),
                            pw.Text("dffdf",
                                style: const pw.TextStyle(
                                    fontSize: 8, color: PdfColors.white))
                          ])),
                      pw.SizedBox(height: 5),
                      pw.Container(
                          padding: const pw.EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: pw.Column(children: [
                            checkboxImageWithTitle(
                                title: "Genuine",
                                isSelected:
                                    healthCardData.genuineData.isGenuine),
                            pw.SizedBox(width: 5),
                            checkboxImageWithTitle(
                                title: "Not Genuine",
                                isSelected:
                                    healthCardData.genuineData.isNonGenuine),
                          ]))
                    ])))
              ])),
          pw.Container(
              //width: MediaQuery.of(builderContext).size.width - 40,
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Row(children: [
                pw.Container(
                    width: 149,
                    padding: const pw.EdgeInsets.fromLTRB(10, 16.5, 10, 16.5),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Text(
                        "Vehicle electronics\n(Report to be attached)",
                        style: const pw.TextStyle(fontSize: 8))),
                pw.Container(
                    padding: const pw.EdgeInsets.fromLTRB(10, 20, 10, 20),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    width:
                        (MediaQuery.of(builderContext).size.width - 40) * 0.186,
                    child: checkboxImageWithTitle(
                        title: "No Fault",
                        isSelected: healthCardData.isNoFaults)),
                pw.Container(
                    padding: const pw.EdgeInsets.fromLTRB(10, 5, 10, 5),
                    width:
                        (MediaQuery.of(builderContext).size.width - 40) * 0.186,
                    child: pw.Text(
                        maxLines: 3,
                        "Remarks(if any): ${healthCardData.remarks}",
                        style: const pw.TextStyle(fontSize: 8))),
              ])),
          pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Row(children: [
                pw.Container(
                    width: 149,
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Text(
                        "Personalized advice to \n customer on vehicle \n performance and usage",
                        style: const pw.TextStyle(fontSize: 8))),

                //TODO: PUT TEXT
              ])),
          pw.Container(
              //width: MediaQuery.of(builderContext).size.width - 40,
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Row(children: [
                pw.Container(
                    width: 149,
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Text("Next maintenance interval",
                        style: const pw.TextStyle(fontSize: 8))),
                pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    width:
                        (MediaQuery.of(builderContext).size.width - 40) - 186,
                    child: pw.Row(children: [
                      pw.Row(children: [
                        pw.Text("KM", style: const pw.TextStyle(fontSize: 8)),
                        pw.SizedBox(width: 3),
                        pw.Text(
                            healthCardData
                                .nextMaintenanceInterval.futureKilometers,
                            style: const pw.TextStyle(fontSize: 8))
                      ]),
                      pw.SizedBox(width: 50),
                      pw.Row(children: [
                        pw.Text("Date", style: const pw.TextStyle(fontSize: 8)),
                        pw.SizedBox(width: 30),
                        pw.Text(
                            healthCardData.nextMaintenanceInterval.nextDueDate,
                            style: const pw.TextStyle(fontSize: 8))
                      ]),
                      pw.SizedBox(width: 50),
                      pw.Text("(Whichever comes early)",
                          style: const pw.TextStyle(fontSize: 8))
                    ]))
              ])),
          pw.Container(
              //width: MediaQuery.of(builderContext).size.width - 40,
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Row(children: [
                pw.Container(
                    width: 149,
                    // decoration: pw.BoxDecoration(border: pw.Border.all()),
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Text("Next service check point",
                        style: const pw.TextStyle(fontSize: 8))),
                pw.Container(
                    height: 60,
                    alignment: pw.Alignment.topLeft,
                    decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: PdfColors.black, width: 1)),
                    padding: const pw.EdgeInsets.all(10),
                    width:
                        (MediaQuery.of(builderContext).size.width - 40) * 0.372,
                    child: _lastPDFContent())
              ])),
          pw.SizedBox(height: 15),
        ]);
  }

  pw.Image getTriangleImage(String specItemValue) {
    double value = double.parse(specItemValue);

    if (value >= 1 && value < 2) {
      return pw.Image(static_image["emptyTriangle"]!);
    } else if (value >= 2 && value < 4) {
      return pw.Image(static_image["halfTriangle"]!);
    } else if (value >= 4 && value <= 6) {
      return pw.Image(static_image["fullTriangle"]!);
    } else {
      return pw.Image(static_image["blankTriangle"]!);
    }
  }

  // Widget to show the condition of the tyre. Also, option to check if the part is in good condtion or to be replaced.
  pw.Widget condition(SubModel currentModel) {
    double size = double.parse(currentModel.specItemValue);
    return pw.SizedBox(
      height: 60,
      width: (screenWidth - 40) * 0.4,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          checkboxImageWithTitle(
              title: "Replace", isSelected: currentModel.isReplaceable),
          pw.Padding(
              padding: const pw.EdgeInsets.only(left: 20, right: 20),
              child: getTriangleImage(currentModel.specItemValue)),
          titleWithCheckboxImage(
              title: "Good", isSelected: currentModel.isGood),
        ],
      ),
    );
  }

  Widget checkboxWithTitle({
    required String title,
    double spacing = 5,
    required Function(bool) onValueChanged,
    required bool isSelected,
  }) {
    return Row(
      children: [
        Checkbox(
          value: isSelected,
          fillColor: MaterialStateProperty.all(Colors.black),
          onChanged: (bool? newValue) {
            onValueChanged(
                newValue ?? false); // Call the callback with the new value
          },
        ),
        (title.isEmpty) ? const SizedBox() : SizedBox(width: spacing),
        (title.isEmpty)
            ? const SizedBox()
            : Text(title, style: const TextStyle(fontSize: 15)),
      ],
    );
  }

  pw.Widget checkboxImageWithTitle(
      {required String title, double spacing = 5, required bool isSelected}) {
    return pw.Row(children: [
      pw.Image(
          height: 10,
          width: 10,
          static_image[(isSelected) ? "check_box" : "check_box_empty"]!),
      pw.SizedBox(width: 4),
      pw.Text(title, style: pw.TextStyle(fontSize: contentFontSize)),
    ]);
  }

  pw.Widget titleWithCheckboxImage(
      {required String title, double spacing = 5, required bool isSelected}) {
    return pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Row(children: [
          pw.Text(title, style: pw.TextStyle(fontSize: contentFontSize)),
          pw.SizedBox(width: 5),
          pw.Image(
              height: 10,
              width: 10,
              static_image[(isSelected) ? "check_box" : "check_box_empty"]!),
        ]));
  }

  // Widget used for Rear Wheel Right, Rear Wheel left etc., and its value
  pw.Widget _regularPDFContainer(double height, pw.Widget child) {
    return pw.Builder(builder: (buildContext) {
      return pw.Container(
        height: height,
        width: (screenWidth - 40) * 0.186,
        decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 1),
            color: PdfColors.white),
        child: child,
      );
    });
  }

  // Build Rows while adding pages in PDF
  pw.TableRow _buildPdfRows(List<String> cells, {bool isHeader = false}) =>
      pw.TableRow(
        decoration: pw.BoxDecoration(
          color: isHeader ? PdfColors.grey400 : PdfColors.white,
        ),
        children: cells.map((cell) {
          final style = pw.TextStyle(
              fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
              fontSize: contentFontSize);
          return pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Center(child: pw.Text(cell, style: style)));
        }).toList(),
      );

  // Build Table Cell for inside inventory
  pw.Widget _buildPdfTableCell(InsideInventory item) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 1),
      ),
      child: pw.Container(
        width: PdfPageFormat.a4.availableWidth + 33.5,
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: pw.Container(
                width: 78,
                child: pw.Text(item.type,
                    style: pw.TextStyle(fontSize: contentFontSize)),
              ),
            ),
            pw.Expanded(
              child: pw.Container(
                  width: 30,
                  height: 30,
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black)),
                  child: (item.value is bool)
                      ? (item.value == true)
                          ? pw.Center(
                              child: pw.Container(
                                  width: 10,
                                  height: 10,
                                  child: pw.Image(static_image["done"]!)))
                          : pw.Center()
                      : pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Text(
                            item.value.toString(),
                            style: pw.TextStyle(fontSize: contentFontSize),
                            textAlign: pw.TextAlign.center,
                          ))),
            )
          ],
        ),
      ),
    );
  }

  TableRow _buildRows(List<String> cells, {bool isHeader = false}) => TableRow(
        children: cells.map((cell) {
          final style = TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              fontSize: 14);
          return Container(
              height: (isHeader) ? 40 : 35,
              color: isHeader ? Colors.grey[300] : Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: isHeader
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(cell, style: style),
                        ))
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(cell, style: style),
                        )));
        }).toList(),
      );

  Widget _buildTableCell(InsideInventory item) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        left: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        top: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      )),
      child: SizedBox(
        width: (screenWidth - contentPadding) / 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: (screenWidth - 330) / 4,
                child: Text(item.type),
              ),
            ),
            Expanded(
              child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    left: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  )),
                  child: (item.value is bool)
                      ? (item.value == true)
                          ? const Icon(Icons.check)
                          : Icon(
                              Icons.check,
                              color: Colors.white.withAlpha(0),
                            )
                      : Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            item.value.toString(),
                            textAlign: TextAlign.center,
                          ))),
            )
          ],
        ),
      ),
    );
  }

  double calculateGridViewHeight(double aspectRatio, double crossAxisCount,
      double screenWidth, int itemCount) {
    final double itemWidth = screenWidth / crossAxisCount;
    final double itemHeight = itemWidth / aspectRatio;
    return (itemCount / crossAxisCount).ceil() * itemHeight;
  }

  Future<pw.MemoryImage> imageFromPath(String path) async {
    final ByteData imageByteData = await rootBundle.load(path);
    final Uint8List imageData = imageByteData.buffer.asUint8List();
    return pw.MemoryImage(imageData);
  }

  Widget _lastContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GridView.builder(
        itemCount: healthCardData.serviceCheckPointList.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 4 / 0.6,
        ),
        itemBuilder: (context, index) {
          ServiceCheckPoint serviceCheckPoint =
              healthCardData.serviceCheckPointList[index];
          return Center(
            child: checkboxWithTitle(
              isSelected: serviceCheckPoint.isSelected ?? false,
              title: serviceCheckPoint.checkPointName ?? "",
              onValueChanged: (newValue) {
                setState(() {
                  serviceCheckPoint.isSelected = newValue ?? false;
                });
              },
            ),
          );
        },
      ),
    );
  }

  pw.Widget _lastPDFContent() {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 5),
      child: pw.GridView(
        crossAxisCount: 4,
        childAspectRatio: 4 / 0.6,
        mainAxisSpacing: 0, // Number of columns in the grid
        children: List<pw.Widget>.generate(
            healthCardData.serviceCheckPointList.length, (index) {
          return pw.Center(
            child: checkboxImageWithTitle(
              isSelected:
                  healthCardData.serviceCheckPointList[index].isSelected ??
                      false,
              title:
                  healthCardData.serviceCheckPointList[index].checkPointName ??
                      "",
              spacing: 10,
            ),
          ); // Create a widget for each item
        }),
      ),
    );
  }

  Widget _verticalRectangle(double height, String text) {
    return Builder(builder: (context) {
      return Container(
        height: height,
        width: (screenWidth - 40) * 0.2,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.grey.shade300),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
      );
    });
  }

  Widget textChild(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        customtext(title: text1),
        customtext(title: text2),
      ],
    );
  }

  Widget _regularContainer(double height, Widget child) {
    return Builder(builder: (context) {
      return Container(
        height: height,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black), color: Colors.white),
        child: child,
      );
    });
  }

  Widget _horizontalRectangle(double height, Widget child) {
    return Builder(builder: (context) {
      return Container(
        height: height,
        width: (screenWidth - 40) * 0.8,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: child,
      );
    });
  }
}