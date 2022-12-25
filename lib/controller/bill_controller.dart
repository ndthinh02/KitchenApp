import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/bill_model.dart';
import 'package:flutter_app_kitchen/provider/bill/bill_provider.dart';
import 'package:flutter_app_kitchen/ui/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/notification.dart';

class BillController extends ChangeNotifier {
  List<BillModel>? listBillModel;
  final BillProvider? billProvider;
  BillController({required this.billProvider});
  bool isLoading = true;
  BillModel? billModels;
  TableBill? tableBill;
  List<BillModel>? listAllBill;

  List<BillModel>? listBillIsNotDone;
  late List<BillModel>? listBillFloor1 = listAllBill;

  // late List<BillModel>? listSearchBill = listAllBill;

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
    print('hhehe$listBillIsNotDone()');
    notifyListeners();
  }

  Future loadBillFloor1() async {
    isLoading = true;
    listAllBill =
        listBillFloor1!.where((bill) => bill.table!.floor == 1).toList();
    isLoading = false;
    notifyListeners();
  }

  Future updateQuantity() async {}
  Future loadBillFloor2() async {
    isLoading = true;
    listAllBill =
        listBillFloor1!.where((bill) => bill.table!.floor == 2).toList();
    isLoading = false;
    notifyListeners();
  }

  Future loadBillFloor3() async {
    isLoading = true;
    listAllBill =
        listBillFloor1!.where((bill) => bill.table!.floor == 3).toList();
    isLoading = false;
    notifyListeners();
  }

  Future loadBillById(String idBill) async {
    billModels = await billProvider!.getBillById(idBill);
    print('msksm${billModels!.table!.name}');
    notifyListeners();
  }

  Future loadAllBill() async {
    isLoading = true;
    listAllBill = await billProvider?.getAllBill();
    isLoading = false;
    notifyListeners();
  }

  void searchByTable(String text) {
    if (text.isEmpty) {
      listAllBill = listBillFloor1;
      notifyListeners();
    } else {
      listAllBill = listBillFloor1!
          .where((bill) =>
              bill.table!.name!.toLowerCase().contains(text.toLowerCase()))
          .toList();

      notifyListeners();
    }
  }

  Future updateBill(
    String? id,
    BuildContext context,
    int index,
    String idTable,
    String tokenFcm,
    String idBill,
    String floor,
    String nameTable,
    String idStaff,
    Staff receiver,
  ) async {
    String idReceive = "";
    SharedPreferences pref = await SharedPreferences.getInstance();
    idReceive = pref.getString("id")!;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: 'Thông báo',
            description: 'Bạn có muốn hoàn thành đơn này ?',
            actionYes: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              billModels = await billProvider!
                  .updateStatusBill(id)
                  .whenComplete(() => Navigator.of(context).pop())
                  .whenComplete(() => Navigator.of(context).pop())
                  .whenComplete(() => NotificationKitChen().pushNotification(
                      "Đơn  $nameTable tầng $floor đã xong",
                      tokenFcm,
                      idBill,
                      "Thông báo",
                      idStaff))
                  .whenComplete(() => NotificationKitChen().postNotification(
                      "Thông báo",
                      "Đơn  $nameTable tầng $floor đã xong",
                      idStaff,
                      idBill,
                      receiver))
                  .whenComplete(() => listBillIsNotDone!.removeAt(index));
              notifyListeners();
            },
            actionNo: () {
              Navigator.of(context).pop();
            },
          );
        });

    // tableBill = await billProvider!.updateStatusTable(idTable);
    notifyListeners();
  }
}
