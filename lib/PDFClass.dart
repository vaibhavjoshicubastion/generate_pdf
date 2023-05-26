import 'package:pdf/widgets.dart';

class PDFClass {

  void xyz(){
    final pdf = Document();

    pdf.addPage(

     MultiPage(build: (context){
       return [

       ];
     })
    );
  }
}