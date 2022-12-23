import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/screen/login_page.dart';
import 'package:flutter_app_kitchen/screen/my_bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  autoLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? account = pref.getString('account');

    if (account == null) {
      return const LoginPage();
    } else {
      return const MyHomePage();
    }
  }

  checkLogin() {
    return FutureBuilder(
        future: autoLogin(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return const LoginPage();
          }
        });
  }

  logout(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('account');
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => const LoginPage()));
  }
}
