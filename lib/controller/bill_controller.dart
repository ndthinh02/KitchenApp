import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/provider/bill/bill_provider.dart';

class BillController extends ChangeNotifier {
  List<BillModel>? listBillModel;
  final BillProvider? billProvider;
  BillController({required this.billProvider});
  bool isLoading = true;
  BillModel? billModels;
  List<BillModel>? listBillIsNotDone;

  Future loadBillDone() async {
    isLoading = true;
    listBillModel = await billProvider?.getBillDone();
    isLoading = false;
    notifyListeners();
  }

  Future loadBillNotDone() async {
    isLoading = true;
    listBillIsNotDone = await billProvider?.getBillNotDone();
    isLoading = false;
    notifyListeners();
  }

  Future updateBill(
      String? id, int status, BuildContext context, int index) async {
    isLoading = true;
    billModels = await billProvider!.updateStatusBill(id, status);
    isLoading = false;
    listBillIsNotDone!.removeAt(index);
    notifyListeners();
  }
}
