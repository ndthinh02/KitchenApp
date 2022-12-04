import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/provider/create_route.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/api_key.dart';
import '../../model/staff.dart';

class StaffProvider extends DioForNative {
  Future<Staff?> getStaff(String account, String password, String tokenFCM,
      BuildContext context) async {
    var data = {"account": account, "password": password, "tokenFCM": tokenFCM};
    try {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      final resp = await post(AppKey.loginStaff,
          data: data,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }));

      if (resp.statusCode == 200) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Đăng nhập thành công", gravity: ToastGravity.TOP);
        Navigator.of(context)
            .pushReplacement(CreateRoute().createAnimationHomePage());
      }
      return Staff.fromJson(resp.data);
    } on DioError catch (e) {
      Navigator.of(context).pop();
      if (e.response!.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Sai tên tài khoản hoặc mật khẩu", gravity: ToastGravity.TOP);
      }
    }
    return null;
  }
}
