import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_app_kitchen/config/api_key.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';

class ProductProvider extends DioForNative {
  Future<List<ProductModel>?> getProduct() async {
    try {
      final response = await get(AppKey.urlGetAllProduct);
      var getDataProduct = response.data as List;
      return getDataProduct.map((e) => ProductModel.fromJson(e)).toList();
    } on DioError catch (e) {
      print('getProdct:${e.message}');
    }
    return null;
  }

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

  Future<List<ProductModel>?> getProductInStock() async {
    try {
      final response = await get(AppKey.urlGetAllProduct);
      var getDataProduct = response.data as List;
      return getDataProduct
          .map((e) => ProductModel.fromJson(e))
          .where((element) => element.total! % 2 == 0)
          .toList();
    } on DioError catch (e) {
      print('getProdct:${e.message}');
    }
    return null;
  }
}
