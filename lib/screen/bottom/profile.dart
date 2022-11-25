import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/staff_controller.dart';
import 'package:provider/provider.dart';

import '../../provider/user.dart';
import '../../ui/color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final StaffController staffController = Provider.of(context);
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
                User().logout(context);
              },
              child: const Text('data'),
            ),
            // Text(staffController.nameStaff)
          ],
        ),
      ),
    );
  }
}
