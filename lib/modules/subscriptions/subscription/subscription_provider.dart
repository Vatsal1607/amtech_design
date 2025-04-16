import 'dart:developer';

import 'package:amtech_design/services/network/api_service.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/keys.dart';
import '../../../models/subs_list_model.dart';
import '../../../services/local/shared_preferences_service.dart';

class SubscriptionProvider extends ChangeNotifier {
  bool isLoading = false;
  SubsListModel? subsListRes;

  List<SubsItems> activeList = [];
  List<SubsItems> expiredList = [];
  ApiService apiService = ApiService();

  // *  GetSubsList API
  Future<void> getSubsList(BuildContext context) async {
    isLoading = true;
    try {
      String userId =
          sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      final res = await apiService.getSubsList(
        limit: 50,
        page: 1,
        userId: userId,
      );
      log('getSubsList: $res');
      if (res.success == true && res.data != null) {
        // subsListRes = res;
        activeList = res.data!.subsItems
                ?.where((item) => item.isActive == true)
                .toList() ??
            [];
        expiredList = res.data!.subsItems
                ?.where((item) => item.isActive == false)
                .toList() ??
            [];
      } else {
        log('${res.message}');
      }
    } catch (e) {
      log("Error getSubsList: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
