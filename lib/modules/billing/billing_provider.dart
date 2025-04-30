import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
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
    formattedStartDateForApi = '';
    formattedEndDate = '';
    formattedEndDateForApi = '';
    getBilling(); //* API call
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
        await getBilling(isRefresh: true); //* API call
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
        await getBilling(isRefresh: true); //* API call
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

  List<Invoice> billingList = []; //* global list
  List<Invoice>? todayInvoices;
  List<Invoice>? yesterdayInvoices;
  List<Invoice>? last7DaysInvoices;
  List<Invoice>? customInvoices;

  Map<String, List<Invoice>> groupedBillingList = {};

  //* Get billingList with Pagination
  Future<void> getBilling({bool isRefresh = false}) async {
    if (_isLoading || (!hasMore && !isRefresh)) return;
    _isLoading = true;
    notifyListeners();
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      billingList.clear();
    }
    try {
      final res = await apiService.getBillingList(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
        currentPage: currentPage,
        limit: limit,
        startDate: formattedStartDateForApi,
        endDate: formattedEndDateForApi,
      );
      if (res.success == true) {
        final BillingModel billingModel = res;
        final data = billingModel.data;
        // Check if user applied a custom date range
        final bool isCustomDateRangeApplied =
            formattedStartDateForApi.isNotEmpty &&
                formattedEndDateForApi.isNotEmpty;
        if (isCustomDateRangeApplied) {
          // Only show custom invoices
          groupedBillingList = {
            'Custom': data.customInvoices,
          };
        } else {
          // Show all periods (except Custom)
          groupedBillingList = {
            if (data.todayInvoices.isNotEmpty) 'Today': data.todayInvoices,
            if (data.yesterdayInvoices.isNotEmpty)
              'Yesterday': data.yesterdayInvoices,
            if (data.last7DaysInvoices.isNotEmpty)
              'Last 7 Days': data.last7DaysInvoices,
          };
        }
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

  Future<void> downloadInvoiceToDownloads(String url, String fileName) async {
    try {
      // Request permission (required for Android versions < 11)
      if (Platform.isAndroid) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          debugPrint("Storage permission denied");
          return;
        }
      }

      Directory? downloadDir;
      if (Platform.isAndroid) {
        downloadDir = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadDir = await getApplicationDocumentsDirectory();
      }

      if (downloadDir == null || !(await downloadDir.exists())) {
        debugPrint("Download directory not found");
        return;
      }

      final filePath = path.join(downloadDir.path, fileName);

      final dio = Dio();
      await dio.download(url, filePath);

      debugPrint("Invoice downloaded to $filePath");
    } catch (e) {
      debugPrint("Download failed: $e");
    }
  }

  // Future<void> downloadInvoice(String url, String fileName) async {
  //   try {
  //     final dir = await getApplicationDocumentsDirectory();
  //     final filePath = "${dir.path}/$fileName";

  //     final dio = Dio();
  //     await dio.download(url, filePath);

  //     debugPrint("Downloaded to $filePath");

  //     // Optional: open the file
  //     // import 'package:open_file/open_file.dart';
  //     // await OpenFile.open(filePath);
  //   } catch (e) {
  //     debugPrint("Download error: $e");
  //   }
  // }
}
