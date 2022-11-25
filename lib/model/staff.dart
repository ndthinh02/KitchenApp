class Staff {
  String? sId;
  String? name;
  String? phoneNumber;
  int? gender;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? password;
  int? type;

  Staff(
      {this.sId,
      this.name,
      this.phoneNumber,
      this.gender,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.type,
      this.password});

  Staff.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    password = json['password'];
    type = json['type'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['password'] = password;
    data['type'] = type;
    data['__v'] = iV;
    return data;
  }
}
