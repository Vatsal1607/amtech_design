import 'dart:developer';
import 'package:amtech_design/models/reorder_model.dart';
import 'package:flutter/material.dart';
import '../../core/utils/constants/keys.dart';
import '../../services/local/shared_preferences_service.dart';
import '../../services/network/api_service.dart';

class ReorderProvider extends ChangeNotifier {
  // ReorderProvider() {
  // getReorder();
  // }

  final ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int currentPage = 1;
  final int limit = 10;
  bool hasMore = true;
  List<ReOrders> reorderList = [];

  // Get Order with Pagination (// Todo set pagination)
  Future<void> getReorder({bool isRefresh = false}) async {
    if (_isLoading || (!hasMore && !isRefresh)) return;

    _isLoading = true;
    notifyListeners();

    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      reorderList.clear();
    }

    try {
      final res = await apiService.getReorderList(
        page: currentPage,
        limit: limit,
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
      );

      if (res.success == true && res.data?.reOrders != null) {
        if (isRefresh) {
          reorderList = res.data!.reOrders!;
        } else {
          reorderList.addAll(res.data!.reOrders!);
        }
        hasMore = res.data!.reOrders!.length == limit;
        currentPage++;
      } else {
        hasMore = false;
      }
    } catch (e) {
      debugPrint("Error fetching reorder list: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
