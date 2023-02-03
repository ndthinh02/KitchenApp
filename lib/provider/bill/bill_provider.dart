import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/cupertino.dart';

import '../../config/api_key.dart';
import '../../model/bill_model.dart';
import '../../model/product_model.dart';

class BillProvider extends DioForNative with ChangeNotifier {
  Future<List<BillModel>?> getBillDone() async {
    try {
      final resp = await get(AppKey.urlGetBill);
      var getDataBill = resp.data as List;
      return getDataBill
          .map((e) => BillModel.fromJson(e))
          .where((element) => element.status == 1)
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<BillModel?> getBillById(String idBill) async {
    try {
      final resp = await get(
          "https://restaurant-server-eight.vercel.app/restaurant/api/bill?id=$idBill");
      return BillModel.fromJson(resp.data);
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<BillModel>?> getAllBill() async {
    try {
      final resp = await get(AppKey.urlGetBill);
      var getDataBill = resp.data as List;
      print('ksnaknknds$getDataBill');
      return getDataBill
          .map((e) => BillModel.fromJson(e))
          .where((element) => element.status == 1 || element.status == 0)
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<BillModel>?> getBillNotDone() async {
    try {
      final resp = await get(AppKey.urlGetBill);
      var getDataBill = resp.data as List;
      return getDataBill
          .map((e) => BillModel.fromJson(e))
          .where((element) => element.status == 0)
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<BillModel?> updateStatusBill(String? id) async {
    BillModel? updatedBill;

    var data = {"status": 1};
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

  Future<BillModel?> updateStatusFoodInBill(
      String? idBill, String? idProduct) async {
    BillModel? updatedBill;

    var data = {"status": 1};
    try {
      final resp = await put(
          "https://restaurant-server-eight.vercel.app/restaurant/api/bill/update/product/$idBill/$idProduct",
          data: data);

      updatedBill = BillModel.fromJson(resp.data);
    } on DioError catch (e) {
      e.message;
    }
    return updatedBill;
  }

  // ======================   QUANTITY PRODUCT ===================================//
  Future<ProductModel?> updateQuantityProduct(String id, num total) async {
    var data = {"total": total};
    ProductModel? productModel;
    try {
      final resp = await put(
          'https://restaurant-server-eight.vercel.app/restaurant/api/products/$id?_method=PUT',
          data: data,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }));

      return ProductModel.fromJson(resp.data);
    } on DioError catch (e) {
      print(e.error);
    }
    return productModel;
  }
}
