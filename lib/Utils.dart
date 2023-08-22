import 'package:flutter/material.dart';

/// Pushes a widget to a new route.
Future push(context, widget) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return widget;
      },
    ),
  );
}


double headingFont = 17;

Text customtext(
    {required String title,
      double fontSize = 17,
      String? fontfamily = "Corporate S",
      Color color = Colors.black,
      bool isSingleLine = false,
      FontWeight fontWeight = FontWeight.normal,
      int maxLines = 1}) {
  return Text(
    title,
    maxLines: maxLines,
    style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontfamily,
        color: color,
        overflow: isSingleLine ? TextOverflow.ellipsis : TextOverflow.visible),
  );
}

// custome textfield.....
Widget customTextField(
    {required String hintText,
      required TextEditingController textController,
      bool isPasswordField = false,
      double fontSize = 17,
      Color enabledBorderColor = Colors.white,
      Color focusedBorderColor = Colors.white,
      Color hintColor = Colors.grey,
      double hintFontSize = 17,
      required Function(String) onEnterValue,
      VoidCallback? onTap,
      double? contentPadding,
      VoidCallback? onEditingComplete}) {
  return SizedBox(
    // width: 400,
    height: 40,
    child: TextField(
      onChanged: (value) => onEnterValue(value),
      controller: textController,
      obscureText: isPasswordField,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      style: TextStyle(color: Colors.white, fontSize: fontSize),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(contentPadding ?? 11),
        hintStyle: TextStyle(color: hintColor, fontSize: hintFontSize),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor)),
        hintText: hintText,
      ),
    ),
  );
}

Widget createLabel(
    {required String label, String? labelValue, Color color = Colors.grey}) {
  return Row(
    children: [
      customtext(title: label, color: color.withOpacity(0.5)),
      const SizedBox(width: 15),
      customtext(title: labelValue ?? "", color: color),
    ],
  );
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.icon, this.toolTip, required this.onTap});
  final String icon;
  final String? toolTip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: IconButton(
        icon: Image.asset(icon),
        tooltip: toolTip,
        onPressed: () {
          onTap();
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text('This is a snackbar')));
        },
      ),
    );
  }
}
