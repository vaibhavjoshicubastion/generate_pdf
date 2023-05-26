import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_generate/Modal/InsideInventory.dart';
import 'package:printing/printing.dart';

import 'Modal/Model.dart';
import 'ModelTemplate.dart';
import 'PDFScreen.dart';
import 'SignatureView.dart';

import 'Modal/InsideInventory.dart';

class MyView extends StatefulWidget {
  Uint8List? imageData;

  bool isChecked = false;

  final Function(Uint8List) generatePDFFromCallBack;

  MyView(this.imageData, this.generatePDFFromCallBack);

  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> with RouteAware {
  void toggleCheckbox() {
    widget.isChecked = !widget.isChecked;
  }

  late final BuildContext builderContext;

  var contentPadding = 20.0;

  var fontSize = 20.0;

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
  bool fist = true;

  List<String> imageArray = [
    'assets/images/IMG_4641.PNG',
    'assets/images/IMG_4641.PNG',
    'assets/images/IMG_4642.PNG',
    'assets/images/IMG_4643.PNG',
    'assets/images/IMG_4644.PNG'
  ];

  bool isSelected = false;

  Map<String, pw.ImageProvider> static_image = {};

  @override
  void initState() {
    super.initState();

    getStaticImages();

    builderContext = context;
    imageProviders = getImageProviderFromImageArray();
    if (widget.imageData != null) {
      generatePDF();
    }
  }

  void getStaticImages() async {
    static_image = {
      "check_box_empty":
          await imageFromPath("assets/images/check_box_empty.png"),
      "check_box": await imageFromPath("assets/images/done.png"),
      "benz_logo": await imageFromPath("assets/images/benz_logo.png"),
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

    final rows = <pw.Widget>[];
    final rowItemCount = 2; // Number of items per row

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

      final row = pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: rowItems,
      );
      rows.add(row);
    }

    final images = getImageProviderFromImageArray();

    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(contentPadding * 2),
        // Add margin here
        pageFormat: PdfPageFormat.a4,
        header: (context) {
          // PDF Header
          return pw.Column(children: [
            pw.SizedBox(height: 20),

            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(children: [
                    pw.Image(height: 20, width: 20, static_image["benz_logo"]!),
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
        },
        footer: (context) {
          // PDF Footer
          return pw.Column(children: [
            pw.SizedBox(height: 10),
            pw.Divider(
              color: PdfColors.black,
              height: 2,
            ),
            pw.SizedBox(height: 5),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              pw.Image(height: 20, width: 20, static_image["benz_logo"]!),
              pw.SizedBox(width: 4),
              pw.Text("Merdes-Benz",
                  style: pw.TextStyle(fontSize: contentFontSize + 2)),
              pw.SizedBox(width: 4),
              pw.Text(
                  "are registered trademarks of Daimler AG, Stuttgart, Germany",
                  style: pw.TextStyle(fontSize: contentFontSize)),
            ]),
            pw.SizedBox(height: 20),
          ]);
        },
        build: (context) {
          return [
            // Customer and Vehicle Details
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.max,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "CUSTOMER DETAILS",
                        style: pw.TextStyle(
                            fontSize: headingFontSize,
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Container(
                          width: MediaQuery.of(builderContext).size.width / 2,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: PdfColors.black, width: 1)),
                          child: pw.Column(children: [
                            //Customer Name
                            pw.Padding(
                              padding: pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                      width: 80,
                                      child: pw.Text("Customer Name",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Text("Vaibhav Joshi",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize))
                                ],
                              ),
                            ),

                            //Address
                            pw.Padding(
                              padding: pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 80,
                                      child: pw.Text("Address",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text(
                                          "Cubastion Consulting, Magnum Tower, Sector 58, Gurgaon, Haryana",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //Mobile No.
                            pw.Padding(
                              padding: pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 80,
                                      child: pw.Text("Mobile Number",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("9761888686",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //Caller Name
                            pw.Padding(
                              padding: pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 80,
                                      child: pw.Text("Caller Name",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("Vaibhav Joshi",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //SR No.
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 80,
                                      child: pw.Text("SR Number",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("SA082324SER00649",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //Received On
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 80,
                                      child: pw.Text("Received On",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("10/05/23 07:46",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //Unknown Value
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 80,
                                      child: pw.Text(";",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),
                          ])),
                    ],
                  ),
                ),
                pw.SizedBox(
                  width: 10,
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "VEHICLE DETAILS",
                        style: pw.TextStyle(
                            fontSize: headingFontSize,
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Container(
                          width: MediaQuery.of(builderContext).size.width / 2,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: PdfColors.black, width: 1)),
                          child: pw.Column(children: [
                            //Reg No
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 94,
                                      child: pw.Text("Reg no.",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Text("DL2CBC 1810",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize))
                                ],
                              ),
                            ),

                            //VIN
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 94,
                                      child: pw.Text("VIN",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("W1K2050806L058940",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //Model
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 94,
                                      child: pw.Text("Model",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":"),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("Mercedes-Benz C200",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //1st Regn Date
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 94,
                                      child: pw.Text("1st Regn Date",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("27/11/20",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //Mileage
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 94,
                                      child: pw.Text("Mileage",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("29830",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //Drop
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 94,
                                      child: pw.Text("Drop",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("Yes",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //Last Service
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 94,
                                      child: pw.Text("Last Service",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":",
                                      style: pw.TextStyle(
                                          fontSize: contentFontSize)),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("13/09/22 10:45",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),

                            //Last Service Mielage
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                      width: 94,
                                      child: pw.Text("Last Service Mielage",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize))),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Text(":"),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text("25034",
                                          style: pw.TextStyle(
                                              fontSize: contentFontSize)))
                                ],
                              ),
                            ),
                          ])),
                    ],
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 10),

            // Outside Inventories
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "OUTSIDE INVENTORIES",
                  style: pw.TextStyle(
                      fontSize: headingFontSize,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.Container(
                    height: getHeightOfGridView(2, 2, MediaQuery.of(builderContext).size.width - contentPadding, 4) + 4,
                    width: MediaQuery.of(builderContext).size.width - 20,
                    decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: PdfColors.black, width: 1)),
                    child: pw.GridView(
                      crossAxisCount: 2, // Number of columns in the grid
                      children: List<pw.Widget>.generate(4, (index) {
                        return pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Container(child: pw.Center(child: pw.Image(
                                imageProviders[index])))
                        ); // Create a widget for each item
                      }),
                    ))
              ],
            ),

            pw.SizedBox(height: 10),

            // Inside Inventory
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "INSIDE INVENTORIES",
                  style: pw.TextStyle(
                      fontSize: headingFontSize,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.Container(
                  height: 180,
                  child: pw.ListView.builder(
                    itemCount: (insideInventories.length / 4).ceil(),
                    itemBuilder: (context, int index) {
                      final startIndex = index * 4;
                      final endIndex =
                          (startIndex + 4) >= insideInventories.length
                              ? insideInventories.length
                              : startIndex + 4;
                      final rowItems =
                          insideInventories.sublist(startIndex, endIndex);

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
                                  pw.Expanded(
                                      child: _buildPdfTableCell(rowItems[2])),
                                ],
                              ),
                              pw.Row(
                                children: [
                                  pw.Container(
                                      child: pw.Expanded(
                                          child:
                                              _buildPdfTableCell(rowItems[3]))),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Create a regular row for other elements
                        return pw.Padding(
                          padding: const pw.EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: pw.Row(
                            children: rowItems.map((item) {
                              return pw.Expanded(
                                  child: pw.Container(
                                      child: _buildPdfTableCell(item)));
                            }).toList(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            pw.Text(
              "ENGINE COMPARTMENT",
              style: pw.TextStyle(
                  fontSize: headingFontSize, fontWeight: pw.FontWeight.bold),
            ),

            // ENGINE COMPARTMENT
            pw.Table(
              border: pw.TableBorder.all(width: 1),
              columnWidths: {
                0: pw.FractionColumnWidth(0.1),
                1: pw.FractionColumnWidth(0.3),
                2: pw.FractionColumnWidth(0.1),
                2: pw.FractionColumnWidth(0.15),
              },
              children: [
                _buildPdfRows(["Sl No", "Criteria", "State", "Remarks"],
                    isHeader: true),
                _buildPdfRows(["1", "Fluid Level and Quantity", "", ""]),
                _buildPdfRows(["2", "Hose connections and leakages", "", ""]),
                _buildPdfRows(["3", "V-Belt Condition", "", ""]),
                _buildPdfRows(["4", "Battery Condition", "", ""])
              ],
            ),

            pw.SizedBox(height: 10),

            pw.Text(
              "INSIDE CABIN",
              style: pw.TextStyle(
                  fontSize: headingFontSize, fontWeight: pw.FontWeight.bold),
            ),

            // INSIDE CABIN
            pw.Table(
              border: pw.TableBorder.all(width: 1),
              columnWidths: {
                0: pw.FractionColumnWidth(0.1),
                1: pw.FractionColumnWidth(0.3),
                2: pw.FractionColumnWidth(0.1),
                2: pw.FractionColumnWidth(0.15),
              },
              children: [
                _buildPdfRows(["Sl No", "Criteria", "State", "Remarks"],
                    isHeader: true),
                _buildPdfRows(["1", "Power Window Operation", "", ""]),
                _buildPdfRows(["2", "Horn Operation", "", ""]),
                _buildPdfRows(["3", "Seat Belt Operation", "", ""]),
                _buildPdfRows(["4", "Interior Illumination", "", ""]),
                _buildPdfRows(["5", "Radio Operation", "", ""]),
                _buildPdfRows(["6", "ORVMS Operation", "", ""]),
                _buildPdfRows(
                    ["7", "Wiper and windshield washer operation", "", ""]),
                _buildPdfRows(["8", "Warning and Instrument Cluster", "", ""]),
                _buildPdfRows(["9", "AC Operation", "", ""]),
                _buildPdfRows(["10", "Test", "", ""])
              ],
            ),

            pw.SizedBox(height: 20),

            pw.Text(
              "UNDER BODY",
              style: pw.TextStyle(
                  fontSize: headingFontSize, fontWeight: pw.FontWeight.bold),
            ),

            // INSIDE CABIN
            pw.Table(
              border: pw.TableBorder.all(width: 1),
              columnWidths: {
                0: pw.FractionColumnWidth(0.1),
                1: pw.FractionColumnWidth(0.3),
                2: pw.FractionColumnWidth(0.1),
                2: pw.FractionColumnWidth(0.15),
              },
              children: [
                _buildPdfRows(["Sl No", "Criteria", "State", "Remarks"],
                    isHeader: true),
                _buildPdfRows(["1", "Fuel Leakages (if any)", "", ""]),
                _buildPdfRows([
                  "2",
                  "Condition of engine & Transmission Mountings",
                  "",
                  ""
                ]),
                _buildPdfRows(
                    ["3", "Condition of Suspension Bushes and Links", "", ""]),
                _buildPdfRows(
                    ["4", "Tyre Condition(Damage, Bulge, cut if any)", "", ""]),
                _buildPdfRows(["4", "External Damages", "", ""]),
              ],
            ),

            pw.SizedBox(height: 15),

            pw.Text(
              "REMARKS",
              style: pw.TextStyle(
                  fontSize: headingFontSize, fontWeight: pw.FontWeight.bold),
            ),

            // REMARKS
            pw.Table(
              border: pw.TableBorder.all(width: 1),
              columnWidths: {
                0: pw.FractionColumnWidth(0.01),
              },
              children: [
                _buildPdfRows(["Remarks", ""]),
              ],
            ),

            pw.SizedBox(height: 15),

            pw.Text(
              "CUSTOMER CONCERNS",
              style: pw.TextStyle(
                  fontSize: headingFontSize, fontWeight: pw.FontWeight.bold),
            ),

            // REMARKS
            pw.Table(
              border: pw.TableBorder.all(width: 1),
              columnWidths: {
                0: pw.FractionColumnWidth(0.1),
                1: pw.FractionColumnWidth(0.3),
                2: pw.FractionColumnWidth(0.3),
              },
              children: [
                _buildPdfRows(["Sl No", "Concern", "Remarks"], isHeader: true),
                _buildPdfRows(["1", "Service", ""]),
              ],
            ),

            pw.SizedBox(height: 15),

            pw.Text(
              "SERVICE ADVISOR DETAILS",
              style: pw.TextStyle(
                  fontSize: headingFontSize, fontWeight: pw.FontWeight.bold),
            ),

            // REMARKS
            pw.Table(
              border: pw.TableBorder.all(width: 1),
              columnWidths: {
                0: pw.FractionColumnWidth(0.1),
                0: pw.FractionColumnWidth(0.1),
                0: pw.FractionColumnWidth(0.1),
                0: pw.FractionColumnWidth(0.1),
                0: pw.FractionColumnWidth(0.1),
                0: pw.FractionColumnWidth(0.1),
              },
              children: [
                _buildPdfRows([
                  "Service Advisor Name",
                  "SA Contact No.",
                  "Service Advisor Email",
                  "Expected delivery date and time"
                ], isHeader: true),
                _buildPdfRows([
                  "Raj Kumar",
                  "",
                  "cde16@silverarrows.in",
                  "10/05/23 15:00"
                ]),
              ],
            ),

            pw.SizedBox(height: 15),
            pw.Text(
              "TERMS AND CONDITIONS",
              style: pw.TextStyle(
                  fontSize: headingFontSize, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 5),
            pw.Container(
              child: pw.Text(
                  style: pw.TextStyle(fontSize: contentFontSize - 2),
                  "1. We am solely responsible for the test drives done outside the premises o fdealershio\n2. I/We indemnifyand keept h e Authorized Dealer indemnified againstany costs. risk.liabilitv. responsibility for loss o rdamaget o the vehicle and/ or life or property of al persons arising o u tof test driving of the vehicle by me/us or my/our Authorized Representative. I/We confirmthat I/we have obtained the requisite insurance for the vehicle together with the accessories, components, articlesand/or things containedtherein and theDealer shall i nn owav be liable for any loss. damage or iniury caused to m e/us.\n3. W e will not hold the Dealer responsible/liable for a n delav ni delivery or ni c a r i n g out renairs or procurement of sparenarts for reasons bevond its control\n4. W e undertake to take deliverv of thevehicle within 48 hoursof intimation of completiono frepair or maintenance services. In the event of delavon mw/our part. I/Weagree to dav the storage charges (Rs1000/-IRuDees One Thousand only) per day.\n5. We are agree to pay to Rs 10000/- (Rupees Ten Thousand only or 5% of the total estimated amount.\n6. I/We undertake to make cavment of all charges before takine deliverv of the vehicleand in the event.the delivery si taken without settlement of the bill. I/We undertake to settlethe billwithin 7davs of taking delivery ofthe vehicle. In the event, the bill is not settled within a period of 7 days,the Authorized Dealer may lew an interest @ 41 %p.a. on the outstanding bill amountfrom the date on whichthe vehicle was ready for delivery until payment.\n7. / eacree thatt h e Authorized Dealerm a vexerciselieno n thevehicle until all the above mentioned dies are settled to its satisfaction\n8. I/Weagree that I will a v anv advance amount asreguired by the Authorized Dealer based on the estimated cost before commencement ofthe repairs/maintenance services\n9. / W ehereby authorize the AuthorizedDealer to deliver t h evehicle to m y/our Authorized Representative\n1O. We agree that any disoutes arisingfrom or o u tof this work order shall be settled mutually. ni case, mutuallyacceotable settlement si not arrived at. such disoute shall be sublect to exclusive junsciction of t h ecourt where t h eAuthorized dealer's Registered Office is located\n11. We agrap and understand that t h eWarranty terms and Conditions areconcurrent tothese Termsa n dConditions\n12. I/We hereby grant free consent to the Authorized Dealer, Mercedes-Benz IndiaPrivate Limited and/or their authorized third parties to contactme/us through SMS, call, email, WhatsApp or anyother electronic, telecommunication or physical medium,from time to time. to provide information me/us the status of repair work. estimated cost of repair work,details of repairs/replacement, vehicle location tracking, invoice and payment andfor to obtain mu four feedbackinrelationtot h eservicesprovided b yt h eAuthorized Dealer\n13. I/We authorize the Authorized Dealer, Mercedes-Benz India PrivateLimitedand/or their authorizedthird partiesot send lal or any communication no information no the status fo repair work,estimated cost of repair work, detailso frepairs/replacement. vehicle location trackine. invoiceand oavment to m y/our Authorized Representative\n14. W e hereby authorize theAuthorized Dealer to track the location o fm yo u rvehicle during the pick up from and drop t othe designated place\n15. I/Weagree and understand that the communicationthrough WhatsApp, SMS, email or anyotherelectronicor telecommunication medium will allow me /us toaccess various information pertaining to services availed any third party\n16. I/We herebv declare that I/wea m fullv awarethat communication throughWhatsAoD. SMS.emailor any other electronic or telecommunicationmedium mav not be secure and the Authorized Dealer shall inn o war be responsible for a n personal data privacy infringements caused by a n vact ro omission of anv other third p a r t ywhich m a v be involved ni making t h ecommunication media services available to me / us and to the Dealer. r a m affixing my signature below in evidence of agreeing to the above t e r m sa n dconditions absolutely and unconditionally"),
            ),







            // Payment Type Checkbox
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(

                    // TODO: Need to work on checkbox
                    // children: [
                    //   pw.Text("Cash", style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),),
                    //   pw.SizedBox(
                    //     height: 30, width: 30,
                    //     child: pw.Checkbox(
                    //         value: isSelected,
                    //         onChanged: (currentValue) {
                    //           setState(() {
                    //             isSelected = currentValue ?? false;
                    //           });
                    //         }),
                    //   ),
                    //
                    // ],
                    ),
                pw.SizedBox(
                  width: 10,
                ),
                pw.Row(
                    // children: [
                    //   pw.Text("Credit Card", style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),),
                    //   pw.SizedBox(
                    //     height: 30, width: 30,
                    //     child: Checkbox(
                    //         value: isSelected,
                    //         onChanged: (currentValue) {
                    //           setState(() {
                    //             isSelected = currentValue ?? false;
                    //           });
                    //         }),
                    //   ),
                    //
                    // ],
                    ),
                pw.SizedBox(
                  width: 10,
                ),
                pw.Row(

                    // TODO: Need to work on Checkbox
                    // children: [
                    //   pw.Text("Credit", style: TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),),
                    //   pw.SizedBox(
                    //     height: 30, width: 30,
                    //     child: Checkbox(
                    //         value: isSelected,
                    //         onChanged: (currentValue) {
                    //           setState(() {
                    //             isSelected = currentValue ?? false;
                    //           });
                    //         }),
                    //   ),
                    //
                    // ],

                    ),
                pw.SizedBox(
                  width: 10,
                ),
                pw.Row(

                    // TODO: Need to work on Checkbox
                    // children: [
                    //   pw.Text("Cheque", style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),),
                    //   pw.SizedBox(
                    //     height: 30, width: 30,
                    //     child: Checkbox(
                    //         value: isSelected,
                    //         onChanged: (currentValue) {
                    //           setState(() {
                    //             isSelected = currentValue ?? false;
                    //           });
                    //         }),
                    //   ),
                    //
                    // ],
                    ),
                pw.SizedBox(
                  width: 10,
                ),
                pw.Row(

                    // TODO: Need to work on Checkbox
                    // children: [
                    //   pw.Text("RTGS", style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),),
                    //   pw.SizedBox(
                    //     height: 30, width: 30,
                    //     child: Checkbox(
                    //         value: isSelected,
                    //         onChanged: (currentValue) {
                    //           setState(() {
                    //             isSelected = currentValue ?? false;
                    //           });
                    //         }),
                    //   ),
                    //
                    // ],
                    ),
              ],
            ),

            // Acceptence CheckBox

            pw.SizedBox(
              height: 30,
            ),

            pw.Row(

                // TODO: Need to work on Checkbox
                // children: [
                //   pw.SizedBox(
                //     height: 30, width: 30,
                //     child: Checkbox(
                //         value: isSelected,
                //         onChanged: (currentValue) {
                //           setState(() {
                //             isSelected = currentValue ?? false;
                //           });
                //         }),
                //   ),
                //   Text("I hereby authorize the repairs as described to the executed using necessary material. I agree to bound by the Terms and Conditions."),
                //
                // ],
                ),

            // Signature Image
            pw.Container(
              child: pw.SizedBox(
                width: 170,
                height: 160,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.fromLTRB(0, 20, 20, 20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,

                    // TODO: Need to work on Signature Image
                    // children: [
                    //   pw.Container(
                    //     height: 100,
                    //     width: 150,
                    //     child: widget.imageData != null
                    //         ? pw.Container(
                    //       child: pw.Image(
                    //         image: MemoryImage(widget.imageData!),
                    //         width:
                    //         200, // Set the desired width of the image
                    //         height:
                    //         200, // Set the desired height of the image
                    //       ),
                    //     )
                    //         : Center(
                    //       child: SizedBox(
                    //         height: 50,
                    //         child: ElevatedButton(
                    //             onPressed: () {
                    //               showPopup(context);
                    //             },
                    //             child: Text("Add Signature")),
                    //       ),
                    //     ),
                    //   ),
                    //
                    //
                    //   Divider(color: Colors.black, height: 2,),
                    //
                    //   Text("Customer's Signature")
                    // ],
                  ),
                ),
              ),
            ),
          ];
        }));

    final pdfData = await pdf.save();

    // Save the PDF to a temporary file
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/my_view.pdf");
    await file.writeAsBytes(pdfData);

    // Share PDF via sharing platforms.
    await Printing.sharePdf(bytes: pdfData, filename: 'my_view.pdf');

    // Open the PDF using the flutter_pdfview plugin
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
    return Scaffold(
        appBar: AppBar(
          title: (fist) ? Text('My View') : Text('rahul'),
          actions: [
            ElevatedButton(
                onPressed: generatePDF, child: Icon(Icons.picture_as_pdf))
          ],
        ),
        body: _buildContentView(context));
  }

  Widget _buildContentView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            // Heading
            Column(
              children: [
                Text("Silver Arrow - Workshop Delhi 52 Sohna Road",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text("52B Rama Road, New Delhi DL. Ph no: 01148200500",
                    style: TextStyle(fontSize: 20)),
              ],
            ),

            SizedBox(height: 30),

            // Customer and Vehicle Details
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "CUSTOMER DETAILS",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: (MediaQuery.of(context).size.width - 30) / 2,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child: Column(children: [
                              //Customer Name
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Text("CUSTOMER Name")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Container(
                                            child: Text("Vaibhav Joshi")))
                                  ],
                                ),
                              ),

                              //Address
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150, child: Text("Address")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                            "Cubastion Consulting, Magnum Tower, Sector 58, Gurgaon, Haryana"))
                                  ],
                                ),
                              ),

