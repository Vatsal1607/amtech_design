class StoreStatusModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  StoreStatusModel({this.success, this.statusCode, this.message, this.data});

  StoreStatusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? username;
  String? address;
  int? contact;
  String? password;
  String? role;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.username,
      this.address,
      this.contact,
      this.password,
      this.role,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    address = json['address'];
    contact = json['contact'];
    password = json['password'];
    role = json['role'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['address'] = address;
    data['contact'] = contact;
    data['password'] = password;
    data['role'] = role;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
