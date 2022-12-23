import 'package:flutter/cupertino.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/provider/product_provider.dart';

import '../../model/notification.dart';

class NotificationProvider extends ChangeNotifier {
  List<Notifications>? mList = [];
  List<BillModel> mListBill = [];
  ProductProvider? productProvider;
  NotificationProvider({required this.productProvider});
  bool isLoading = true;
  String idStaff = "";
  Future getNotification(String idStaff) async {
    isLoading = true;
    mList = await productProvider!.getNotification(idStaff);
    isLoading = false;
    notifyListeners();
  }
}
