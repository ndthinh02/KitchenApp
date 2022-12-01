import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/provider/bill/bill_provider.dart';

class BillController extends ChangeNotifier {
  List<BillModel>? listBillModel;
  final BillProvider billProvider;
  BillController({required this.billProvider});
  bool isLoading = true;
  BillModel? billModels;

  Future loadBill() async {
    isLoading = true;
    listBillModel = await billProvider.getBill();
    isLoading = false;
    notifyListeners();
  }

  Future updateBill(String? id, int status, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    isLoading = true;
    billModels = await billProvider
        .updateStatusBill(id, status)
        .whenComplete(() => Navigator.of(context).pop());
    isLoading = false;

    notifyListeners();
  }
}
