import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/create_subscription_plan_provider.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/subscription_summary_model.dart' as summaryModel;
import '../../../services/network/api_service.dart';

class SubscriptionSummaryProvider extends ChangeNotifier {
  ApiService apiService = ApiService();
  bool isLoading = false;
  summaryModel.SubscriptionSummaryModel? summaryRes;
  List<summaryModel.SubscriptionItem>? subsItems;

  //* Group By Day
  Map<String, List<summaryModel.MealSubscription>> groupByDay(
      List<summaryModel.SubscriptionItem> items) {
    final Map<String, List<summaryModel.MealSubscription>> grouped = {};

    for (var item in items) {
      final meals = item.mealSubscription ?? [];
      for (var meal in meals) {
        final day = meal.day ?? '';
        if (!grouped.containsKey(day)) {
          grouped[day] = [];
        }
        grouped[day]!.add(meal);
      }
    }
    return grouped;
  }

  // * Subscription Summary API
  Future<void> getSubscriptionSummary({
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final provider =
          Provider.of<CreateSubscriptionPlanProvider>(context, listen: false);
      if (provider.subsId != null) {
        final res = await apiService.subscriptionsSummary(
          subsId: provider.subsId!,
        );
        if (res.success == true) {
          summaryRes = res;
          final userDetails = summaryRes?.data?.userDetails;
          final userName = userDetails?.businessName?.isNotEmpty == true
              ? userDetails!.businessName!
              : '${userDetails?.firstName ?? ''} ${userDetails?.lastName ?? ''}'
                  .trim();
          sharedPrefsService.setString(SharedPrefsKeys.userName, userName);
          subsItems = res.data?.items ?? [];
        } else {
          log('${res.message}');
        }
      }
    } catch (e) {
      log("Error getSubscriptionSummary: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
