import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypersdkflutter/hypersdkflutter.dart';
import '../../core/utils/enums/enums.dart';
import '../../models/initiate_payment_model.dart';
import '../../services/network/api_service.dart';
import 'response.dart';

class PaymentPage extends StatefulWidget {
  final HyperSDK hyperSDK;
  final String amount;
  final PaymentType paymentType;
  final String? subsId;
  final String? apiResponseOrderId;
  const PaymentPage({
    super.key,
    required this.hyperSDK,
    required this.amount,
    required this.paymentType,
    this.subsId,
    this.apiResponseOrderId,
  });
  @override
  _PaymentPageState createState() => _PaymentPageState(amount);
}

class _PaymentPageState extends State<PaymentPage> {
  var showLoader = true;
  var processCalled = false;
  var paymentSuccess = false;
  var paymentFailed = false;
  var amount = "0";
  _PaymentPageState(this.amount);

  @override
  void initState() {
    if (!processCalled) {
      // * Start payment
      startPayment(double.parse(amount));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//block:start:onBackPress
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          var backpressResult = await widget.hyperSDK.onBackPress();

          if (backpressResult.toLowerCase() == "true") {
            return false;
          } else {
            return true;
          }
        } else {
          return true;
        }
      },
//block:end:onBackPress
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: showLoader
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(height: 10.h),
                      Text('Please wait...',
                          style: GoogleFonts.publicSans(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  ApiService apiService = ApiService();

  //* block:start:startPayment
  void startPayment(
    double amount,
  ) async {
    try {
      final requestBody = {
        // "order_id": "test${(Random().nextInt(900000) + 100000)}",
        "amount": amount,
      };
      final InitiatePaymentModel response =
          await apiService.initiateJuspayPayment(
        requestBody: requestBody,
      ); // * API call
      log("API Response: ${response.toJson()}");
      if (response.sdkPayload != null) {
        widget.hyperSDK.openPaymentPage(
          response.sdkPayload!.toJson(),
          hyperSDKCallbackHandler,
        );
      } else {
        log("Error: SDK Payload is missing");
      }
    } catch (e) {
      log("API call failed: $e");
    }
  }
  // * block:end:startPayment

  // block:start:create-hyper-callback
  void hyperSDKCallbackHandler(MethodCall methodCall) {
    switch (methodCall.method) {
      case "hide_loader":
        setState(() {
          showLoader = false;
        });
        break;
      case "process_result":
        var args = {};

        try {
          args = json.decode(methodCall.arguments);
        } catch (e) {
          log('log args: $e');
        }
        var innerPayload = args["payload"] ?? {};
        var status = innerPayload["status"] ?? " ";
        var orderId = args['orderId'];

        switch (status) {
          case "backpressed":
          case "user_aborted":
            {
              Navigator.pop(context);
            }
            break;
          default:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResponseScreen(),
                settings: RouteSettings(arguments: {
                  'orderId': orderId,
                  'apiResponseOrderId': widget.apiResponseOrderId,
                  'amount': amount,
                  'paymentType': widget.paymentType,
                  'subsId': widget.subsId,
                }),
              ),
            );
        }
    }
  }
  // block:end:create-hyper-callback
}
