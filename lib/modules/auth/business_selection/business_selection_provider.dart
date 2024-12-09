import 'package:amtech_design/models/business_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../services/network/api_service.dart';

class BusinessSelectionProvider extends ChangeNotifier {
  var suggestions = <String>[];
  var selectedValue = null;
  BusinessSelectionProvider() {
    suggestions = [];
  }

  String? dropdownValue;

  final List<String> dropdownItems = [
    'AMTech Design',
    'AMTech Design 2',
    'AMTech Design 3',
  ];

  onChangeDropdown(String? newValue) {
    dropdownValue = newValue!;
    debugPrint(dropdownValue.toString());
    notifyListeners();
  }

  final ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  BusinessListModel? _businessListModel;
  BusinessListModel? get personalRegisterModel => _businessListModel;

  // *getBusinessList
  Future<void> getBusinessList() async {
    _isLoading = true;
    notifyListeners();
    try {
      _businessListModel = await apiService.getBusinessList(
        page: 1,
        limit: 10,
        search: '',
      );
      debugPrint('Personal Register log: $_businessListModel');
      if (_businessListModel?.success == true) {
        debugPrint('SUCCESS TRUE (get business list)');
      }
    } catch (e) {
      debugPrint("getBusinessList Error: ${e.toString()}");
      if (e is DioException) {
        debugPrint('getBusinessList: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
