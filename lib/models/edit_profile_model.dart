class EditProfileModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  EditProfileModel({this.success, this.statusCode, this.message, this.data});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? businessName;
  String? ownerName;
  int? contact;
  String? email;
  String? address;
  String? buninessType;
  String? role;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? otp;
  String? gst;
  String? profileImage;

  Data({
    this.sId,
    this.businessName,
    this.ownerName,
    this.contact,
    this.email,
    this.address,
    this.buninessType,
    this.role,
    this.isActive,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.otp,
    this.gst,
    this.profileImage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessName = json['businessName'];
    ownerName = json['ownerName'];
    contact = json['contact'];
    email = json['email'];
    address = json['address'];
    buninessType = json['buninessType'];
    role = json['role'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    otp = json['otp'];
    gst = json['gst'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['businessName'] = businessName;
    data['ownerName'] = ownerName;
    data['contact'] = contact;
    data['email'] = email;
    data['address'] = address;
    data['buninessType'] = buninessType;
    data['role'] = role;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['otp'] = otp;
    data['gst'] = gst;
    data['profileImage'] = profileImage;
    return data;
  }
}
