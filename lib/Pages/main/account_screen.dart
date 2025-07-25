import 'package:flutter/material.dart';
import 'package:school_application/Models/user_model.dart';
import 'package:school_application/Services/user_service.dart';
import 'package:school_application/shared/components/components.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';
import 'package:school_application/main.dart'; // Assuming your globals are here

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: myLime, toolbarHeight: 3),
      body: FutureBuilder<User?>(
        future: UserService.getOne(studentID, token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found'));
          }

          final user = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: myLime,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(-3, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Icon(Icons.account_circle,
                        size: 140,
                        color: myGreen,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        user.name,
                        style: flexableTextStyle(size: 25, color: Colors.black, isBold: true),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              dataField(fieldName: 'Email', data: user.email),
              const SizedBox(height: 15),
              Center(child: Container(width: 300, height: 1.3, color: myGray)),
              const SizedBox(height: 15),
              dataField(fieldName: 'Phone', data: user.phone),
              const SizedBox(height: 15),
              Center(child: Container(width: 300, height: 1.3, color: myGray)),
              const SizedBox(height: 15),
              dataField(fieldName: 'User ID', data: user.id.toString()),
              const SizedBox(height: 15),
              Center(child: Container(width: 300, height: 1.3, color: myGray)),
            ],
          );
        },
      ),
    );
  }
}