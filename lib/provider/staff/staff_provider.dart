import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import '../../config/api_key.dart';
import '../../model/staff.dart';

class StaffProvider extends DioForNative {
  Future<List<Staff>?> getStaff() async {
    try {
      final resp = await get(AppKey.urlGetStaff);
      var getDataStaff = resp.data as List;
      // var json = jsonDecode(getDataStaff.toString());
      // print('hihihi$getDataStaff');

      return getDataStaff
          .map((e) => Staff.fromJson(e))
          .where((element) => element.type == 1)
          .toList();
    } on DioError catch (e) {
      print('error staff ${e.error}');
    }
    return null;
  }
}
