class UserLoginModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  UserLoginModel({this.success, this.statusCode, this.message, this.data});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  String? sId;
  String? businessName;
  String? ownerName;
  String? ocupant;
  List<String>? images;
  int? contact;
  String? address;
  String? buninessType;
  String? role;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User({
    this.sId,
    this.businessName,
    this.ownerName,
    this.ocupant,
    this.images,
    this.contact,
    this.address,
    this.buninessType,
    this.role,
    this.isActive,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessName = json['businessName'];
    ownerName = json['ownerName'];
    ocupant = json['ocupant'];
    images = json['images'] != null
        ? List<String>.from(json['images'])
        : null; // Convert images list to List<String>
    contact = json['contact'];
    address = json['address'];
    buninessType = json['buninessType'];
    role = json['role'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['businessName'] = businessName;
    data['ownerName'] = ownerName;
    data['ocupant'] = ocupant;
    data['images'] = images; // Directly assign the list of strings
    data['contact'] = contact;
    data['address'] = address;
    data['buninessType'] = buninessType;
    data['role'] = role;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
