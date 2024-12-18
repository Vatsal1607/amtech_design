class UserRechargeModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  UserRechargeModel({this.success, this.statusCode, this.message, this.data});

  UserRechargeModel.fromJson(Map<String, dynamic> json) {
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
  String? razorpayOrderId;
  int? amount;
  String? currency;
  String? keyId;
  String? userId;

  Data(
      {this.razorpayOrderId,
      this.amount,
      this.currency,
      this.keyId,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    razorpayOrderId = json['razorpayOrderId'];
    amount = json['amount'];
    currency = json['currency'];
    keyId = json['key_id'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['razorpayOrderId'] = razorpayOrderId;
    data['amount'] = amount;
    data['currency'] = currency;
    data['key_id'] = keyId;
    data['userId'] = userId;
    return data;
  }
}
