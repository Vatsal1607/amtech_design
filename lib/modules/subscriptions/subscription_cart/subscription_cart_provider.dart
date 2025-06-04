import 'dart:developer';
import 'package:amtech_design/modules/cart/cart_provider.dart';
import 'package:amtech_design/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../core/utils/app_globals.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../custom_widgets/dialog/subs_success_dialog.dart';
import '../../../models/api_global_model.dart';
import '../../../models/subscription_summary_model.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../../services/network/api_service.dart';
import '../create_subscription_plan/create_subscription_plan_provider.dart';
import '../subscription/subscription_details/subscription_details_provider.dart';

class SubscriptionCartProvider extends ChangeNotifier {
  //* Calculate grand total (with AddOns)
  num addOnTotal = 0;
  num getGrandTotal() {
    if (summaryRes?.data == null) return 0.0;
    num basePrice = summaryRes!.data!.price ?? 0.0;
    // Calculate add-on total
    addOnTotal = summaryRes?.data?.items?.fold(0.0, (sum, item) {
          final addOns = item.customize
                  ?.where((custom) => custom.addOns != null)
                  .expand((custom) => custom.addOns!)
                  .toList() ??
              [];
          final itemTotal = addOns.fold(0.0, (addOnSum, addOn) {
            final singlePrice = addOn.price ?? 0.0;
            final quantity = addOn.quantity ?? 0;
            return addOnSum + (singlePrice * quantity);
          });

          return (sum ?? 0.0) + itemTotal;
        }) ??
        0.0;
    num total = basePrice + addOnTotal;
    return double.parse(total.toStringAsFixed(2));
  }

  double gstAmount = 0.0;

  //* Get only GST amount
  double getGST(num totalAmount) {
    return double.parse((totalAmount * 0.12).toStringAsFixed(2));
  }

  //* Calculate Total with delivery charges
  double calculateDeliveryCharges({
    required double distanceInKm,
    required int unitCount,
  }) {
    const double freeDistance = 1.0;
    const double ratePerKm = 7.0;
    const double gstRate = 0.18;
    // Calculate chargeable distance
    final chargeableDistance =
        distanceInKm > freeDistance ? distanceInKm - freeDistance : 0.0;
    // Calculate base delivery cost (before GST)
    final baseDeliveryCost = chargeableDistance * ratePerKm * unitCount;
    // Add GST
    final gstAmount = baseDeliveryCost * gstRate;
    final totalDeliveryCharge = baseDeliveryCost + gstAmount;
    return totalDeliveryCharge;
  }

  //* Payable amount
  double calculateTotalAmount() {
    final deliveryCharges = calculateDeliveryCharges(
      distanceInKm: double.tryParse(
              sharedPrefsService.getString(SharedPrefsKeys.confirmDistance) ??
                  '0.0') ??
          0.0,
      unitCount: int.tryParse(summaryRes?.data?.units ?? '0') ?? 0,
    );
    final totalAmount = getGrandTotal() + deliveryCharges;
    return totalAmount;
  }

  ApiService apiService = ApiService();
  bool isLoading = false;
  SubscriptionSummaryModel? summaryRes;

