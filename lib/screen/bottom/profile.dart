import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/staff_controller.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/user.dart';
import '../../ui/color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  StaffController get staffController => context.read<StaffController>();
  String name = "";
  String account = "";
  String phoneNumber = "";
  int? gender;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );
  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Hãy kiểm tra kết nối internet của bạn '),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  getInfoUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('name')!;
      account = pref.getString('account')!;
      phoneNumber = pref.getString("phone")!;
      gender = pref.getInt("gender")!;
      // print('dssamjdnsajd$gender');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    getInfoUser();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Cá nhân'),
          backgroundColor: colorMain,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Image.asset("images/logomoi.png")),
              const SizedBox(
                height: 20,
              ),
              Text(
                account,
                style: MyTextStyle().textSub,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Nhà bếp',
                style: MyTextStyle().textSub,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      color: colorInput,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: const Text('Tên bếp trưởng '),
                        trailing: Text(name),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      color: colorInput,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: ListTile(
                        leading: const Icon(Icons.male),
                        title: const Text('Giới tính  '),
                        trailing:
                            gender == 0 ? const Text("Nam") : const Text('Nữ'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      color: colorInput,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: ListTile(
                        leading: const Icon(Icons.phone_android),
                        title: const Text('Số điện thoại '),
                        trailing: Text(phoneNumber),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          User().logout(context);
                        },
                        child: const Text("Đăng xuất"))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
