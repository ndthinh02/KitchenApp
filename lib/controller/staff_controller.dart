import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/staff.dart';
import 'package:flutter_app_kitchen/provider/staff/staff_provider.dart';

class StaffController extends ChangeNotifier {
  Staff? mListStaff;
  final StaffProvider staffProvider;
  StaffController({required this.staffProvider});
  bool isLoading = true;
  List<Staff>? _listStaff;

  Future loadStaff(String account, String pass, String tokenFCM,
      BuildContext context) async {
    isLoading = true;
    mListStaff =
        await staffProvider.loginStaff(account, pass, tokenFCM, context);
    isLoading = false;
    notifyListeners();
  }

  // Future getStaff(String account, String pass, String tokenFCM,
  //     BuildContext context) async {
  //   isLoading = true;
  //   mListStaff =
  //       await staffProvider.loginStaff(account, pass, tokenFCM, context);
  //   isLoading = false;
  //   notifyListeners();
  // }
}
