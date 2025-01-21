class DeductRechargeAmountModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  DeductRechargeAmountModel(
      {this.success, this.statusCode, this.message, this.data});

  DeductRechargeAmountModel.fromJson(Map<String, dynamic> json) {
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
  RechargeRecord? rechargeRecord;

  Data({this.rechargeRecord});

  Data.fromJson(Map<String, dynamic> json) {
    rechargeRecord = json['rechargeRecord'] != null
        ? RechargeRecord.fromJson(json['rechargeRecord'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rechargeRecord != null) {
      data['rechargeRecord'] = rechargeRecord!.toJson();
    }
    return data;
  }
}

class RechargeRecord {
  String? sId;
  String? userId;
  int? rechargeAmount;
  int? usedAmount;
  int? remainingAmount;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RechargeRecord(
      {this.sId,
      this.userId,
      this.rechargeAmount,
      this.usedAmount,
      this.remainingAmount,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RechargeRecord.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    rechargeAmount = json['rechargeAmount'];
    usedAmount = json['usedAmount'];
    remainingAmount = json['remainingAmount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['rechargeAmount'] = rechargeAmount;
    data['usedAmount'] = usedAmount;
    data['remainingAmount'] = remainingAmount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
