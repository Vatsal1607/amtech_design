import 'dart:developer';
import 'package:amtech_design/models/menu_details_model.dart';
import 'package:amtech_design/models/menu_size_model.dart';
import 'package:flutter/material.dart';
import '../../services/network/api_service.dart';

class ProductDetailsProvider extends ChangeNotifier {
  bool isShowBlurText = true;
  // String menuId;
  // ProductDetailsProvider() {

  // }

  final ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  MenuDetailsModel? menuDetailsResponse;

  Future<void> getMenuDetails({
    required String menuId,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await apiService.getMenuDetails(
        menuId: menuId,
      );
      log('menuDetailsResponse: $menuDetailsResponse');
      if (res.success == true && res.data != null) {
        menuDetailsResponse = res;
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error fetching menuDetails: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
