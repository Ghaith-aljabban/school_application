import 'package:flutter/material.dart';
import 'package:school_application/Models/student_behavior.dart';
import 'package:school_application/services/behavior_service.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';
import 'package:school_application/main.dart';

class StudentBehaviorScreen extends StatefulWidget {
  const StudentBehaviorScreen({super.key});

  @override
  State<StudentBehaviorScreen> createState() => _StudentBehaviorScreenState();
}

class _StudentBehaviorScreenState extends State<StudentBehaviorScreen> {
  List<StudentBehavior> behaviors = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _loadBehaviors();
  }

  Future<void> _loadBehaviors() async {
    try {
      final apiBehaviors = await BehaviorService.getUserBehaviors(token);
      
      if (mounted) {
        setState(() {
          behaviors = apiBehaviors.isNotEmpty ? apiBehaviors : studentBehaviors;
          isLoading = false;
          hasError = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          behaviors = studentBehaviors; // Fallback to static data
          isLoading = false;
          hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: GestureDetector(
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.arrow_back_ios_new, color: myGreen, size: 35),
              Text("Student Behavior", style: greenHTextStyle),
            ],
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          if (hasError)
            IconButton(
              icon: Icon(Icons.refresh, color: myGreen),
              onPressed: () {
                setState(() {
                  isLoading = true;
                  hasError = false;
                });
                _loadBehaviors();
              },
            ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: myGreen),
            )
          : behaviors.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No behavior records found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: behaviors.length,
                  itemBuilder: (context, index) {
                    return notificationCard(
                      title: behaviors[index].title,
                      description: behaviors[index].description,
                      color: behaviors[index].color,
                      icon: behaviors[index].icon,
                      date: behaviors[index].date,
                    );
                  },
                ),
    );
  }
}

Widget notificationCard({
  required String title,
  required String description,
  required IconData icon,
  required Color color,
  String? date,
}) => Container(
  height: 90,
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: [
        Container(
          width: 64,
          height: 74,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: color,
          ),
          child: Icon(icon, size: 40, color: Colors.white),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: flexableTextStyle(
                    size: 15,
                    color: color,
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
              if (date != null && date.isNotEmpty)
                Text(
                  'Date: $date',
                  style: flexableTextStyle(
                    size: 10,
                    color: Colors.grey,
                    isBold: false,
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  ),
);
