class GetPaymentResponseModel {
  String? customerEmail;
  String? customerPhone;
  String? customerId;
  int? statusId;
  String? status;
  String? id;
  String? merchantId;
  int? amount;
  String? currency;
  String? orderId;
  String? dateCreated;
  String? lastUpdated;
  String? returnUrl;
  String? productId;
  PaymentLinks? paymentLinks;
  String? udf1;
  String? udf2;
  String? udf3;
  String? udf4;
  String? udf5;
  String? udf6;
  String? udf7;
  String? udf8;
  String? udf9;
  String? udf10;
  String? txnId;
  String? paymentMethodType;
  String? authType;
  String? paymentMethod;
  bool? refunded;
  int? amountRefunded;
  int? effectiveAmount;
  String? respCode;
  String? respMessage;
  String? bankErrorCode;
  String? bankErrorMessage;
  String? txnUuid;
  TxnDetail? txnDetail;
  PaymentGatewayResponse? paymentGatewayResponse;
  int? gatewayId;
  EmiDetails? emiDetails;
  String? gatewayReferenceId;
  List<String>? offers;
  int? maximumEligibleRefundAmount;
  String? orderExpiry;
  String? respCategory;

  GetPaymentResponseModel.fromJson(Map<String, dynamic> json) {
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    customerId = json['customer_id'];
    statusId = json['status_id'];
    status = json['status'];
    id = json['id'];
    merchantId = json['merchant_id'];
    amount = json['amount'];
    currency = json['currency'];
    orderId = json['order_id'];
    dateCreated = json['date_created'];
    lastUpdated = json['last_updated'];
    returnUrl = json['return_url'];
    productId = json['product_id'];
    paymentLinks = json['payment_links'] != null
        ? PaymentLinks.fromJson(json['payment_links'])
        : null;
    udf1 = json['udf1'];
    udf2 = json['udf2'];
    udf3 = json['udf3'];
    udf4 = json['udf4'];
    udf5 = json['udf5'];
    udf6 = json['udf6'];
    udf7 = json['udf7'];
    udf8 = json['udf8'];
    udf9 = json['udf9'];
    udf10 = json['udf10'];
    txnId = json['txn_id'];
    paymentMethodType = json['payment_method_type'];
    authType = json['auth_type'];
    paymentMethod = json['payment_method'];
    refunded = json['refunded'];
    amountRefunded = json['amount_refunded'];
    effectiveAmount = json['effective_amount'];
    respCode = json['resp_code'];
    respMessage = json['resp_message'];
    bankErrorCode = json['bank_error_code'];
    bankErrorMessage = json['bank_error_message'];
    txnUuid = json['txn_uuid'];
    txnDetail = json['txn_detail'] != null
        ? TxnDetail.fromJson(json['txn_detail'])
        : null;
    paymentGatewayResponse = json['payment_gateway_response'] != null
        ? PaymentGatewayResponse.fromJson(json['payment_gateway_response'])
        : null;
    gatewayId = json['gateway_id'];
    emiDetails = json['emi_details'] != null
        ? EmiDetails.fromJson(json['emi_details'])
        : null;
    gatewayReferenceId = json['gateway_reference_id'];
    offers = json['offers'] != null ? List<String>.from(json['offers']) : null;
    maximumEligibleRefundAmount = json['maximum_eligible_refund_amount'];
    orderExpiry = json['order_expiry'];
    respCategory = json['resp_category'];
  }
}

class PaymentLinks {
  String? mobile;
  String? web;
  String? iframe;
  PaymentLinks.fromJson(Map<String, dynamic> json)
      : mobile = json['mobile'],
        web = json['web'],
        iframe = json['iframe'];
}

class TxnDetail {
  String? txnId;
  String? orderId;
  String? status;
  String? errorCode;
  int? netAmount;
  String? surchargeAmount;
  String? taxAmount;
  int? txnAmount;
  String? offerDeductionAmount;
  int? gatewayId;
  String? currency;
  Metadata? metadata;
  bool? expressCheckout;
  bool? redirect;
  String? txnUuid;
  String? gateway;
  String? errorMessage;
  String? created;
  String? lastUpdated;
  String? txnFlowType;
  List<TxnAmountBreakup>? txnAmountBreakup;

  TxnDetail.fromJson(Map<String, dynamic> json)
      : txnId = json['txn_id'],
        orderId = json['order_id'],
        status = json['status'],
        errorCode = json['error_code'],
        netAmount = json['net_amount'],
        surchargeAmount = json['surcharge_amount'],
        taxAmount = json['tax_amount'],
        txnAmount = json['txn_amount'],
        offerDeductionAmount = json['offer_deduction_amount'],
        gatewayId = json['gateway_id'],
        currency = json['currency'],
        metadata = json['metadata'] != null
            ? Metadata.fromJson(json['metadata'])
            : null,
        expressCheckout = json['express_checkout'],
        redirect = json['redirect'],
        txnUuid = json['txn_uuid'],
        gateway = json['gateway'],
        errorMessage = json['error_message'],
        created = json['created'],
        lastUpdated = json['last_updated'],
        txnFlowType = json['txn_flow_type'],
        txnAmountBreakup = json['txn_amount_breakup'] != null
            ? (json['txn_amount_breakup'] as List)
                .map((v) => TxnAmountBreakup.fromJson(v))
                .toList()
            : null;
}

class Metadata {
  String? paymentChannel;
  Metadata.fromJson(Map<String, dynamic> json)
      : paymentChannel = json['payment_channel'];
}

class TxnAmountBreakup {
  String? name;
  int? amount;
  int? sno;
  String? method;
  TxnAmountBreakup.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        amount = json['amount'],
        sno = json['sno'],
        method = json['method'];
}

class PaymentGatewayResponse {
  String? respCode;
  String? rrn;
  String? created;
  String? epgTxnId;
  String? respMessage;
  PaymentGatewayResponse.fromJson(Map<String, dynamic> json)
      : respCode = json['resp_code'],
        rrn = json['rrn'],
        created = json['created'],
        epgTxnId = json['epg_txn_id'],
        respMessage = json['resp_message'];
}

class EmiDetails {
  String? bank;
  String? monthlyPayment;
  String? interest;
  String? conversionDetails;
  String? principalAmount;
  String? additionalProcessingFeeInfo;
  String? tenure;
  List<String>? subventionInfo;
  String? emiType;
  String? processedBy;

  EmiDetails({
    this.bank,
    this.monthlyPayment,
    this.interest,
    this.conversionDetails,
    this.principalAmount,
    this.additionalProcessingFeeInfo,
    this.tenure,
    this.subventionInfo,
    this.emiType,
    this.processedBy,
  });

  EmiDetails.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    monthlyPayment = json['monthly_payment'];
    interest = json['interest'];
    conversionDetails = json['conversion_details'];
    principalAmount = json['principal_amount'];
    additionalProcessingFeeInfo = json['additional_processing_fee_info'];
    tenure = json['tenure'];
    if (json['subvention_info'] != null) {
      subventionInfo = List<String>.from(json['subvention_info']);
    }
    emiType = json['emi_type'];
    processedBy = json['processed_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank'] = bank;
    data['monthly_payment'] = monthlyPayment;
    data['interest'] = interest;
    data['conversion_details'] = conversionDetails;
    data['principal_amount'] = principalAmount;
    data['additional_processing_fee_info'] = additionalProcessingFeeInfo;
    data['tenure'] = tenure;
    if (subventionInfo != null) {
      data['subvention_info'] = subventionInfo;
    }
    data['emi_type'] = emiType;
    data['processed_by'] = processedBy;
    return data;
  }
}
