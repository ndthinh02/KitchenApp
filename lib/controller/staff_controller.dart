import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/model/staff.dart';
import 'package:flutter_app_kitchen/provider/staff/staff_provider.dart';

class StaffController extends ChangeNotifier {
  Staff? mListStaff;
  final StaffProvider staffProvider;
  StaffController({required this.staffProvider});
  bool isLoading = true;

  Future loadStaff(String account, String pass, String tokenFCM,
      BuildContext context) async {
    isLoading = true;
    mListStaff = await staffProvider.getStaff(account, pass, tokenFCM, context);
    print('hehehe $mListStaff');
    isLoading = false;
    notifyListeners();
  }

  // String get passStaff {
  //   String pass = '';
  //   mListStaff?.forEach((element) {
  //     pass = element.password!;
  //     print('nameStaff${name}');
  //   });
  //   return pass;
  // }
}
