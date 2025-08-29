import 'package:flutter/material.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';

Widget defaultButton({
  required double width,
  double height = 50,
  required VoidCallback function,
  required String text,
}) => Container(
  width: width,
  height: height,
  decoration: defaultBoxDecorated,
  child: MaterialButton(
    onPressed: function,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    child: Text(
      text,
      style: flexableTextStyle(
        size: 15,
        color: Colors.white,
        isBold: false,
      ), // TextStyle
    ),
  ),
  // MaterialButton
); // Container

Widget defaultcard({
  double width = 250,
  double height = 117,
  required Icon icon,
  required String header,
  required String description,
}) => Container(
  width: width,
  height: height,
  decoration: defaultBoxDecorated2,

  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: [
        SizedBox(
          width: 236, // <-- Add this
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  header,
                  style: flexableTextStyle(
                    size: 22,
                    color: myGreen,
                    isBold: true,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  description,
                  style: flexableTextStyle(
                    size: 13,
                    color: Colors.black,
                    isBold: false,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 80,
          height: 90,
          decoration: defaultBoxDecorated,
          child: icon,
        ),
      ],
    ),
  ),
);

Widget dataField({required String fieldName, required String data}) =>
    Container(
      child: Row(
        children: [
          SizedBox(width: 25),
          Text(
            fieldName + ': ',
            style: flexableTextStyle(color: myGreen, isBold: true, size: 18),
          ),
          Text(
            data,
            style: flexableTextStyle(color: myGray, isBold: false, size: 14),
          ),
        ],
      ),
    );

Widget notificationCard({required String title, required String description}) =>
    Container(
      height: 90,
      decoration: defaultBoxDecorated2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 74,
              decoration: defaultBoxDecorated,
              child: Icon(Icons.school, size: 40, color: Colors.white),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: 236, // <-- Add this
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: flexableTextStyle(
                        size: 20,
                        color: myGreen,
                        isBold: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      description,
                      style: flexableTextStyle(
                        size: 12,
                        color: Colors.black,
                        isBold: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget itemOfList({required String data}) => Container(
  height: 80,
  child: Row(
    children: [
      SizedBox(width: 25),
      Expanded(child: Text(data, style: boxesTextStyle)),
      Container(
        width: 35, // Same as height to maintain circle
        height: 35,
        child: Icon(Icons.arrow_forward_ios, color: Colors.white),
        decoration: BoxDecoration(
          shape: BoxShape.circle, // This makes it circular
          color: myGreen, // Background color
        ),
      ),
      SizedBox(width: 25),
    ],
  ),
);

Widget SubjectWidget({required String name, required IconData icon}) =>
    Container(
      width: 80,
      height: 80,
      decoration: defaultBoxDecorated,
      child: Column(
        children: [
          Expanded(flex: 3, child: Icon(icon, color: Colors.white, size: 90)),
          SizedBox(height: 12),
          Expanded(
            child: Text(
              name,
              style: flexableTextStyle(
                size: 14,
                color: Colors.white,
                isBold: true,
              ),
            ),
          ),
        ],
      ),
    );
