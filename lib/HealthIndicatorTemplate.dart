import 'package:flutter/material.dart';
import 'Modal/Model.dart';

class HealthIndicatorTemplate extends StatefulWidget {
  final String title;
  final List<SubModel> regularBoxContent;
  Function(bool?) onGoodValueChanged;
  bool isSelected;
  Function(bool?) onReplaceValueChanged;
  HealthIndicatorTemplate({Key? key, required this.isSelected, required this.title, required this.regularBoxContent, required this.onReplaceValueChanged, required this.onGoodValueChanged}) : super(key: key);

  @override
  State<HealthIndicatorTemplate> createState() => _HealthIndicatorTemplateState();
}

class _HealthIndicatorTemplateState extends State<HealthIndicatorTemplate> {
  double currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _verticalRectangle(60.0 * widget.regularBoxContent.length, widget.title),
        SizedBox(
          height: 60.0 * widget.regularBoxContent.length,
          width: (MediaQuery.of(context).size.width - 40) * 0.8,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.regularBoxContent.length,
              itemBuilder: (context, index){
                return Row(
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 40) * 0.4,
                      child: _regularContainer(60, Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(widget.regularBoxContent[index].specItemName), // Static names like Rear Wheel Left, Rear Wheel Right etc. No need to change this.
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Row(
                              children: [
                                Text(widget.regularBoxContent[index].specItemValue, style: const TextStyle(fontWeight: FontWeight.bold),), // This will show the values of Break Pad/Thread Depth (Eg: 4.3 mm etc) fetched from health card.
                                const SizedBox(width: 10.0),
                                Text(widget.regularBoxContent[index].specItemUnit) // This is a static value mm (millimeters). No need to change this value.
                              ],
                            ),
                          )],
                      )),
                    ),
                    _regularContainer(60, condition(context, widget.regularBoxContent[index])),
                  ],
                );
              }),
        ),

        // Column(
        //   children: List.filled(regularBoxContent.length, TriangleTemplate(itemName: 3)),
        // )
      ],
    );
  }

  // Widget to show the condition of the tyre. Also, option to check if the part is in good condtion or to be replaced.
  Widget condition(BuildContext context, SubModel currentModel) {
    double size = double.parse(currentModel.specItemValue);
    String assetURL = "assets/images/";
    if (size == 0) {
      assetURL = "${assetURL}Group 15.png";
    } else if (size > 0 && size <= 3) {
      assetURL = "${assetURL}Group 14.png";
    } else if (size > 3 && size <= 5) {
      assetURL = "${assetURL}Group 13.png";
    } else {
      assetURL = "${assetURL}Group 12.png";
    }
    return SizedBox(
      height: 60,
      width: (MediaQuery.of(context).size.width - 40) * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
              scale: 0.8,
              child: checkboxWithTitle(isSelected: currentModel.isReplaceable, "Replace", onValueChanged: (newValue) {
                setState(() {
                  currentModel.isReplaceable = !newValue!;
                  currentModel.isGood = false;
                });
              }, spacing: 0)
          ),

          const SizedBox(width: 20,),

          SizedBox(
              width: 80,
              height: 35,
              child: Image.asset(assetURL) //TriangleWidget()
          ),
          const SizedBox(width: 30,),
          const Text('Good'),
          Transform.scale(
              scale: 0.8,
              child: checkboxWithTitle(isSelected: currentModel.isGood, "", onValueChanged: (newValue){
                setState(() {
                  currentModel.isGood = !newValue!;
                  currentModel.isReplaceable = false;
                });
              })
          ),
        ],
      ),

    );
  }

  Widget checkboxWithTitle(
       // Change 'bool' to 'bool?' here
      String title, {double spacing = 5, required Function(bool?) onValueChanged, required bool isSelected}) {
    return Row(
      children: [
        Checkbox(
          value: isSelected,
          fillColor: MaterialStateProperty.all(Colors.black),
          // Use a default value if isSelected is null
          onChanged: (bool? newValue) {
            onValueChanged!(!(newValue ?? false));
          },
        ),
        (title.isEmpty) ? const SizedBox() : SizedBox(width: spacing),
        (title.isEmpty) ? const SizedBox() : Text(title, style: const TextStyle(fontSize: 15),),
      ],
    );
  }

  // Widget used for Rear Wheel Right, Rear Wheel left etc., and its value
  Widget _regularContainer(double height, Widget child){
    return Builder(
        builder: (context){
          return Container(
            height: height,
            width: (MediaQuery.of(context).size.width - 40) * 0.4,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                color: Colors.white
            ),
            child: child,
          );
        }
    );
  }

  // Container for condition (Good/Replace) and health indicator.
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
            child: Center(child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold),)),
          );
        }
    );
  }
}