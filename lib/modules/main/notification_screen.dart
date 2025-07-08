import 'package:flutter/material.dart';
import 'package:school_application/models/notification_model.dart';
import 'package:school_application/shared/components/components.dart';

import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leadingWidth: double.infinity,
        leading: GestureDetector(
          child: Row(
            children: [
              SizedBox(width: 20,),
              Icon(Icons.arrow_back_ios_new,color: myGreen,size: 35,),
              Text("notification",style: greenHTextStyle,)
            ],
          ), // ← Your custom icon
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView.builder(itemCount: ghaithNotification.length,itemBuilder: (context, index){return
          Column(children: [
            notificationCard(title: ghaithNotification[index].title,
                description: ghaithNotification[index].description
            ),
            SizedBox(height: 20,)
        ]);
          }

          ,),
      ),
    );
  }
}
