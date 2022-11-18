import 'package:flutter/cupertino.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';

class BillController extends ChangeNotifier {
  List<BillModel>? listBillModel;
  final ProductProvider productProvider;
  BillController({required this.productProvider});
  bool isLoading = true;

  Future loadBill() async {
    isLoading = true;
    listBillModel = await productProvider.getBill();
    isLoading = false;
    print(listBillModel);
    notifyListeners();
  }
}
