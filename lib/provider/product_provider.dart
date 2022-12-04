import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_app_kitchen/config/api_key.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';

class ProductProvider extends DioForNative {
  final List<ProductModel> _allProduct = [];
  Future<List<ProductModel>?> getProduct() async {
    try {
      final response = await get(AppKey.urlGetAllProduct);
      var allProduct = response.data as List;
      // print('dmsakdmsk$allProduct');
      return allProduct.map((e) => ProductModel.fromJson(e)).toList();
    } on DioError catch (e) {
      print('getProdct:${e.message}');
    }
    return null;
  }

  Future<List<ProductModel>?> getProductInStock() async {
    try {
      final response = await get(AppKey.urlGetAllProduct);
      var getDataProduct = response.data as List;
      return getDataProduct
          .map((e) => ProductModel.fromJson(e))
          .where((element) => element.total! > 0)
          .toList();
    } on DioError catch (e) {
      print('getProdct:${e.message}');
    }
    return null;
  }

  Future<List<ProductModel>?> getProdcutOutOfStock() async {
    try {
      final response = await get(AppKey.urlGetAllProduct);
      var getDataProduct = response.data as List;
      return getDataProduct
          .map((e) => ProductModel.fromJson(e))
          .where((element) => element.total! == 0)
          .toList();
    } on DioError catch (e) {
      print('getProdct:${e.message}');
    }
    return null;
  }

  Future<ProductModel?> addProduct(String name, String price, String total,
      int type, String urlImage) async {
    var formData = {
      "name": name,
      "urlImage": urlImage,
      "type": type,
      "total": total,
      "price": price,
    };
    ProductModel? addProduct;
    try {
      final resp = await post(AppKey.addProductUrl,
          data: formData,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }));

      addProduct = ProductModel.fromJson(resp.data);
    } on DioError catch (e) {
      e.message;
    }
    return addProduct;
  }

  Future<void> deleteProduct(String id) async {
    try {
      final resp = await delete(
          "https://restaurant-server-eight.vercel.app/restaurant/api/products/$id?_method=DELETE");
    } on DioError catch (e) {
      e.message;
    }
  }

  Future<ProductModel?> updateProduct(String id, String name, String price,
      String total, String urlImage) async {
    ProductModel? updateProduct;
    var data = {
      "name": name,
      "urlImage": urlImage,
      "type": 1,
      "total": total,
      "price": price,
    };
    try {
      final resp = await put(
          "https://restaurant-server-eight.vercel.app/restaurant/api/products/$id?_method=PUT",
          data: data);
      print('heheh$resp');
      updateProduct = ProductModel.fromJson(resp.data);
    } on DioError catch (e) {
      print('errog update product ${e.error}');
    }
    return updateProduct!;
  }
}
