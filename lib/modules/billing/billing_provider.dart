import 'package:flutter/material.dart';
import '../../core/utils/constants/keys.dart';
import '../../core/utils/utils.dart';
import '../../models/billing_model.dart';
import '../../services/local/shared_preferences_service.dart';
import '../../services/network/api_service.dart';

class BillingProvider extends ChangeNotifier {
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
    getBilling(); //* API
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
        await getBilling(isRefresh: true); //* API
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
        await getBilling(isRefresh: true); //* API
      }
      notifyListeners();
    }
  }

  final ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int currentPage = 1;
  final int limit = 10;
  bool hasMore = true;
  // List<Invoices> billingList = [];

  //* Get billingList with Pagination
  Future<void> getBilling({bool isRefresh = false}) async {
    if (_isLoading || (!hasMore && !isRefresh)) return;
    _isLoading = true;
    notifyListeners();
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      // billingList.clear();
    }
    try {
      final body = {
        'page': currentPage,
        'limit': limit,
        'userId': sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
        'startDate': formattedStartDateForApi,
        'endDate': formattedEndDateForApi,
      };
      final res = await apiService.getBillingList(body: body);

      if (res.success == true && res.data != null) {
        if (isRefresh) {
          // billingList = res.data!.invoices ?? [];
        } else {
          // billingList.addAll(res.data!.invoices ?? []);
        }
        // hasMore = res.data!.invoices!.length == limit;
        currentPage++;
      } else {
        hasMore = false;
      }
    } catch (e) {
      debugPrint("Error fetching billing list: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
