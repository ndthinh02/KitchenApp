import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/provider/create_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api_key.dart';
import '../../model/staff.dart';

class StaffProvider extends DioForNative {
  Future<Staff?> loginStaff(String account, String password, String tokenFCM,
      BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
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
      pref.setString('account', resp.data['account']);
      pref.setString('name', resp.data['name']);
      pref.setInt('gender', resp.data['gender']);
      pref.setString('phone', resp.data['phoneNumber']);
      pref.setString('password', resp.data['password']);
      pref.setInt('role', resp.data['role']);
      pref.setString('tokenFCM', resp.data['tokenFCM']);
      pref.setString('id', resp.data['_id']);

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

  Future<List<Staff>?> getStaff() async {
    try {
      final resp = await get(AppKey.getStaff);
      var getData = resp.data as List;
      print('dsndjsnd${getData.length}');
      return getData.map((e) => Staff.fromJson(e)).toList();
    } on DioError catch (e) {
      e.message;
    }
    return null;
  }
}
