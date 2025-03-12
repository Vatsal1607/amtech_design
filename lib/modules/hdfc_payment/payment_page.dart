import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hypersdkflutter/hypersdkflutter.dart';
import '../../models/initiate_payment_model.dart';
import '../../services/network/api_service.dart';
import 'response.dart';

class PaymentPage extends StatefulWidget {
  final HyperSDK hyperSDK;
  final String amount;
  const PaymentPage({Key? key, required this.hyperSDK, required this.amount})
      : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState(amount);
}

class _PaymentPageState extends State<PaymentPage> {
  var showLoader = true;
  var processCalled = false;
  var paymentSuccess = false;
  var paymentFailed = false;
  var amount = "0";
  _PaymentPageState(amount) {
    this.amount = amount;
  }

  @override
  void initState() {
    if (!processCalled) {
      //Todo Call of start payment method: step: 2
      startPayment(double.parse(amount));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (!processCalled) {
    //   //Todo Call of start payment method: step: 2
    //   startPayment(double.parse(amount));
    // }
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
      child: Container(
        color: Colors.white,
        child: Center(
          child: showLoader ? const CircularProgressIndicator() : Container(),
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
      );

      debugPrint("API Response: ${response.toJson()}");

      if (response.sdkPayload != null) {
        widget.hyperSDK.openPaymentPage(
          response.sdkPayload!.toJson(),
          hyperSDKCallbackHandler,
        );
      } else {
        debugPrint("Error: SDK Payload is missing");
      }
    } catch (e) {
      debugPrint("API call failed: $e");
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
          print(e);
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
                builder: (context) => ResponseScreen(),
                // settings: RouteSettings(arguments: orderId),
                settings: RouteSettings(arguments: {
                  'orderId': orderId,
                  'amount': amount,
                }),
              ),
            );
        }
    }
  }
  // block:end:create-hyper-callback
}
