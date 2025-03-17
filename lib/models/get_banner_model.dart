class GetBennerModel {
  bool? success;
  int? statusCode;
  String? message;
  List<BannersData>? data;

  GetBennerModel({this.success, this.statusCode, this.message, this.data});

  GetBennerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BannersData>[];
      json['data'].forEach((v) {
        data!.add(BannersData.fromJson(v));
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

class BannersData {
  String? sId;
  List<String>? imageUrl;
  String? createdAt;
  int? iV;
  String? activity;
  String? targetLink;
  String? updatedAt;
  int? click;
  String? scheduleTime;

  BannersData(
      {this.sId,
      this.imageUrl,
      this.createdAt,
      this.iV,
      this.activity,
      this.targetLink,
      this.updatedAt,
      this.click,
      this.scheduleTime});

  BannersData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    imageUrl = json['imageUrl'].cast<String>();
    createdAt = json['createdAt'];
    iV = json['__v'];
    activity = json['activity'];
    targetLink = json['targetLink'];
    updatedAt = json['updatedAt'];
    click = json['click'];
    scheduleTime = json['scheduleTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['imageUrl'] = imageUrl;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['activity'] = activity;
    data['targetLink'] = targetLink;
    data['updatedAt'] = updatedAt;
    data['click'] = click;
    data['scheduleTime'] = scheduleTime;
    return data;
  }
}