  // * Subscription Summary API
  Future<void> getSubscriptionDetails({
    required BuildContext context,
    String? subsId,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final provider =
          Provider.of<CreateSubscriptionPlanProvider>(context, listen: false);
      //* For Subscription Cart page
      if (provider.subsId != null) {
        final res = await apiService.subscriptionsSummary(
          subsId: subsId ?? provider.subsId!,
        );
        if (res.success == true) {
          summaryRes = res;
          subsStartDate = summaryRes?.data?.createdAt;
        } else {
          log('${res.message}');
        }
      } else if (subsId != null) {
        //* For Subscription details page
        final res = await apiService.subscriptionsSummary(
          subsId: subsId,
        );
        if (res.success == true) {
          summaryRes = res;
          context.read<SubscriptionDetailsProvider>().timeSlot =
              summaryRes?.data?.items?.first.mealSubscription?.first.timeSlot ??
                  '';
          final createdAtString = summaryRes?.data?.createdAt;
          if (createdAtString != null) {
            final createdAt = DateTime.parse(createdAtString).toLocal();
            final subsDetailsprovider =
                Provider.of<SubscriptionDetailsProvider>(context,
                    listen: false);
            subsDetailsprovider.setInitialCalendarState(createdAt);
          }
        } else {
          log('${res.message}');
        }
      }
    } catch (e) {
      log("Error getSubscriptionSummary cart page: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String? selectedAddress;

  loadAddress() {
    selectedAddress =
        sharedPrefsService.getString(SharedPrefsKeys.selectedAddress);
    notifyListeners();
  }

  String? subsStartDate;

  // Show date picker (Subscription Start Date)
  Future<void> pickStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      await context //* Api call
          .read<CreateSubscriptionPlanProvider>()
          .subscriptionUpdate(
            context: context,
            createdAtDate: pickedDate,
          )
          .then((isSuccess) {
        if (isSuccess) {
          getSubscriptionDetails(context: context);
        } else {
          log("API failed");
        }
      });
    }
  }

  //* Subscription payment deduct (payment complete)
  Future subscriptionsPaymentDeduct(
    BuildContext context,
    String selectedPaymentMethod,
  ) async {
    final createSubsProvider = context.read<CreateSubscriptionPlanProvider>();
    try {
      final response = await apiService.subscriptionsPaymentDeduct(
        // subsId: context.read<CreateSubscriptionPlanProvider>().subsId ?? '',
        subsId: createSubsProvider.subsId ?? '',
        paymentMethod: selectedPaymentMethod,
        paymentStatus: true,
      );
      log('subscriptionsPaymentDeduct: $response');
      if (response.success == true) {
        //* clear Subs list & selected meal & daywiseSelectedItem
        createSubsProvider.subsItems.clear();
        createSubsProvider.selectedMeals = {};
        createSubsProvider.daywiseSelectedItem = {};
        //* Show Subs Success dialog
        final dialogContext = navigatorKey.currentContext;
        if (dialogContext != null) {
          showSubscriptionSuccessDialog(dialogContext);
        }
        log('SUCCESS of subscriptionsPaymentDeduct');
      }
      return response;
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }

  // ! Razorpay
  void handlePaymentSuccess(
    BuildContext context,
    PaymentSuccessResponse response,
  ) {
    log('Payment-Success: ${response.data}');
    if (response.paymentId != null) {
      //* Reset position
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      cartProvider.dragPosition = 10.w;
      cartProvider.isConfirmed = false;
      //* Subscription Normal order payment success API
      final subsId =
          context.read<CreateSubscriptionPlanProvider>().subsId ?? '';
      subscriptionsPayment(
        subscriptionId: subsId,
        orderId: response.orderId ?? '',
        razorpayPaymentId: response.paymentId ?? '',
        paymentMethod: context.read<CartProvider>().selectedPaymentMethod,
        context: context,
      );
    }
  }

  Future<ApiGlobalModel> subscriptionsPayment({
    required String subscriptionId,
    required String orderId,
    required String razorpayPaymentId,
    required String paymentMethod,
    required BuildContext context,
  }) async {
    final createSubsProvider = context.read<CreateSubscriptionPlanProvider>();
    try {
      final response = await apiService.subscriptionsPayment(
        subscriptionId: subscriptionId,
        razorpayOrderId: orderId,
        razorpayPaymentId: razorpayPaymentId,
        paymentMethod: paymentMethod,
      );
      log('rechargeHandleJuspayResponse: $response');
      log('response.status: ${response.success}');
      if (response.success == true) {
        //* clear Subs list & selected meal & daywiseSelectedItem
        createSubsProvider.subsItems.clear();
        createSubsProvider.selectedMeals = {};
        createSubsProvider.daywiseSelectedItem = {};
        Navigator.popUntil(context, (route) {
          return route.settings.name == Routes.bottomBarPage;
        });
        //* Show Subs Success dialog
        final dialogContext = navigatorKey.currentContext;
        if (dialogContext != null) {
          showSubscriptionSuccessDialog(dialogContext);
        }
        log('SUCCESS of handleJuspayResponse');
      }
      return response;
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }

  void handlePaymentError(
      BuildContext context, PaymentFailureResponse response) {
    log('Payment-Failure: ${response.toString()}');
    // Payment failure callback
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Failed"),
        content: Text(
            "Error Code: ${response.code}\nError Message: ${response.message}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }

  void handleExternalWallet(
      BuildContext context, ExternalWalletResponse response) {
    log('Payment-External wallet: ${response.toString()}');
    // External wallet callback
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("External Wallet Selected"),
        content: Text("Wallet Name: ${response.walletName}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
