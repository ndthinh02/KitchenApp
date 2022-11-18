import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_kitchen/config/api_key.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';

class ProductProvider extends DioForNative {
  Future<List<ProductModel>?> getProduct() async {
    try {
      final response = await get(AppKey.urlGetAllProduct);
      var getDataProduct = response.data as List;
      var listProduct =
          getDataProduct.map((e) => ProductModel.fromJson(e)).toList();

      return listProduct;
    } on DioError catch (e) {
      print('getProdct:${e.message}');
    }
  }

  Future<List<BillModel>?> getBill() async {
    try {
      final resp = await get(AppKey.urlGetBill);
      var getDataBill = resp.data as List;
      return getDataBill.map((e) => BillModel.fromJson(e)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
