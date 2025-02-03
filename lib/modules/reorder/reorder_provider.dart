import 'dart:developer';
import 'package:amtech_design/models/reorder_model.dart';
import 'package:flutter/material.dart';
import '../../core/utils/constants/keys.dart';
import '../../core/utils/utils.dart';
import '../../services/local/shared_preferences_service.dart';
import '../../services/network/api_service.dart';

class ReorderProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int currentPage = 1;
  final int limit = 10;
  bool hasMore = true;
  List<ReOrders> reorderList = [];

  // Get Order with Pagination
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
        startDate: formattedStartDateForApi,
        endDate: formattedEndDateForApi,
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

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String formattedStartDate = '';
  String formattedEndDate = '';
  String formattedStartDateForApi = '';
  String formattedEndDateForApi = '';

  //* reset Dates
  resetSelectedDates() {
    selectedStartDate = null;
    selectedEndDate = null;
    formattedStartDate = '';
    formattedEndDate = '';
    debugPrint('reset Dates called');
    getReorder();
    notifyListeners();
  }

  Future<void> pickStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedStartDate) {
      selectedStartDate = pickedDate;
      formattedStartDate = Utils.formatDate(pickedDate);
      formattedStartDateForApi = Utils.formatDateForApi(pickedDate);
      //* call Reorder API while both data selected
      if (formattedStartDate.isNotEmpty && formattedEndDate.isNotEmpty) {
        await getReorder(isRefresh: true);
      }
      notifyListeners();
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedEndDate) {
      selectedEndDate = pickedDate;
      formattedEndDate = Utils.formatDate(pickedDate);
      formattedEndDateForApi = Utils.formatDateForApi(pickedDate);
      //* call Reorder API while both data selected
      if (formattedStartDate.isNotEmpty && formattedEndDate.isNotEmpty) {
        await getReorder(isRefresh: true);
      }
      notifyListeners();
    }
  }
}
