import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/controller/staff_controller.dart';
import 'package:flutter_app_kitchen/ui/text_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  final TextEditingController textUserNameController = TextEditingController();
  final TextEditingController textPasstroller = TextEditingController();
  StaffController get readStaff => context.read<StaffController>();
  bool isShowPass = true;
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
  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  String tokenFCM = "";
  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    tokenFCM = token.toString();
    RemoteMessage remoteMessage;
    print("Token Value $tokenFCM");
  }

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();

    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage('images/unsplash.png')),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Text(
              'Đăng nhập',
              style: MyTextStyle().textLogin,
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  TextFormField(
                      style: MyTextStyle().textUsername,
                      controller: textUserNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          fillColor: Colors.black.withOpacity(0.8),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: "Tài khoản",
                          hintStyle: MyTextStyle().textUsername,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40)))),
                  const SizedBox(height: 30),
                  TextFormField(
                      style: MyTextStyle().textUsername,
                      obscureText: isShowPass,
                      controller: textPasstroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isShowPass = !isShowPass;
                              });
                            },
                            icon: Icon(
                              isShowPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                          fillColor: Colors.black.withOpacity(0.8),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: "Mật khẩu",
                          hintStyle: MyTextStyle().textUsername,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40)))),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Consumer<StaffController>(builder: ((context, provider, child) {
              return SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          backgroundColor: Colors.white,
                          elevation: 5),
                      onPressed: () async {
                        if (textPasstroller.text.isEmpty ||
                            textUserNameController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Bạn cần nhập đầy đủ",
                              gravity: ToastGravity.TOP);
                        } else {
                          final SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString(
                              "account", textUserNameController.text);
                          pref.setString("password", textPasstroller.text);
                          pref.setString("tokenFCM", tokenFCM);
                          provider.loadStaff(textUserNameController.text,
                              textPasstroller.text, tokenFCM, context);
                        }
                      },
                      child: Text(
                        'Đăng nhập',
                        style: MyTextStyle().textUsername,
                      )));
            }))
          ],
        ),
      ),
    ));
  }
}
