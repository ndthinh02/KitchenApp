import 'package:flutter/cupertino.dart';
import 'package:flutter_app_kitchen/model/product_model.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductController extends ChangeNotifier {
  final ProductProvider? productProvider;
  ProductController({required this.productProvider});
  bool isLoading = true;
  List<ProductModel>? mListProduct;

  Future loadProductAll() async {
    isLoading = true;
    mListProduct = await productProvider?.getProduct();
    isLoading = false;
    print('dlmsadksam${mListProduct!.length}');
    Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        msg: 'Sản phẩm có màu xanh sẽ còn, còn màu đỏ là hết hàng ! ');
    notifyListeners();
  }

  getProductInStock() async {
    List<ProductModel>? newProduct = [];
    newProduct = await productProvider?.getProductInStock();

    print('heeheheh${newProduct!.length}');
  }

  getProductOutOfStock() {}
}
