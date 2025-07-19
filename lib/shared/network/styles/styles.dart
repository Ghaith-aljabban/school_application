import 'package:flutter/material.dart';
import 'package:school_application/shared/network/styles/colors.dart';

TextStyle headerTextStyle = TextStyle(
  fontSize: 35,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);
TextStyle greenHTextStyle = TextStyle(
  fontSize: 30,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
  color: myGreen,
);
TextStyle paragraphTextStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.normal,
);
TextStyle boxesTextStyle = TextStyle(
  fontSize: 25,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.normal,
);
TextStyle hintTextStyle = TextStyle(
  fontSize: 15,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.normal,
  color: myGray,
);

TextStyle flexableTextStyle({
  required double size,
  required Color color,
  required bool isBold,
}) => TextStyle(
  fontSize: size,
  fontFamily: 'Montserrat',
  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  color: color,
);

BoxDecoration defaultBoxDecorated = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  color: myGreen,
);
BoxDecoration defaultBoxDecorated2 = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  color: myLime,
);
