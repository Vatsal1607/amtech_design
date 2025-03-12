class InitiatePaymentModel {
  String? status;
  String? id;
  String? orderId;
  PaymentLinks? paymentLinks;
  SdkPayload? sdkPayload;
  String? orderExpiry;

  InitiatePaymentModel(
      {this.status,
      this.id,
      this.orderId,
      this.paymentLinks,
      this.sdkPayload,
      this.orderExpiry});

  InitiatePaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    orderId = json['order_id'];
    paymentLinks = json['payment_links'] != null
        ? PaymentLinks.fromJson(json['payment_links'])
        : null;
    sdkPayload = json['sdk_payload'] != null
        ? SdkPayload.fromJson(json['sdk_payload'])
        : null;
    orderExpiry = json['order_expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['id'] = id;
    data['order_id'] = orderId;
    if (paymentLinks != null) {
      data['payment_links'] = paymentLinks!.toJson();
    }
    if (sdkPayload != null) {
      data['sdk_payload'] = sdkPayload!.toJson();
    }
    data['order_expiry'] = orderExpiry;
    return data;
  }
}

class PaymentLinks {
  String? web;
  String? expiry;

  PaymentLinks({this.web, this.expiry});

  PaymentLinks.fromJson(Map<String, dynamic> json) {
    web = json['web'];
    expiry = json['expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['web'] = web;
    data['expiry'] = expiry;
    return data;
  }
}

class SdkPayload {
  String? requestId;
  String? service;
  Payload? payload;
  String? expiry;

  SdkPayload({this.requestId, this.service, this.payload, this.expiry});

  SdkPayload.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    service = json['service'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    expiry = json['expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestId'] = requestId;
    data['service'] = service;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    data['expiry'] = expiry;
    return data;
  }
}

class Payload {
  String? clientId;
  String? customerId;
  String? displayBusinessAs;
  String? orderId;
  String? returnUrl;
  String? currency;
  String? customerPhone;
  String? service;
  String? environment;
  String? merchantId;
  String? amount;
  String? clientAuthTokenExpiry;
  String? clientAuthToken;
  String? action;
  bool? collectAvsInfo;

  Payload(
      {this.clientId,
      this.customerId,
      this.displayBusinessAs,
      this.orderId,
      this.returnUrl,
      this.currency,
      this.customerPhone,
      this.service,
      this.environment,
      this.merchantId,
      this.amount,
      this.clientAuthTokenExpiry,
      this.clientAuthToken,
      this.action,
      this.collectAvsInfo});

  Payload.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    customerId = json['customerId'];
    displayBusinessAs = json['displayBusinessAs'];
    orderId = json['orderId'];
    returnUrl = json['returnUrl'];
    currency = json['currency'];
    customerPhone = json['customerPhone'];
    service = json['service'];
    environment = json['environment'];
    merchantId = json['merchantId'];
    amount = json['amount'];
    clientAuthTokenExpiry = json['clientAuthTokenExpiry'];
    clientAuthToken = json['clientAuthToken'];
    action = json['action'];
    collectAvsInfo = json['collectAvsInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientId'] = clientId;
    data['customerId'] = customerId;
    data['displayBusinessAs'] = displayBusinessAs;
    data['orderId'] = orderId;
    data['returnUrl'] = returnUrl;
    data['currency'] = currency;
    data['customerPhone'] = customerPhone;
    data['service'] = service;
    data['environment'] = environment;
    data['merchantId'] = merchantId;
    data['amount'] = amount;
    data['clientAuthTokenExpiry'] = clientAuthTokenExpiry;
    data['clientAuthToken'] = clientAuthToken;
    data['action'] = action;
    data['collectAvsInfo'] = collectAvsInfo;
    return data;
  }
}
