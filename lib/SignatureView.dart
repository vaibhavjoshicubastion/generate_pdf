import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:pdf_generate/PDFScreen.dart';
import 'package:pdf_generate/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';

import 'MyView.dart';

class SignatureView extends StatefulWidget {
  final Function(Uint8List) onButtonClicked;
  const SignatureView({super.key, required this.onButtonClicked});

  @override
  State<SignatureView> createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  // initialize the signature controller
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 6,
    penColor: Colors.black,
    exportBackgroundColor: Colors.grey[200],
    exportPenColor: Colors.black,
    onDrawStart: () => debugPrint('onDrawStart called!'),
    onDrawEnd: () => debugPrint('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => log('Value changed'));
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  Future<void> exportImage(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarPNG'),
          content: Text('No content'),
        ),
      );
      return;
    }

    final Uint8List? data =
    await _controller.toPngBytes(height: 1000, width: 1000);
    if (data == null) {
      return;
    }
    if (!mounted) return;

    widget.onButtonClicked(data);

    Navigator.of(context).pop();

    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyView(data)), (Route<dynamic> route) => false);
    
    // Navigator.of(context).pushNamed('/second', arguments:MyView(data) );
    // // Navigator.push(context, MaterialPageRoute(builder: (context )=>MyView(data)));
     
    
  }

  Future<void> exportSVG(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarSVG'),
          content: Text('No content'),
        ),
      );
      return;
    }

    final SvgPicture data = _controller.toSVG()!;

    if (!mounted) return;

    await push(
      context,
      Scaffold(
        appBar: AppBar(
          title: const Text('SVG Image'),
        ),
        body: Center(
          child: Container(
            color: Colors.grey[300],
            child: data,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Signature'),
      ),
      body: Center(
        child: Signature(
          key: const Key('signature'),
          controller: _controller,
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          backgroundColor: Colors.grey[200]!,
        ),

      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //SHOW EXPORTED IMAGE IN NEW ROUTE
              IconButton(
                key: const Key('exportPNG'),
                icon: const Icon(Icons.done),
                color: Colors.white,
                onPressed: () => exportImage(context),
                tooltip: 'Export Image',
              ),
              IconButton(
                key: const Key('exportSVG'),
                icon: const Icon(Icons.image),
                color: Colors.white,
                onPressed: () => exportSVG(context),
                tooltip: 'Export SVG',
              ),
              IconButton(
                icon: const Icon(Icons.undo),
                color: Colors.white,
                onPressed: () {
                  setState(() => _controller.undo());
                },
                tooltip: 'Undo',
              ),
              IconButton(
                icon: const Icon(Icons.redo),
                color: Colors.white,
                onPressed: () {
                  setState(() => _controller.redo());
                },
                tooltip: 'Redo',
              ),
              //CLEAR CANVAS
              IconButton(
                key: const Key('clear'),
                icon: const Icon(Icons.clear),
                color: Colors.white,
                onPressed: () {
                  setState(() => _controller.clear());
                },
                tooltip: 'Clear',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
