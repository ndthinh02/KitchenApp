import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_app_kitchen/config/api_key.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/bill_model.dart';
import '../model/notification.dart';

class NotificationKitChen extends DioForNative {
  Future pushNotification(String title, String tokenFCM, String idBill,
      String content, String idStaff) async {
    var data = {
      "title": title,
      "content": content,
      "idBill": idBill,
      "tokenFCM": tokenFCM,
      "idStaff": idStaff
    };
    try {
      final resp = await post(
          'https://restaurant-server-eight.vercel.app/restaurant/api/bill/notify',
          data: data,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              "Authorization": AppKey.severKeyNotification
            },
          ));
      print('valueeee $resp');
    } on DioError catch (e) {
      e.message;
    }
  }

  Future<Notifications?> postNotification(String title, String content,
      String idSender, String idBill, Staff receiver) async {
    Notifications? notifications;
    DateTime dateTime = DateTime.now();
    String timeFormat = DateFormat.Hm().format(dateTime);
    String dateFormat = DateFormat.yMd().format(dateTime);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String account = pref.getString("account")!;
    String password = pref.getString("password")!;
    String phone = pref.getString("phone")!;
    String tokenFCM = pref.getString("tokenFCM")!;
    String name = pref.getString("name")!;
    String id = pref.getString("id")!;
    int gender = pref.getInt("gender")!;
    int role = pref.getInt("role")!;

    var data = {
      "title": title,
      "content": content,
      "date": dateFormat,
      "time": timeFormat,
      "idBill": idBill,
      "receiver": {
        "account": receiver.account,
        "password": receiver.password,
        "name": receiver.name,
        "phoneNumber": receiver.phoneNumber,
        "gender": receiver.gender,
        "role": receiver.role,
        "tokenFCM": receiver.tokenFCM,
        "_id": receiver.sId,
        "floor": {
          "numberFloor": receiver.floor!.numberFloor,
          "_id": receiver.floor!.sId
        }
      },
      "sender": {
        "account": account,
        "password": password,
        "name": name,
        "phoneNumber": phone,
        "gender": gender,
        "role": role,
        "tokenFCM": tokenFCM,
        "_id": id,
      }
    };

    try {
      final resp = await post(
          "https://restaurant-server-eight.vercel.app/restaurant/api/notification/create",
          data: (data),
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }));
      print('hehe${(data)}');
      notifications = Notifications.fromJson(resp.data);
    } on DioError catch (e) {
      print(e.error);
    }
    return notifications;
  }
}
