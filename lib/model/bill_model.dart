import 'package:flutter/cupertino.dart';

class BillModel extends ChangeNotifier {
  String? sId;
  String? date;
  String? time;
  num? totalPrice;
  num? status;
  int? checkoutType;
  List<Foods>? foods;
  String? idTable;
  String? idCustomer;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool isDone = false;
  int? statusBill;

  void isToogleDone() {
    isDone = !isDone;
    setStatus();
    notifyListeners();
  }

  void setStatus() {
    isDone ? statusBill = 0 : statusBill = 1;
    print('heheheh$statusBill');
    notifyListeners();
  }

  BillModel(
      {this.sId,
      this.date,
      this.time,
      this.totalPrice,
      this.status,
      this.checkoutType,
      this.foods,
      this.idTable,
      this.idCustomer,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BillModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    time = json['time'];
    totalPrice = json['totalPrice'];
    status = json['status'];
    checkoutType = json['checkoutType'];
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(Foods.fromJson(v));
      });
    }
    idTable = json['idTable'];
    idCustomer = json['idCustomer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['date'] = date;
    data['time'] = time;
    data['totalPrice'] = totalPrice;
    data['status'] = status;
    data['checkoutType'] = checkoutType;
    if (foods != null) {
      data['foods'] = foods!.map((v) => v.toJson()).toList();
    }
    data['idTable'] = idTable;
    data['idCustomer'] = idCustomer;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Foods {
  String? sId;
  String? id;
  String? name;
  String? urlImage;
  num? price;
  num? total;
  String? createdAt;
  String? updatedAt;

  Foods(
      {this.sId,
      this.id,
      this.name,
      this.urlImage,
      this.price,
      this.total,
      this.createdAt,
      this.updatedAt});

  Foods.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    name = json['name'];
    urlImage = json['urlImage'];
    price = json['price'];
    total = json['total'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['name'] = name;
    data['urlImage'] = urlImage;
    data['price'] = price;
    data['total'] = total;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
