import 'dart:developer';
import 'package:amtech_design/core/utils/app_globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../models/subscription_summary_model.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../../services/network/api_service.dart';
import '../create_subscription_plan/create_subscription_plan_provider.dart';
import '../subscription/subscription_details/subscription_details_provider.dart';

class SubscriptionCartProvider extends ChangeNotifier {
  //* Calculate grand total with addons
  num getGrandTotal() {
    if (summaryRes?.data == null) return 0.0;
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
    // return basePrice + addOnTotal;
    num total = basePrice + addOnTotal;
    return double.parse(total.toStringAsFixed(2));
  }

  double gstAmount = 0.0;

  //* Get only GST amount
  double getGST(num totalAmount) {
    return double.parse((totalAmount * 0.12).toStringAsFixed(2));
  }

  //* Get total amount with GST included
  double getTotalWithGST(num totalAmount) {
    return double.parse((totalAmount * 1.12).toStringAsFixed(2));
  }

  ApiService apiService = ApiService();
  bool isLoading = false;
  SubscriptionSummaryModel? summaryRes;
  // * Subscription Summary API
  Future<void> getSubscriptionDetails({
    required BuildContext context,
    String? subsId,
  }) async {
    log('getSubscriptionDetails called, subsId: $subsId');
    isLoading = true;
    try {
      final provider =
          Provider.of<CreateSubscriptionPlanProvider>(context, listen: false);
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
  Future subscriptionsPaymentDeduct(BuildContext context) async {
    try {
      final response = await apiService.subscriptionsPaymentDeduct(
        subsId: context.read<CreateSubscriptionPlanProvider>().subsId ?? '',
      );
      log('subscriptionsPaymentDeduct: $response');
      if (response.success == true) {
        log('SUCCESS of subscriptionsPaymentDeduct');
      }
      return response;
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }
}
