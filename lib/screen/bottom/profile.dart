import 'package:flutter/material.dart';

import '../../provider/user.dart';
import '../../ui/color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Cá nhân'),
        backgroundColor: colorMain,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                User().logout(context);
              },
              child: const Text('Logout'),
            ),

            // Text(staffController.nameStaff)
          ],
        ),
      ),
    );
  }
}
