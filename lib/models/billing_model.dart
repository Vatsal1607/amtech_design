class BillingModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  BillingModel({this.success, this.statusCode, this.message, this.data});

  BillingModel.fromJson(Map<String, dynamic> json) {
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
  List<Invoices>? invoices;
  int? totalInvoices;

  Data({this.invoices, this.totalInvoices});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(Invoices.fromJson(v));
      });
    }
    totalInvoices = json['totalInvoices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (invoices != null) {
      data['invoices'] = invoices!.map((v) => v.toJson()).toList();
    }
    data['totalInvoices'] = totalInvoices;
    return data;
  }
}

class Invoices {
  String? sId;
  String? orderId;
  String? invoiceNumber;
  String? userId;
  int? totalAmount;
  bool? isPaid;
  int? currentValue;
  String? generatedAt;
  int? iV;

  Invoices(
      {this.sId,
      this.orderId,
      this.invoiceNumber,
      this.userId,
      this.totalAmount,
      this.isPaid,
      this.currentValue,
      this.generatedAt,
      this.iV});

  Invoices.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['orderId'];
    invoiceNumber = json['invoiceNumber'];
    userId = json['userId'];
    totalAmount = json['totalAmount'];
    isPaid = json['isPaid'];
    currentValue = json['currentValue'];
    generatedAt = json['generatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['orderId'] = orderId;
    data['invoiceNumber'] = invoiceNumber;
    data['userId'] = userId;
    data['totalAmount'] = totalAmount;
    data['isPaid'] = isPaid;
    data['currentValue'] = currentValue;
    data['generatedAt'] = generatedAt;
    data['__v'] = iV;
    return data;
  }
}
