class RechargeHistoryModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  RechargeHistoryModel(
      {this.success, this.statusCode, this.message, this.data});

  RechargeHistoryModel.fromJson(Map<String, dynamic> json) {
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
  int? totalAmount;
  int? closingBalance;
  int? totalPerks;
  List<PaymentHistory>? paymentHistory;

  Data(
      {this.totalAmount,
      this.closingBalance,
      this.totalPerks,
      this.paymentHistory});

  Data.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    closingBalance = json['closingBalance'];
    totalPerks = json['totalPerks'];
    if (json['paymentHistory'] != null) {
      paymentHistory = <PaymentHistory>[];
      json['paymentHistory'].forEach((v) {
        paymentHistory!.add(PaymentHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAmount'] = totalAmount;
    data['closingBalance'] = closingBalance;
    data['totalPerks'] = totalPerks;
    if (paymentHistory != null) {
      data['paymentHistory'] = paymentHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentHistory {
  String? sId;
  String? userId;
  int? rechargeAmount;
  int? perks;
  String? transactionDate;
  int? iV;

  PaymentHistory(
      {this.sId,
      this.userId,
      this.rechargeAmount,
      this.perks,
      this.transactionDate,
      this.iV});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    rechargeAmount = json['rechargeAmount'];
    perks = json['perks'];
    transactionDate = json['transactionDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['rechargeAmount'] = rechargeAmount;
    data['perks'] = perks;
    data['transactionDate'] = transactionDate;
    data['__v'] = iV;
    return data;
  }
}
