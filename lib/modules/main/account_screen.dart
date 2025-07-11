import 'package:flutter/material.dart';
import 'package:school_application/models/user_model.dart';
import 'package:school_application/shared/components/components.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: myLime, toolbarHeight: 3),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: myLime,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(-3, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Center(
                  child: Icon(Icons.account_circle, size: 140, color: myGreen),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    ghaith.firstName + ' ' + ghaith.lastName,
                    style: headerTextStyle,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(height: 15),
          dataField(fieldName: 'First Name', data: ghaith.firstName),
          SizedBox(height: 15),
          Center(child: Container(width: 300, height: 1.3, color: myGray)),
          SizedBox(height: 15),
          dataField(fieldName: 'Last Name', data: ghaith.lastName),
          SizedBox(height: 15),
          Center(child: Container(width: 300, height: 1.3, color: myGray)),
          SizedBox(height: 15),
          dataField(
            fieldName: 'Student Phone Number',
            data: ghaith.studentNumber,
          ),
          SizedBox(height: 15),
          Center(child: Container(width: 300, height: 1.3, color: myGray)),
          SizedBox(height: 15),
          dataField(fieldName: 'Parrent Name', data: ghaith.parentName),
          SizedBox(height: 15),
          Center(child: Container(width: 300, height: 1.3, color: myGray)),
          SizedBox(height: 15),
          dataField(
            fieldName: 'Parrent phone number',
            data: ghaith.parentNumber,
          ),
          SizedBox(height: 15),
          Center(child: Container(width: 300, height: 1.3, color: myGray)),
        ],
      ),
    );
  }
}
