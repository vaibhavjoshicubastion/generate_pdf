import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ModelTemplate extends StatelessWidget {
  final int count;
  final String title;
  final List<List<String>> regularBoxContent;
  const ModelTemplate({Key? key, required this.count, required this.title, required this.regularBoxContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _verticalRectangle(60.0 * count, title),
        // Column(
        //   children: List.filled(count, _regularContainer(60, _regularContainer(60, Text("anand")))),
        // ),
        SizedBox(
          height: 60.0 * count,
          width: (MediaQuery.of(context).size.width - 40) * 0.4,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: count,
              itemBuilder: (context, index){
                return _regularContainer(60, Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Text(regularBoxContent[index].first), Text(regularBoxContent[index][1])],));
              }),
        ),
        Column(
          children: List.filled(count, TriangleTemplate()),
        )
      ],
    );
  }

  Widget _regularContainer(double height, Widget child){
    return Builder(
        builder: (context){
          return Container(
            height: height,
            // width: (MediaQuery.of(context).size.width - 40) * 0.4,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white
            ),
            child: child,
          );
        }
    );
  }

  Widget _verticalRectangle(double height, String text){
    return Builder(
        builder: (context){
          return Container(
            height: height,
            width: (MediaQuery.of(context).size.width - 40) * 0.2,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.grey.shade300
            ),
            child: Center(child: Text(text)),
          );
        }
    );
  }
}


class TrianglePainter0 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width , 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TrapezoidPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0,size.height)
      ..lineTo(0, size.height/2)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TrapezoidPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0,size.height)
      ..lineTo(0, size.height*(1/3))
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TriangleWidget extends StatelessWidget {

  final double width = 74;
  final double height = 30;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: width/3,
            height: height/3 *1,
            child: CustomPaint(
              painter: TrianglePainter0(),
            ),
          ),
          SizedBox(
            width: width/3,
            height: height/3 *2,
            child: CustomPaint(
              painter: TrapezoidPainter1(),
            ),
          ),
          SizedBox(
            width: width/3,
            height: height,
            child: CustomPaint(
              painter: TrapezoidPainter2(),
            ),
          ),
        ],
      ),
    );
  }
}

class TriangleTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: (MediaQuery.of(context).size.width - 40) * 0.4,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
              scale: 0.7,
              child: Checkbox(value: false, onChanged: (value){})
          ),

          const Text('Replace'),

          const SizedBox(width: 10),

          SizedBox(
              child: TriangleWidget()
          ),
          const SizedBox(width: 10,),
          const Text('Good'),
          Transform.scale(
              scale: 0.7,
              child: Checkbox(value: false, onChanged: (value){})
          ),
        ],
      ),

    );
  }
}