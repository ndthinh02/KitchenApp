import 'package:flutter/cupertino.dart';

class BillModel extends ChangeNotifier {
  String? sId;
  String? date;
  String? time;
  num? totalPrice;
  num? status;
  num? checkoutType;
  List<Foods>? foods;
  TableBill? table;
  Staff? staff;
  String? createdAt;
  String? updatedAt;
  num? iV;
  bool isDone = false;
  void isToogleDone() {
    isDone = !isDone;
    print('ndsajndjsndj$isDone');
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
      this.staff,
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
    table = json['table'] != null ? TableBill.fromJson(json['table']) : null;
    staff = json['staff'] != null ? Staff.fromJson(json['staff']) : null;
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
    if (staff != null) {
      data['staff'] = staff!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Foods extends ChangeNotifier {
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
  num? status;
  bool? change;

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
      this.updatedAt,
      this.status,
      this.change = false});

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
    status = json['status'];
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
    data['status'] = status;
    return data;
  }
}

class TableBill {
  String? name;
  num? capacity;
  num? floor;
  num? status;
  String? sId;
  String? createdAt;
  String? updatedAt;

  TableBill(
      {this.name,
      this.capacity,
      this.floor,
      this.status,
      this.sId,
      this.createdAt,
      this.updatedAt});

  TableBill.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    capacity = json['capacity'];
    floor = json['floor'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['capacity'] = capacity;
    data['floor'] = floor;
    data['status'] = status;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Staff {
  String? account;
  String? password;
  String? name;
  String? phoneNumber;
  num? gender;
  num? role;
  Floor? floor;
  String? tokenFCM;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Staff(
      {this.account,
      this.password,
      this.name,
      this.phoneNumber,
      this.gender,
      this.role,
      this.floor,
      this.tokenFCM,
      this.sId,
      this.createdAt,
      this.updatedAt});

  Staff.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    password = json['password'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    role = json['role'];
    floor = json['floor'] != null ? Floor.fromJson(json['floor']) : null;
    tokenFCM = json['tokenFCM'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account'] = account;
    data['password'] = password;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;
    data['role'] = role;
    if (floor != null) {
      data['floor'] = floor!.toJson();
    }
    data['tokenFCM'] = tokenFCM;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Floor {
  int? numberFloor;
  String? sId;

  Floor({this.numberFloor, this.sId});

  Floor.fromJson(Map<String, dynamic> json) {
    numberFloor = json['numberFloor'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numberFloor'] = numberFloor;
    data['_id'] = sId;
    return data;
  }
}
