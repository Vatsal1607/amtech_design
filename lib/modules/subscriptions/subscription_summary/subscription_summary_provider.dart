import 'dart:developer';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/create_subscription_plan_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/subscription_summary_model.dart' as summaryModel;
import '../../../models/subscription_create_request_model.dart' as requestModel;
import '../../../services/network/api_service.dart';

class SubscriptionSummaryProvider extends ChangeNotifier {
  // final List<Map<String, dynamic>> subscriptionDetails = [
  //   {
  //     'day': 'Monday',
  //     'timeslots': [
  //       {
  //         'time': '10:00AM To 11:00AM',
  //         'item': 'Kachumber Salad',
  //         'description':
  //             'Cucumber, Tomato, Onion, Cilantro, Carrot, Cabbage, Mint Leaves crafted with the Indian Spices'
  //       },
  //       {
  //         'time': '04:00PM To 05:00PM',
  //         'item': 'Protein Salad',
  //         'description':
  //             'Roasted Peanuts, Boiled grains, Paneer, Fresh Vegetables crafted with the Olive Oil and curd Dressing | 1 Apple Juice'
  //       },
  //     ]
  //   },
  //   {
  //     'day': 'Tuesday',
  //     'timeslots': [
  //       {
  //         'time': '10:00AM To 11:00AM',
  //         'item': 'Kachumber Salad',
  //         'description':
  //             'Cucumber, Tomato, Onion, Cilantro, Carrot, Cabbage, Mint Leaves crafted with the Indian Spices'
  //       },
  //     ]
  //   },
  //   {
  //     'day': 'Wednesday',
  //     'timeslots': [
  //       {
  //         'time': '10:00AM To 11:00AM',
  //         'item': 'Kachumber Salad',
  //         'description':
  //             'Cucumber, Tomato, Onion, Cilantro, Carrot, Cabbage, Mint Leaves crafted with the Indian Spices'
  //       },
  //     ]
  //   },
  //   // * Add other days similarly
  // ];

  ApiService apiService = ApiService();
  bool isLoading = false;
  summaryModel.SubscriptionSummaryModel? summaryRes;
  List<summaryModel.SubscriptionItem>? subsItems;

  // * Subscription Summary API
  Future<void> getSubscriptionSummary({
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
          subsItems = res.data?.items ?? [];
          log('getSubscriptionSummary: ${res.message}');
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
