class PersonalRegisterModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  PersonalRegisterModel(
      {this.success, this.statusCode, this.message, this.data});

  PersonalRegisterModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  int? contact;
  String? role;
  bool? isActive;
  bool? isDelete;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.contact,
      this.role,
      this.isActive,
      this.isDelete,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    gender = json['gender'];
    contact = json['contact'];
    role = json['role'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['gender'] = gender;
    data['contact'] = contact;
    data['role'] = role;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
