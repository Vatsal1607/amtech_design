import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/menu_details_model.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import '../../services/network/api_service.dart';

class ProductDetailsProvider extends ChangeNotifier {
  bool isShowBlurText = true;

  final ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  MenuDetailsModel? menuDetailsResponse;
  bool isFavorite = false;
  bool isActive = false;

  final PageController pageController = PageController();
  int currentPage = 0;
  onPageChanged(index) {
    currentPage = index;
    notifyListeners();
  }

  Future<void> getMenuDetails({
    required String menuId,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await apiService.getMenuDetails(
        menuId: menuId,
      );
      if (res.success == true && res.data != null) {
        menuDetailsResponse = res;
        isFavorite = res.data?.isFavorite ?? false;
        isActive = res.data?.isActiveForBusiness ?? false;
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

  bool isFavLoading = false;

  Future<void> favoritesAdd({
    required String menuId,
    required BuildContext context,
  }) async {
    isFavLoading = true;
    notifyListeners();
    try {
      final reqBody = {
        'userId': sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
        'menuId': menuId,
      };
      final res = await apiService.favoritesAdd(
        body: reqBody,
      );
      log('FavouriteAdd res: $res');
      if (res.success == true && res.data != null) {
        isFavorite = true;
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error FavouriteAdd: ${e.toString()}");
    } finally {
      isFavLoading = false;
      notifyListeners();
    }
  }

  Future removeFavorite({
    required String menuId,
    required BuildContext context,
  }) async {
    isFavLoading = true;
    notifyListeners();
    try {
      final res = await apiService.removeFavorite(
        menuId: menuId,
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
      );
      log('Favourite Remove res: $res');
      if (res.success == true) {
        isFavorite = false;
        log('${res.message}');
        return true;
      } else {
        log('${res.message}');
        return false;
      }
    } catch (e) {
      debugPrint("Error Favourite Remove: ${e.toString()}");
      return false;
    } finally {
      isFavLoading = false;
      notifyListeners();
    }
  }
}
