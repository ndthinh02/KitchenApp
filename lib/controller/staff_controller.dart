import 'package:flutter/cupertino.dart';
import 'package:flutter_app_kitchen/model/staff.dart';
import 'package:flutter_app_kitchen/provider/staff/staff_provider.dart';

class StaffController extends ChangeNotifier {
  List<Staff>? mListStaff;
  final StaffProvider staffProvider;
  StaffController({required this.staffProvider});
  bool isLoading = true;

  Future loadStaff(String name, String pass) async {
    isLoading = true;
    mListStaff = await staffProvider.getStaff();
    isLoading = false;
    notifyListeners();
  }

  String get nameStaff {
    String name = '';

    mListStaff?.forEach((element) {
      name = element.name!;
      // print('dmaksdn${element.}');
    });
    return name;
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
