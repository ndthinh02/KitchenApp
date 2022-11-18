class BillModel {
  String? sId;
  String? date;
  String? time;
  int? totalPrice;
  int? status;
  int? checkoutType;
  List<Foods>? foods;
  String? idTable;
  String? idCustomer;
  String? createdAt;
  String? updatedAt;
  int? iV;

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
        foods!.add(new Foods.fromJson(v));
      });
    }
    idTable = json['idTable'];
    idCustomer = json['idCustomer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['totalPrice'] = this.totalPrice;
    data['status'] = this.status;
    data['checkoutType'] = this.checkoutType;
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    data['idTable'] = this.idTable;
    data['idCustomer'] = this.idCustomer;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Foods {
  String? sId;
  String? id;
  String? name;
  String? urlImage;
  int? price;
  int? total;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['urlImage'] = this.urlImage;
    data['price'] = this.price;
    data['total'] = this.total;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
