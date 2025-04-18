class BillingModel {
  final bool success;
  final int statusCode;
  final String message;
  final InvoiceData data;

  BillingModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory BillingModel.fromJson(Map<String, dynamic> json) {
    return BillingModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: InvoiceData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class InvoiceData {
  final List<Invoice> todayInvoices;
  final List<Invoice> yesterdayInvoices;
  final List<Invoice> last7DaysInvoices;
  final List<Invoice> customInvoices;

  InvoiceData({
    required this.todayInvoices,
    required this.yesterdayInvoices,
    required this.last7DaysInvoices,
    required this.customInvoices,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      todayInvoices: List<Invoice>.from(
          json['todayInvoices'].map((x) => Invoice.fromJson(x))),
      yesterdayInvoices: List<Invoice>.from(
          json['yesterdayInvoices'].map((x) => Invoice.fromJson(x))),
      last7DaysInvoices: List<Invoice>.from(
          json['last7DaysInvoices'].map((x) => Invoice.fromJson(x))),
      customInvoices: List<Invoice>.from(
          json['customInvoices'].map((x) => Invoice.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todayInvoices': todayInvoices.map((x) => x.toJson()).toList(),
      'yesterdayInvoices': yesterdayInvoices.map((x) => x.toJson()).toList(),
      'last7DaysInvoices': last7DaysInvoices.map((x) => x.toJson()).toList(),
      'customInvoices': customInvoices.map((x) => x.toJson()).toList(),
    };
  }
}

class Invoice {
  final String id;
  final String orderId;
  final String invoiceNumber;
  final String userId;
  final int totalAmount;
  final String invoiceUrl;
  final bool isPaid;
  final int currentValue;
  final DateTime generatedAt;
  final int v;

  Invoice({
    required this.id,
    required this.orderId,
    required this.invoiceNumber,
    required this.userId,
    required this.totalAmount,
    required this.invoiceUrl,
    required this.isPaid,
    required this.currentValue,
    required this.generatedAt,
    required this.v,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['_id'],
      orderId: json['orderId'],
      invoiceNumber: json['invoiceNumber'],
      userId: json['userId'],
      totalAmount: json['totalAmount'],
      invoiceUrl: json['invoiceUrl'],
      isPaid: json['isPaid'],
      currentValue: json['currentValue'],
      generatedAt: DateTime.parse(json['generatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'orderId': orderId,
      'invoiceNumber': invoiceNumber,
      'userId': userId,
      'totalAmount': totalAmount,
      'invoiceUrl': invoiceUrl,
      'isPaid': isPaid,
      'currentValue': currentValue,
      'generatedAt': generatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