                              //Mobile No.
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Text("Mobile Number")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("9761888686"))
                                  ],
                                ),
                              ),

                              //Caller Name
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150, child: Text("Caller Name")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("Vaibhav Joshi"))
                                  ],
                                ),
                              ),

                              //SR No.
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150, child: Text("SR Number")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("SA082324SER00649"))
                                  ],
                                ),
                              ),

                              //Received On
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150, child: Text("Received On")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("10/05/23 07:46"))
                                  ],
                                ),
                              ),

                              //Unknown Value
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 150, child: Text(";")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text(""))
                                  ],
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "VEHICLE DETAILS",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: (MediaQuery.of(context).size.width - 30) / 2,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child: Column(children: [
                              //Reg No
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150, child: Text("Reg no.")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Container(
                                            child: Text("DL2CBC 1810")))
                                  ],
                                ),
                              ),

                              //VIN
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 150, child: Text("VIN")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("W1K2050806L058940"))
                                  ],
                                ),
                              ),

                              //Model
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 150, child: Text("Model")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("Mercedes-Benz C200"))
                                  ],
                                ),
                              ),

                              //1st Regn Date
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Text("1st Regn Date")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("27/11/20"))
                                  ],
                                ),
                              ),

                              //Mileage
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150, child: Text("Mileage")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("29830"))
                                  ],
                                ),
                              ),

                              //Drop
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 150, child: Text("Drop")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("Yes"))
                                  ],
                                ),
                              ),

                              //Last Service
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Text("Last Service")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("13/09/22 10:45"))
                                  ],
                                ),
                              ),

                              //Last Service Mielage
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Text("Last Service Mielage")),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(":"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: Text("25034"))
                                  ],
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Outside Inventories
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "OUTSIDE INVENTORIES",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: getHeightOfGridView(
                          2,
                          2,
                          MediaQuery.of(context).size.width - contentPadding,
                          4) +
                      4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              ],
            ),

            SizedBox(height: 20),

            // Inside Inventory
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "INSIDE INVENTORIES",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 280,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: (insideInventories.length / 4).ceil(),
                    itemBuilder: (BuildContext context, int index) {
                      final startIndex = index * 4;
                      final endIndex =
                          (startIndex + 4) >= insideInventories.length
                              ? insideInventories.length
                              : startIndex + 4;
                      final rowItems =
                          insideInventories.sublist(startIndex, endIndex);

                      if (endIndex == insideInventories.length - 1) {
                        // Create a separate row for second-to-last and last elements
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  contentPadding) /
                                              4,
                                      child: _buildTableCell(rowItems[0])),
                                  Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  contentPadding) /
                                              4,
                                      child: _buildTableCell(rowItems[1])),
                                  Expanded(child: _buildTableCell(rowItems[2])),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      child: Expanded(
                                          child: _buildTableCell(rowItems[3]))),
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
                                  child:
                                      Container(child: _buildTableCell(item)));
                            }).toList(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ENGINE COMPARTMENT",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // ENGINE COMPARTMENT
                Table(
                  border: TableBorder.all(width: 2),
                  columnWidths: {
                    0: FractionColumnWidth(0.1),
                    1: FractionColumnWidth(0.3),
                    2: FractionColumnWidth(0.1),
                    2: FractionColumnWidth(0.15),
                  },
                  children: [
                    _buildRows(["Sl No", "Criteria", "State", "Remarks"],
                        isHeader: true),
                    _buildRows(["1", "Fluid Level and Quantity", "", ""]),
                    _buildRows(["2", "Hose connections and leakages", "", ""]),
                    _buildRows(["3", "V-Belt Condition", "", ""]),
                    _buildRows(["4", "Battery Condition", "", ""])
                  ],
                ),

                SizedBox(height: 10),

                Text(
                  "INSIDE CABIN",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // INSIDE CABIN
                Table(
                  border: TableBorder.all(width: 2),
                  columnWidths: {
                    0: FractionColumnWidth(0.1),
                    1: FractionColumnWidth(0.3),
                    2: FractionColumnWidth(0.1),
                    2: FractionColumnWidth(0.15),
                  },
                  children: [
                    _buildRows(["Sl No", "Criteria", "State", "Remarks"],
                        isHeader: true),
                    _buildRows(["1", "Power Window Operation", "", ""]),
                    _buildRows(["2", "Horn Operation", "", ""]),
                    _buildRows(["3", "Seat Belt Operation", "", ""]),
                    _buildRows(["4", "Interior Illumination", "", ""]),
                    _buildRows(["5", "Radio Operation", "", ""]),
                    _buildRows(["6", "ORVMS Operation", "", ""]),
                    _buildRows(
                        ["7", "Wiper and windshield washer operation", "", ""]),
                    _buildRows(["8", "Warning and Instrument Cluster", "", ""]),
                    _buildRows(["9", "AC Operation", "", ""]),
                    _buildRows(["10", "Test", "", ""])
                  ],
                ),

                SizedBox(height: 20),

                Text(
                  "INSIDE CABIN",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // INSIDE CABIN
                Table(
                  border: TableBorder.all(width: 2),
                  columnWidths: {
                    0: FractionColumnWidth(0.1),
                    1: FractionColumnWidth(0.3),
                    2: FractionColumnWidth(0.1),
                    2: FractionColumnWidth(0.15),
                  },
                  children: [
                    _buildRows(["Sl No", "Criteria", "State", "Remarks"],
                        isHeader: true),
                    _buildRows(["1", "Fuel Leakages (if any)", "", ""]),
                    _buildRows([
                      "2",
                      "Condition of engine & Transmission Mountings",
                      "",
                      ""
                    ]),
                    _buildRows([
                      "3",
                      "Condition of Suspension Bushes and Links",
                      "",
                      ""
                    ]),
                    _buildRows([
                      "4",
                      "Tyre Condition(Damage, Bulge, cut if any)",
                      "",
                      ""
                    ]),
                    _buildRows(["4", "External Damages", "", ""]),
                  ],
                ),

                SizedBox(height: 20),

                Text(
                  "REMARKS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // REMARKS
                Table(
                  border: TableBorder.all(width: 2),
                  columnWidths: {
                    0: FractionColumnWidth(0.1),
                  },
                  children: [
                    _buildRows(["Remarks", ""], isHeader: true),
                  ],
                ),

                SizedBox(height: 20),

                Text(
                  "CUSTOMER CONCERNS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // REMARKS
                Table(
                  border: TableBorder.all(width: 2),
                  columnWidths: {
                    0: FractionColumnWidth(0.1),
                    0: FractionColumnWidth(0.1),
                  },
                  children: [
                    _buildRows(["Sl No", "Concern", "Remarks"], isHeader: true),
                    _buildRows(["1", "Service", ""]),
                  ],
                ),

                SizedBox(height: 20),

                Text(
                  "CUSTOMER CONCERNS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // REMARKS
                Table(
                  border: TableBorder.all(width: 2),
                  columnWidths: {
                    0: FractionColumnWidth(0.1),
                    0: FractionColumnWidth(0.1),
                  },
                  children: [
                    _buildRows(["Sl No", "Concern", "Remarks"], isHeader: true),
                    _buildRows(["1", "Service", ""]),
                  ],
                ),

                SizedBox(height: 20),

                Text(
                  "SERVICE ADVISOR DETAILS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // REMARKS
                Table(
                  border: TableBorder.all(width: 2),
                  columnWidths: {
                    0: FractionColumnWidth(0.1),
                    0: FractionColumnWidth(0.1),
                    0: FractionColumnWidth(0.1),
                    0: FractionColumnWidth(0.1),
                    0: FractionColumnWidth(0.1),
                    0: FractionColumnWidth(0.1),
                  },
                  children: [
                    _buildRows([
                      "Service Advisor Name",
                      "SA Contact No.",
                      "Service Advisor Email",
                      "Expected delivery date and time"
                    ], isHeader: true),
                    _buildRows([
                      "Raj Kumar",
                      "",
                      "cde16@silverarrows.in",
                      "10/05/23 15:00"
                    ]),
                  ],
                ),

                SizedBox(height: 20),
                Text(
                  "TERMS AND CONDITIONS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(
                      "1. We am solely responsible for the test drives done outside the premises o fdealershio\n2. I/We indemnifyand keept h e Authorized Dealer indemnified againstany costs. risk.liabilitv. responsibility for loss o rdamaget o the vehicle and/ or life or property of al persons arising o u tof test driving of the vehicle by me/us or my/our Authorized Representative. I/We confirmthat I/we have obtained the requisite insurance for the vehicle together with the accessories, components, articlesand/or things containedtherein and theDealer shall i nn owav be liable for any loss. damage or iniury caused to m e/us.\n3. W e will not hold the Dealer responsible/liable for a n delav ni delivery or ni c a r i n g out renairs or procurement of sparenarts for reasons bevond its control\n4. W e undertake to take deliverv of thevehicle within 48 hoursof intimation of completiono frepair or maintenance services. In the event of delavon mw/our part. I/Weagree to dav the storage charges (Rs1000/-IRuDees One Thousand only) per day.\n5. We are agree to pay to Rs 10000/- (Rupees Ten Thousand only or 5% of the total estimated amount.\n6. I/We undertake to make cavment of all charges before takine deliverv of the vehicleand in the event.the delivery si taken without settlement of the bill. I/We undertake to settlethe billwithin 7davs of taking delivery ofthe vehicle. In the event, the bill is not settled within a period of 7 days,the Authorized Dealer may lew an interest @ 41 %p.a. on the outstanding bill amountfrom the date on whichthe vehicle was ready for delivery until payment.\n7. / eacree thatt h e Authorized Dealerm a vexerciselieno n thevehicle until all the above mentioned dies are settled to its satisfaction\n8. I/Weagree that I will a v anv advance amount asreguired by the Authorized Dealer based on the estimated cost before commencement ofthe repairs/maintenance services\n9. / W ehereby authorize the AuthorizedDealer to deliver t h evehicle to m y/our Authorized Representative\n1O. We agree that any disoutes arisingfrom or o u tof this work order shall be settled mutually. ni case, mutuallyacceotable settlement si not arrived at. such disoute shall be sublect to exclusive junsciction of t h ecourt where t h eAuthorized dealer's Registered Office is located\n11. We agrap and understand that t h eWarranty terms and Conditions areconcurrent tothese Termsa n dConditions\n12. I/We hereby grant free consent to the Authorized Dealer, Mercedes-Benz IndiaPrivate Limited and/or their authorized third parties to contactme/us through SMS, call, email, WhatsApp or anyother electronic, telecommunication or physical medium,from time to time. to provide information me/us the status of repair work. estimated cost of repair work,details of repairs/replacement, vehicle location tracking, invoice and payment andfor to obtain mu four feedbackinrelationtot h eservicesprovided b yt h eAuthorized Dealer\n13. I/We authorize the Authorized Dealer, Mercedes-Benz India PrivateLimitedand/or their authorizedthird partiesot send lal or any communication no information no the status fo repair work,estimated cost of repair work, detailso frepairs/replacement. vehicle location trackine. invoiceand oavment to m y/our Authorized Representative\n14. W e hereby authorize theAuthorized Dealer to track the location o fm yo u rvehicle during the pick up from and drop t othe designated place\n15. I/Weagree and understand that the communicationthrough WhatsApp, SMS, email or anyotherelectronicor telecommunication medium will allow me /us toaccess various information pertaining to services availed any third party\n16. I/We herebv declare that I/wea m fullv awarethat communication throughWhatsAoD. SMS.emailor any other electronic or telecommunicationmedium mav not be secure and the Authorized Dealer shall inn o war be responsible for a n personal data privacy infringements caused by a n vact ro omission of anv other third p a r t ywhich m a v be involved ni making t h ecommunication media services available to me / us and to the Dealer. r a m affixing my signature below in evidence of agreeing to the above t e r m sa n dconditions absolutely and unconditionally"),
                ),
              ],
            ),

            // Payment Type Checkbox
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Cash",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Checkbox(
                          value: isSelected,
                          onChanged: (currentValue) {
                            setState(() {
                              isSelected = currentValue ?? false;
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Credit Card",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Checkbox(
                          value: isSelected,
                          onChanged: (currentValue) {
                            setState(() {
                              isSelected = currentValue ?? false;
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Credit",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Checkbox(
                          value: isSelected,
                          onChanged: (currentValue) {
                            setState(() {
                              isSelected = currentValue ?? false;
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Cheque",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Checkbox(
                          value: isSelected,
                          onChanged: (currentValue) {
                            setState(() {
                              isSelected = currentValue ?? false;
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Text(
                      "RTGS",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Checkbox(
                          value: isSelected,
                          onChanged: (currentValue) {
                            setState(() {
                              isSelected = currentValue ?? false;
                            });
                          }),
                    ),
                  ],
                ),
              ],
            ),

            // Acceptence CheckBox

            SizedBox(
              height: 30,
            ),

            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Checkbox(
                      value: isSelected,
                      onChanged: (currentValue) {
                        setState(() {
                          isSelected = currentValue ?? false;
                        });
                      }),
                ),
                Expanded(
                    child: Container(
                        child: Text(
                            "I hereby authorize the repairs as described to the executed using necessary material. I agree to bound by the Terms and Conditions."))),
              ],
            ),

            // Signature Image
            Row(
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
                        Container(
                          height: 100,
                          width: 150,
                          child: widget.imageData != null
                              ? Container(
                                  child: Image(
                                    image: MemoryImage(widget.imageData!),
                                    width:
                                        200, // Set the desired width of the image
                                    height:
                                        200, // Set the desired height of the image
                                  ),
                                )
                              : Center(
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          showPopup(context);
                                        },
                                        child: Text("")),
                                  ),
                                ),
                        ),
                        Divider(
                          color: Colors.black,
                          height: 2,
                        ),
                        Text("Customer's Signature")
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Tyre Info

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Health Card",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  "Health Card",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                ///First 3 objects
                SizedBox(
                  height: 780,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: models.length,
                      itemBuilder: (context, index) {
                        return ModelTemplate(
                            count: models[index].length,
                            title: models[index].title,
                            regularBoxContent: models[index].specs);
                      }),
                ),

                ///4th and 5th object
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        _verticalRectangle(
                            170, 'Battery \n (Report to be attached)'),
                        _verticalRectangle(60,
                            'Vehicle Electronics \n (Report to be attached)'),
                      ],
                    ),
                    Column(children: [
                      _regularContainer(40, textChild('Voltage', 'volts')),
                      _regularContainer(
                          130,
                          Column(
                            children: [
                              CheckboxListTile(
                                value: false,
                                onChanged: (value) {},
                                title: const Text(
                                    'Good Condition Replacement (in yrs)'),
                              ),
                              CheckboxListTile(
                                value: false,
                                onChanged: (value) {},
                                title: const Text('change Battery'),
                              )
                            ],
                          )),
                      _regularContainer(
                          60,
                          CheckboxListTile(
                            value: false,
                            onChanged: (value) {},
                            title: const Text('No Fault'),
                          )),
                    ]),
                    Column(children: [
                      _regularContainer(40, textChild('', '')),
                      _regularContainer(
                          130,
                          Column(
                            children: [
                              CheckboxListTile(
                                value: false,
                                onChanged: (value) {},
                                title: const Text('Genuine'),
                              ),
                              CheckboxListTile(
                                value: false,
                                onChanged: (value) {},
                                title: const Text('Non-Genuine'),
                              )
                            ],
                          )),
                      _regularContainer(
                        60,
                        const Text("Please specify if any remarks: "),
                      ),
                    ]),
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
                            'Personalized advice to customer on Vehicle performance and useage'),
                        _verticalRectangle(40, 'next maintenance interval'),
                        _verticalRectangle(100, 'next service check points'),
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
                                  width: 25,
                                ),
                                Text('KM'),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text('Date'),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text('(Whichever comes early)')
                              ],
                            )),
                        _horizontalRectangle(100, _lastContent()),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

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

  void onPopupButtonClicked(Uint8List result) {
    if (result != null) {
      widget.generatePDFFromCallBack(result);
      setState(() {
        widget.imageData = result;
      });
    }
  }

  Widget buildTyreSize() {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),

        ///First 3 objects
        SizedBox(
          height: 780,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: models.length,
              itemBuilder: (context, index) {
                return ModelTemplate(
                    count: models[index].length,
                    title: models[index].title,
                    regularBoxContent: models[index].specs);
              }),
        ),

        ///4th and 5th object
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _verticalRectangle(170, 'Battery \n (Report to be attached)'),
                _verticalRectangle(
                    60, 'Vehicle Electronics \n (Report to be attached)'),
              ],
            ),
            Column(children: [
              _regularContainer(40, textChild('Voltage', 'volts')),
              _regularContainer(
                  130,
                  Column(
                    children: [
                      CheckboxListTile(
                        value: false,
                        onChanged: (value) {},
                        title:
                            const Text('Good Condition Replacement (in yrs)'),
                      ),
                      CheckboxListTile(
                        value: false,
                        onChanged: (value) {},
                        title: const Text('change Battery'),
                      )
                    ],
                  )),
              _regularContainer(
                  60,
                  CheckboxListTile(
                    value: false,
                    onChanged: (value) {},
                    title: const Text('No Fault'),
                  )),
            ]),
            Column(children: [
              _regularContainer(40, textChild('', '')),
              _regularContainer(
                  130,
                  Column(
                    children: [
                      CheckboxListTile(
                        value: false,
                        onChanged: (value) {},
                        title: const Text('Genuine'),
                      ),
                      CheckboxListTile(
                        value: false,
                        onChanged: (value) {},
                        title: const Text('Non-Genuine'),
                      )
                    ],
                  )),
              _regularContainer(
                60,
                const Text("Please specify if any remarks: "),
              ),
            ]),
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
                    'Personalized advice to customer on Vehicle performance and useage'),
                _verticalRectangle(40, 'next maintenance interval'),
                _verticalRectangle(100, 'next service check points'),
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
                          width: 25,
                        ),
                        Text('KM'),
                        const SizedBox(
                          width: 25,
                        ),
                        Text('Date'),
                        const SizedBox(
                          width: 25,
                        ),
                        Text('(Whichever comes early)')
                      ],
                    )),
                _horizontalRectangle(100, _lastContent()),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }

  // Build Rows while adding pages in PDF
  pw.TableRow _buildPdfRows(List<String> cells, {bool isHeader = false}) =>
      pw.TableRow(
        children: cells.map((cell) {
          final style = pw.TextStyle(
              fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
              fontSize: contentFontSize);
          return pw.Container(
              color: isHeader ? PdfColors.grey : PdfColors.white,
              child: pw.Padding(
                  padding: pw.EdgeInsets.all(8),
                  child: pw.Center(child: pw.Text(cell, style: style))));
        }).toList(),
      );

  // Build Table Cell while adding table in PDF
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

                  // TODO: Resolve Icon related Error
                  child: (item.value is bool)
                      ? (item.value == true)
                          ? pw.Center(
                              child: pw.Container(
                                  width: 10,
                                  height: 10,
                                  child: pw.Image(static_image["check_box"]!)))
                          : pw.Center()
                      : pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Text(
                            item.value.toString(),
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
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);
          return Container(
              color: isHeader ? Colors.grey[300] : Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: isHeader
                      ? Center(child: Text(cell, style: style))
                      : Text(cell, style: style)));
        }).toList(),
      );

  Widget _buildTableCell(InsideInventory item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Container(
        width: (MediaQuery.of(context).size.width - contentPadding) / 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                width: (MediaQuery.of(context).size.width - 330) / 4,
                child: Text(item.type),
              ),
            ),
            Expanded(
              child: Container(
                  width: 40,
                  height: 40,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: (item.value is bool)
                      ? (item.value == true)
                          ? Icon(Icons.check)
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

  double getHeightOfGridView(double aspectRatio, double crossAxisCount,
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
    return Column(
      children: [
        Row(
          children: [
            _checkBoxTile('Oil and Fluids'),
            _checkBoxTile('Oil Filter'),
            _checkBoxTile('Air Filter'),
            _checkBoxTile('Transmission Filter'),
          ],
        ),
        Row(
          children: [
            _checkBoxTile('AC Filter'),
            _checkBoxTile('Wiper'),
            _checkBoxTile('V-Belt'),
            _checkBoxTile('Spark Plug'),
          ],
        )
      ],
    );
  }

  Widget _checkBoxTile(String text) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {}),
        Text(text),
      ],
    );
  }

  Widget textChild(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(text1),
        Text(text2),
      ],
    );
  }

  Widget _regularContainer(double height, Widget child) {
    return Builder(builder: (context) {
      return Container(
        height: height,
        width: (MediaQuery.of(context).size.width - 40) * 0.4,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black), color: Colors.white),
        child: child,
      );
    });
  }

  Widget _verticalRectangle(double height, String text) {
    return Builder(builder: (context) {
      return Container(
        height: height,
        width: (MediaQuery.of(context).size.width - 40) * 0.2,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.grey.shade300),
        child: Center(child: Text(text)),
      );
    });
  }

  Widget _horizontalRectangle(double height, Widget child) {
    return Builder(builder: (context) {
      return Container(
        height: height,
        width: (MediaQuery.of(context).size.width - 40) * 0.8,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black), color: Colors.white),
        child: child,
      );
    });
  }
}
