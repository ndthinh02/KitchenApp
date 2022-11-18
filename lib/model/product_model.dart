class ProductModel {
  String? sId;
  String? name;
  String? urlImage;
  int? type;
  int? total;
  num? price;
  int? iV;
  String? updatedAt;
  int? idCategory;

  ProductModel(
      {this.sId,
      this.name,
      this.urlImage,
      this.type,
      this.total,
      this.price,
      this.iV,
      this.updatedAt,
      this.idCategory});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    urlImage = json['urlImage'];
    type = json['type'];
    total = json['total'];
    price = json['price'];
    iV = json['__v'];
    updatedAt = json['updatedAt'];
    idCategory = json['idCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['urlImage'] = this.urlImage;
    data['type'] = this.type;
    data['total'] = this.total;
    data['price'] = this.price;
    data['__v'] = this.iV;
    data['updatedAt'] = this.updatedAt;
    data['idCategory'] = this.idCategory;
    return data;
  }
}
