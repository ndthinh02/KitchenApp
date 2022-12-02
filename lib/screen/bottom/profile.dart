import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/staff_controller.dart';
import 'package:provider/provider.dart';

import '../../controller/notification.dart';
import '../../ui/color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final StaffController staffController = Provider.of(context);
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cá nhân'),
        backgroundColor: colorMain,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                NotificationKitChen().pushNotification(controller.text);
              },
              child: const Text('data'),
            ),
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'San pham'),
            )
            // Text(staffController.nameStaff)
          ],
        ),
      ),
    );
  }
}
