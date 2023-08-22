//
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'package:pdf_generate/Modal/Model.dart';
//
// class PDFClass {
//   final double xWidth;
//   final double xHeight;
//   double fontSize = 8.0;
//   List<ProfileModel> profileList = [
//     ProfileModel(pName: "Customer name"),
//     ProfileModel(pName: "")
//   ];
//   List<ProfileModel> staticProfileList = [ProfileModel(pName: "Abhishek Biswas")];
//
//
//   PDFClass({
//     required this.xWidth,
//     required this.xHeight,
//   });
//
//
//
//
//   final singleNameModel = ProfileModel(pName: "Abhishek Biswas",
//       pAddreess: "MMM Hall IIT KGP", pMobileNumber: "+91456787654356", pCallerName: "Abhishek Biswas",
//       pSRNumber: "213456754321", pRecivedOn: "17/7/2015");
//
//   final staticNameModel = ProfileModel(pName: "Customer name",
//       pAddreess: "Address", pMobileNumber: "Mobile Number", pCallerName: "Caller Nam",
//       pSRNumber: "SR Number", pRecivedOn: "Received On");
//
//   Widget singleRow(String name, String value) {
//     return Row(
//       children: [
//         Row(
//           children: [
//             Text(name, style: const TextStyle(fontSize: 8)),
//             Spacer(),
//             Text(":", style: const TextStyle(fontSize: 8) )
//           ]
//         ),
//         Text(value, style: const TextStyle(fontSize: 8))
//       ]
//     );
//   }
//
//   Widget getDetails(int count){
//     return Container(
//       child: ListView.builder(itemBuilder: (context, idx){
//         return singleRow(pStaticModel[idx].pName, pModel[idx])
//       }, itemCount: count)
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
