import 'package:flutter/material.dart';
import '../network/styles/colors.dart';
import '../network/styles/styles.dart';

TextFormField buildStudentTFF({
  required TextEditingController controller,
  String hintText = 'Student name',
}) => TextFormField(
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: myLime,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      hintText: hintText,
      hintStyle: hintTextStyle,
    ),
  );


TextFormField buildPasswordTFF({
  required TextEditingController controller,
  required bool obscurePassword,
  required VoidCallback onVisibilityPressed,
  String hintText = 'Password',
}) => TextFormField(
    controller: controller,
    obscureText: obscurePassword,
    decoration: InputDecoration(
      filled: true,
      fillColor: myLime,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      hintText: hintText,
      hintStyle: hintTextStyle,
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword ? Icons.visibility : Icons.visibility_off,
          color: myGray,
        ),
        onPressed: onVisibilityPressed,
      ),
    ),
  );


Widget reportCardButton({
  required double width,
  double height = 26,
  required VoidCallback function,
}) => Container(
  width: width,
  height: height,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    border: Border.all(color: myGreen,width: 2),
    color: Colors.white
  ),
  child: MaterialButton(
    onPressed: function,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    child: Text(
        'Details',
        style:flexableTextStyle(size: 15, color:myGreen, isBold: false) // TextStyle
    ),

  ),
  // MaterialButton
);


Widget defaultReportcard({
  double width = double.infinity,
  double height = 120,
  required String header,
  required String description,
  required String percentage,
  required VoidCallback onPressed,
}) => Container(
    width: width,
    height: height,

    child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                width: 236, // <-- Add this
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(header,
                      style: flexableTextStyle(size: 19, color: myGreen, isBold: true),
                    ),
                    Text(description,
                      style: flexableTextStyle(size: 13, color: myGray, isBold: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 236, // <-- Add this
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(percentage,
                      style: flexableTextStyle(size: 14, color: Colors.black, isBold: false),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    reportCardButton(width: 120, function: onPressed,),
                  ],
                ),
              ),
            ),
          ],
        )

    )
);