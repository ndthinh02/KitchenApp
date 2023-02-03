import 'package:flutter/cupertino.dart';

import 'bill_model.dart';

class DoneFood with ChangeNotifier {
  List<Foods>? mListFood;
  final List<Foods> myList = [];
  void addToList(Foods food) {
    myList.add(food);
    print('okokokokok');
    notifyListeners();
  }

  void remove(Foods food) {
    myList.remove(food);
    print('okokokokok');
    notifyListeners();
  }
}
