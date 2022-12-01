import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/cupertino.dart';

import '../../config/api_key.dart';
import '../../model/bill_model.dart';

class BillProvider extends DioForNative with ChangeNotifier {
  Future<List<BillModel>?> getBill() async {
    try {
      final resp = await get(AppKey.urlGetBill);
      var getDataBill = resp.data as List;
      return getDataBill.map((e) => BillModel.fromJson(e)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<BillModel?> updateStatusBill(String? id, int status) async {
    BillModel? updatedBill;

    var data = {"status": status};
    try {
      final resp = await put(
          "https://restaurant-server-eight.vercel.app/restaurant/api/bill/update/$id?_method=PUT",
          data: data);

      updatedBill = BillModel.fromJson(resp.data);
    } on DioError catch (e) {
      e.message;
    }
    return updatedBill;
  }
}
