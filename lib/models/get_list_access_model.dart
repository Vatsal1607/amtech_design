class GetListAccessModel {
  bool? success;
  int? statusCode;
  String? message;
  List<AccessList>? data;

  GetListAccessModel({this.success, this.statusCode, this.message, this.data});

  GetListAccessModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AccessList>[];
      json['data'].forEach((v) {
        data!.add(AccessList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccessList {
  String? sId;
  String? businessId;
  String? name;
  int? contact;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? otp;
  String? position;

  AccessList(
      {this.sId,
      this.businessId,
      this.name,
      this.contact,
      this.isVerified,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.otp,
      this.position});

  AccessList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessId = json['businessId'];
    name = json['name'];
    contact = json['contact'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    otp = json['otp'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['businessId'] = businessId;
    data['name'] = name;
    data['contact'] = contact;
    data['isVerified'] = isVerified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['otp'] = otp;
    data['position'] = position;
    return data;
  }
}
