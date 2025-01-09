import 'dart:convert';
import 'dart:developer';

import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/business_list_model.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import '../../../services/network/api_service.dart';

class BusinessSelectionProvider extends ChangeNotifier {
  List<BusinessList> suggestionList = [];
  List<SecondaryAccess>? secondaryAccess;
  bool isLoadingPagination = false;
  int currentPage = 1;

  BusinessSelectionProvider() {
    //* Api call get business list
    getBusinessList(currentPage: currentPage);
  }

  TextEditingController searchController = TextEditingController();
  List<BusinessList> _businessList = [];
  List<BusinessList> get businessList => _businessList;
  List<BusinessList> filteredBusinessList = [];
  BusinessList? _selectedBusiness;
  BusinessList? get selectedBusiness => _selectedBusiness;

  void filterBusinesses(String query) {
    if (query.isEmpty) {
      filteredBusinessList =
          List.from(suggestionList); // * Use suggestionList as base
    } else {
      filteredBusinessList = suggestionList
          .where((business) => business.businessName!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      // filteredBusinessList = _businessList
      //     .where((business) => business.businessName!
      //         .toLowerCase()
      //         .contains(query.toLowerCase()))
      //     .toList();
    }
    notifyListeners();
  }

  void selectBusiness(BusinessList? business) {
    _selectedBusiness = business;
    notifyListeners();
  }

  final ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  BusinessListModel? _businessListModel;
  BusinessListModel? get personalRegisterModel => _businessListModel;

  int totalRecords = 0;

  // *getBusinessList
  Future<void> getBusinessList({
    String searchText = '',
    int currentPage = 0,
  }) async {
    debugPrint('$totalRecords');
    _isLoading = true;
    notifyListeners();
    try {
      _businessListModel = await apiService.getBusinessList(
        page: currentPage,
        limit: 10,
        search: searchText,
      );
      log('Response: ${_businessListModel?.data?.businessList?[3].secondaryAccess}');
      debugPrint('currentPage : $currentPage');
      if (_businessListModel?.success == true &&
          _businessListModel?.data != null) {
        totalRecords = _businessListModel!.data!.totalRecords ?? 0;
        _businessList = _businessListModel!.data!.businessList ?? [];
        suggestionList.addAll(_businessList.where((item) =>
            !suggestionList.any((suggestion) => suggestion.sId == item.sId)));
        filteredBusinessList =
            List.from(suggestionList); // Update filtered list
        // * storeSecondaryAccessLocally
        saveBusinessNameAndSecondaryAccess(businessList);
        // storeSecondaryAccessLocally(jsonEncode(_businessListModel!.data));
      }
    } catch (e) {
      debugPrint("Error fetching business list: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveBusinessNameAndSecondaryAccess(
      List<dynamic> businessList) async {
    // Extract businessName and secondaryAccess
    List<Map<String, dynamic>> extractedData = businessList.map((business) {
      return {
        "businessName": business.businessName, // Use dot notation
        "secondaryAccess": business.secondaryAccess, // Use dot notation
      };
    }).toList();

    // Convert to JSON and save
    String jsonString = jsonEncode(extractedData);
    await sharedPrefsService.setString(
        SharedPrefsKeys.businessList, jsonString);
  }
}
