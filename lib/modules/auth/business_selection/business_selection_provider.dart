import 'dart:convert';
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
    //* Api call
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
    }
    notifyListeners();
  }

  void selectBusiness(BusinessList? business) {
    _selectedBusiness = business;
    notifyListeners();
  }

  bool isSearchOpen = false;
  SearchController businessSearchController = SearchController();
  onTapSearch() {
    isSearchOpen = true;
    notifyListeners();
  }

  onItemTap() {
    isSearchOpen = false;
    notifyListeners();
  }

  final ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  BusinessListModel? _businessListModel;
  BusinessListModel? get personalRegisterModel => _businessListModel;

  int totalRecords = 0;

  //* getBusinessList
  Future<void> getBusinessList({
    String searchText = '',
    int currentPage = 1,
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
      debugPrint('currentPage : $currentPage');
      if (_businessListModel?.success == true &&
          _businessListModel?.data != null) {
        totalRecords = _businessListModel!.data!.totalRecords ?? 0;
        // Add new data to the existing list for pagination
        if (currentPage == 1) {
          // For the first page, replace the list
          _businessList = _businessListModel?.data?.businessList ?? [];
        } else {
          // For subsequent pages, append new data
          _businessList.addAll(_businessListModel?.data?.businessList ?? []);
        }
        // Clear and update the suggestion list
        suggestionList.clear();
        // suggestionList.addAll(_businessList);
        suggestionList.addAll(_businessList.where((item) =>
            !suggestionList.any((suggestion) => suggestion.sId == item.sId)));
        // Update filtered list
        filteredBusinessList = List.from(suggestionList);
        // * storeSecondaryAccessLocally
        saveBusinessNameAndSecondaryAccess(businessList);
      }
    } catch (e) {
      debugPrint("Error fetching business list: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // * Save SelectedBusinessSecondaryAccess
  Future<void> saveSelectedBusinessSecondaryAccess(
      List<BusinessList> businessList, String selectedBusinessName) async {
    // Find the selected business
    BusinessList? selectedBusiness = businessList.firstWhere(
      (business) => business.businessName == selectedBusinessName,
      orElse: () => BusinessList.empty(), // Provide a fallback empty instance
    );

    // Check if the found business is valid
    if (selectedBusiness.businessName != null &&
        selectedBusiness.businessName!.isNotEmpty) {
      // Extract secondaryAccess and save
      String jsonString = jsonEncode(selectedBusiness.secondaryAccess);
      await sharedPrefsService.setString(
        SharedPrefsKeys.secondaryAccessList,
        jsonString,
      );
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
        SharedPrefsKeys.firstSecondaryAccessList, jsonString);
  }
}
