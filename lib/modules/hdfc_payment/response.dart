import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/models/api_global_model.dart';
import 'package:amtech_design/models/get_payment_response_model.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/enums/enums.dart';
import '../../models/verify_recharge_model.dart';
import '../../routes.dart';
import '../../services/network/api_service.dart';

class ResponseScreen extends StatefulWidget {
  const ResponseScreen({super.key});

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  late Future<GetPaymentResponseModel?> _paymentFuture;
  String? orderId;
  String? amount;

  // @override
  // void initState() {
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   orderId = ModalRoute.of(context)!.settings.arguments.toString();
  //   _paymentFuture = getPaymentResponse(orderId.toString());
  // });
  //   super.initState();
  // }

  PaymentType? paymentType;
  String? subsId;
  String? apiResponseOrderId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ensure orderId is set only once
    if (orderId == null) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        orderId = args['orderId'];
        amount = args['amount'];
        paymentType = args['paymentType'];
        subsId = args['subsId']; // SubscriptionId
        apiResponseOrderId = args['apiResponseOrderId'];
        if (orderId != null) {
          _paymentFuture = getPaymentResponse(orderId!, subsId);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final orderId = ModalRoute.of(context)!.settings.arguments;
    var screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          // appBar: customAppBar(text: "Payment Status", context: context),
          body: FutureBuilder(
            // future: getPaymentResponse(orderId.toString()),
            future: _paymentFuture, //* Use the stored future
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                GetPaymentResponseModel? data = snapshot.data;

                String orderId = data?.orderId ?? '';
                String orderStatus = data?.status ?? '';

                String orderStatusText = "";
                String statusImageUrl = "";
                if (orderStatus != null) {
                  switch (orderStatus) {
                    case "CHARGED":
                    case "COD_INITIATED":
                      orderStatusText = "Payment Successful";
                      statusImageUrl = ImageStrings.paymentSuccess;
                      Future.delayed(
                        const Duration(seconds: 3),
                        () {
                          if (!mounted) return;
                          log('3 sec done after success payment');
                          if (paymentType == PaymentType.order) {
                            Navigator.pushReplacementNamed(
                                context, Routes.orderStatus);
                          } else {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                      );
                      break;
                    case "PENDING_VBV":
                      orderStatusText = "Payment Pending...";
                      statusImageUrl = ImageStrings.pending;
                      break;
                    default:
                      orderStatusText = "Payment Failed";
                      statusImageUrl = ImageStrings.paymentFailed;
                      break;
                  }
                } else {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.blue,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Call handleJuspayResponse API to fetch the Order Status",
                          style: GoogleFonts.publicSans(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight / 4,
                      margin: const EdgeInsets.only(top: 100.0),
                      child: Image.asset(
                        statusImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Center(
                        child: Text(
                          orderStatusText, // Display the payment response
                          style: GoogleFonts.publicSans(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Order Id: " +
                              orderId, // Display the payment response
                          style: GoogleFonts.publicSans(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Status: $orderStatus", // Display the payment response
                          style: GoogleFonts.publicSans(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  ApiService apiService = ApiService();

  // * getPaymentResponse api
  Future<GetPaymentResponseModel> getPaymentResponse(
    String orderId,
    String? subsId,
  ) async {
    try {
      final response = await apiService.getPaymentResponse(
        orderId: orderId,
      );
      log('getPaymentResponse: $response');
      log('response.status: ${response.status.toString()}');
      if (response.status == 'CHARGED') {
        switch (paymentType) {
          case PaymentType.recharge:
            //* API call
            await rechargeHandleJuspayResponse(
                orderId: orderId, amount: amount ?? '');
            break;
          case PaymentType.subscription:
            //* API call
            await subscriptionHandleJuspayResponse(
              orderId: orderId,
              subsId: subsId ?? '',
            );
            break;
          case PaymentType.order:
            //* API call
            await orderPayment(
              orderId: apiResponseOrderId ?? '', // apiResponseOrderId
              orderIdByJustpay: orderId,
            );
          default:
            break;
        }
      }
      return response;
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }

  // * rechargeHandleJuspayResponse
  Future<VerifyRechargeModel> rechargeHandleJuspayResponse(
      {required String orderId, required String amount}) async {
    try {
      Map<String, dynamic> requestBody = {
        "order_id": orderId,
        "userId": sharedPrefsService.getString(SharedPrefsKeys.userId),
        "rechargeAmount": int.parse(amount),
      };
      final response = await apiService.rechargeHandleJuspayResponse(
        requestBody: requestBody,
      );
      log('rechargeHandleJuspayResponse: $response');
      log('response.status: ${response.success}');
      if (response.success == true) {
        log('SUCCESS of handleJuspayResponse');
      }
      return response;
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }

  // subscriptionHandleJuspayResponse
  Future<ApiGlobalModel> subscriptionHandleJuspayResponse(
      {required String orderId, required String subsId}) async {
    try {
      final response = await apiService.subscriptionsPayment(
        orderId: orderId,
        subsId: subsId,
      );
      log('rechargeHandleJuspayResponse: $response');
      log('response.status: ${response.success}');
      if (response.success == true) {
        log('SUCCESS of handleJuspayResponse');
      }
      return response;
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }

  // orderPayment
  Future<ApiGlobalModel> orderPayment({
    required String orderId,
    required String orderIdByJustpay,
  }) async {
    try {
      final response = await apiService.orderPayment(
        orderId: orderId,
        orderIdByJustpay: orderIdByJustpay,
      );
      if (response.success == true) {
        log('SUCCESS of orderPayment');
      }
      return response;
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }
}
