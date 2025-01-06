import 'package:amtech_design/models/business_list_model.dart';
import 'package:flutter/material.dart';
import '../../../services/network/api_service.dart';

class BusinessSelectionProvider extends ChangeNotifier {
  List<BusinessList> suggestionList = [];

  bool isLoadingPagination = false;
  int currentPage = 1;

  BusinessSelectionProvider() {
    //* Api call get business list
    getBusinessList(currentPage: currentPage);
  }

  List<BusinessList> _businessList = [];
  List<BusinessList> _filteredBusinessList = [];
  BusinessList? _selectedBusiness;

  List<BusinessList> get businessList => _businessList;
  List<BusinessList> get filteredBusinessList => _filteredBusinessList;
  BusinessList? get selectedBusiness => _selectedBusiness;

  void setBusinessList(List<BusinessList> businesses) {
    _businessList = businesses;
    _filteredBusinessList = businesses;
    notifyListeners();
  }

  void filterBusinesses(String query) {
    if (query.isEmpty) {
      _filteredBusinessList = _businessList;
    } else {
      _filteredBusinessList = _businessList
          .where((business) => business.businessName!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void selectBusiness(BusinessList business) {
    _selectedBusiness = business;
    notifyListeners();
  }

  final ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  BusinessListModel? _businessListModel;
  BusinessListModel? get personalRegisterModel => _businessListModel;

  // *getBusinessList
  Future<void> getBusinessList({
    String searchText = '',
    int currentPage = 1,
  }) async {
    _isLoading = true;
    notifyListeners();
    // _businessList.clear(); // for clear the list
    try {
      _businessListModel = await apiService.getBusinessList(
        page: currentPage,
        limit: 10,
        search: searchText,
      );
      debugPrint('currentPage : $currentPage');
      if (_businessListModel?.success == true &&
          _businessListModel?.data != null) {
        _businessList = _businessListModel!.data!.businessList ?? [];
        suggestionList = _businessList; // * Update suggestionList
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error fetching business list: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
