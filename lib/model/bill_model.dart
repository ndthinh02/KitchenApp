import 'package:flutter/cupertino.dart';

class BillModel extends ChangeNotifier {
  String? sId;
  String? date;
  String? time;
  num? totalPrice;
  num? status;
  num? checkoutType;
  List<Foods>? foods;
  Table? table;
  String? idCustomer;
  String? idStaff;
  String? createdAt;
  String? updatedAt;
  num? iV;
  bool isDone = false;

  void isToogleDone() {
    isDone = !isDone;
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
      this.table,
      this.idCustomer,
      this.idStaff,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isDone = false});

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
    table = json['table'] != null ? Table.fromJson(json['table']) : null;
    idCustomer = json['idCustomer'];
    idStaff = json['idStaff'];
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
    if (table != null) {
      data['table'] = table!.toJson();
    }
    data['idCustomer'] = idCustomer;
    data['idStaff'] = idStaff;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Foods {
  String? name;
  String? urlImage;
  num? type;
  num? total;
  num? price;
  num? amount;
  num? idCategory;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Foods(
      {this.name,
      this.urlImage,
      this.type,
      this.total,
      this.price,
      this.amount,
      this.idCategory,
      this.sId,
      this.createdAt,
      this.updatedAt});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    urlImage = json['urlImage'];
    type = json['type'];
    total = json['total'];
    price = json['price'];
    amount = json['amount'];
    idCategory = json['idCategory'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['urlImage'] = urlImage;
    data['type'] = type;
    data['total'] = total;
    data['price'] = price;
    data['amount'] = amount;
    data['idCategory'] = idCategory;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Table {
  String? name;
  num? capacity;
  num? status;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Table(
      {this.name,
      this.capacity,
      this.status,
      this.sId,
      this.createdAt,
      this.updatedAt});

  Table.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    capacity = json['capacity'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['capacity'] = capacity;
    data['status'] = status;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
