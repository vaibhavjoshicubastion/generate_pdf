import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf_generate/MyView.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyView(null, (_) => null)));
          },
          child: Text("Click Here!"),
        ),
      ),
    );
  }
}
