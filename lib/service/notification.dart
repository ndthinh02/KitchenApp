import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_app_kitchen/config/api_key.dart';

class NotificationKitChen extends DioForNative {
  Future pushNotification(String body) async {
    var data = {
      "registration_ids": [
        "dTKEeNa0QdOK-m0_NROzsl:APA91bHya_ttWelcBJUKidukxlU0ocK-pHbh9eaWJ8mj81BqV6c00A55RVxSr9fuH4itQmwZHYsSoAPXDggDHS9ONs7NcHAoi0ovverLzX26CaKC4aFSMg3KqEZZ8kwCkvUgWXD8vXQ_",
      ],
      "notification": {
        "body": body,
        "title": "Thông báo",
        "android_channel_id": "",
        "sound": true
      }
    };
    try {
      final resp = await post('https://fcm.googleapis.com/fcm/send',
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
}
