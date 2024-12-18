class VerifyRechargeModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  VerifyRechargeModel({this.success, this.statusCode, this.message, this.data});

  VerifyRechargeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  PaymentHistory? paymentHistory;
  Recharge? recharge;
  Perks? perks;

  Data({this.paymentHistory, this.recharge, this.perks});

  Data.fromJson(Map<String, dynamic> json) {
    paymentHistory = json['paymentHistory'] != null
        ? new PaymentHistory.fromJson(json['paymentHistory'])
        : null;
    recharge = json['recharge'] != null
        ? new Recharge.fromJson(json['recharge'])
        : null;
    perks = json['perks'] != null ? new Perks.fromJson(json['perks']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentHistory != null) {
      data['paymentHistory'] = paymentHistory!.toJson();
    }
    if (recharge != null) {
      data['recharge'] = recharge!.toJson();
    }
    if (perks != null) {
      data['perks'] = perks!.toJson();
    }
    return data;
  }
}

class PaymentHistory {
  String? userId;
  int? rechargeAmount;
  int? perks;
  String? sId;
  String? transactionDate;
  int? iV;

  PaymentHistory(
      {this.userId,
      this.rechargeAmount,
      this.perks,
      this.sId,
      this.transactionDate,
      this.iV});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    rechargeAmount = json['rechargeAmount'];
    perks = json['perks'];
    sId = json['_id'];
    transactionDate = json['transactionDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['rechargeAmount'] = rechargeAmount;
    data['perks'] = perks;
    data['_id'] = sId;
    data['transactionDate'] = transactionDate;
    data['__v'] = iV;
    return data;
  }
}

class Recharge {
  String? userId;
  int? rechargeAmount;
  int? usedAmount;
  int? remainingAmount;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Recharge(
      {this.userId,
      this.rechargeAmount,
      this.usedAmount,
      this.remainingAmount,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Recharge.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    rechargeAmount = json['rechargeAmount'];
    usedAmount = json['usedAmount'];
    remainingAmount = json['remainingAmount'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['rechargeAmount'] = rechargeAmount;
    data['usedAmount'] = usedAmount;
    data['remainingAmount'] = remainingAmount;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Perks {
  String? userId;
  int? points;
  int? usedPoints;
  int? remainingPoints;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Perks(
      {this.userId,
      this.points,
      this.usedPoints,
      this.remainingPoints,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Perks.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    points = json['points'];
    usedPoints = json['usedPoints'];
    remainingPoints = json['remainingPoints'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['points'] = points;
    data['usedPoints'] = usedPoints;
    data['remainingPoints'] = remainingPoints;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
