import 'package:flutter/cupertino.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';

class ProductController extends ChangeNotifier {
  final ProductProvider? productProvider;
  ProductController({required this.productProvider});
  bool isLoading = true;
  List<ProductModel>? mListProduct;

  Future loadProductAll() async {
    isLoading = true;
    mListProduct = await productProvider?.getProduct();
    isLoading = false;

    notifyListeners();
  }
}
