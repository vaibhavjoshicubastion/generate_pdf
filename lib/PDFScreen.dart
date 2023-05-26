import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'SignatureView.dart';

class PDFScreen extends StatefulWidget {
  final String? filePath;

  Uint8List? imageData;

  Uint8List? get _imageData => imageData;

  final Function(Uint8List) regeneratePDF;

  set getImageData(Uint8List value) {
    imageData = value;
  }

  PDFScreen({super.key, required this.filePath, required imageData, required this.regeneratePDF});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: addPageToExistingPdf, child: Icon(Icons.add)
          ),

          ElevatedButton(
            onPressed: () {
              showPopup(context); // Pass the context of the current build method
            },
            child: Text('Open Popup'),
          ),

        ],
      ),
      body: PDFView(
        filePath: widget.filePath,
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

    if(result != null) {
      widget.regeneratePDF(result);
      Navigator.of(context).pop();
    }
  }

  void addPageToExistingPdf() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignatureView(onButtonClicked: (Uint8List result) {},)));
  }
}
