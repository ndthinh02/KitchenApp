import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 40, left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: List.generate(
          10,
          (index) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 8,
              child: ListTile(
                title: Text('Thông báo'),
                leading: Icon(
                  Icons.notifications,
                  color: Colors.amber,
                ),
                subtitle: Text('Notification'),
              ),
            ),
          ),
        )),
      ),
    ));
  }
}
