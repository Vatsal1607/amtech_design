import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/subscription_summary_model.dart';
import '../../../services/network/api_service.dart';
import '../create_subscription_plan/create_subscription_plan_provider.dart';

class SubscriptionCartProvider extends ChangeNotifier {
  // double getGrandTotal(BuildContext context) {
  //   if (summaryRes?.data?.items == null) return 0.0;
  //   return summaryRes!.data!.items!.fold(0.0, (sum, item) {
  //     final addOns = item.customize
  //             ?.where((custom) => custom.addOns != null)
  //             .expand((custom) => custom.addOns!)
  //             .toList() ??
  //         [];
  //     final itemTotal = addOns.fold(0.0, (addOnSum, addOn) {
  //       final singlePrice = addOn.price ?? 0.0;
  //       final quantity = addOn.quantity ?? 0;
  //       return addOnSum + (singlePrice * quantity);
  //     });
  //     return sum + itemTotal;
  //   });
  // }
  num getGrandTotal(BuildContext context) {
    if (summaryRes?.data == null) return 0.0;
    // Get base price from summaryRes.data.price
    num basePrice = summaryRes!.data!.price ?? 0.0;
    // Calculate add-on total
    num addOnTotal = summaryRes?.data?.items?.fold(0.0, (sum, item) {
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

    return basePrice + addOnTotal;
  }

  double gstAmount = 0.0;
  getGST(num totalAmount) {
    return gstAmount = totalAmount * 0.12;
    // notifyListeners(); // Notify all widgets listening to this provider
  }

  ApiService apiService = ApiService();
  bool isLoading = false;
  SubscriptionSummaryModel? summaryRes;
  // * Subscription Summary API
  Future<void> getSubscriptionDetails({
    required BuildContext context,
  }) async {
    isLoading = true;
    try {
      final provider =
          Provider.of<CreateSubscriptionPlanProvider>(context, listen: false);
      if (provider.subsId != null) {
        final res = await apiService.subscriptionsSummary(
          subsId: provider.subsId!,
        );
        if (res.success == true) {
          summaryRes = res;
          log('getSubscriptionSummary cart page: ${res.message}');
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
}
