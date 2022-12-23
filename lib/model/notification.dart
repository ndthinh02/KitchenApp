class Notifications {
  String? sId;
  String? title;
  String? content;
  String? date;
  String? time;
  String? idSender;
  String? idBill;
  String? createdAt;
  String? updatedAt;
  num? iV;

  Notifications(
      {this.sId,
      this.title,
      this.content,
      this.date,
      this.time,
      this.idSender,
      this.idBill,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Notifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
    time = json['time'];
    idSender = json['idSender'];
    idBill = json['idBill'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['content'] = content;
    data['date'] = date;
    data['time'] = time;
    data['idSender'] = idSender;
    data['idBill'] = idBill;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
