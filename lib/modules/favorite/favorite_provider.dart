import 'dart:developer';
import 'package:flutter/material.dart';
import '../../core/utils/constants/keys.dart';
import '../../models/favorites_model.dart';
import '../../services/local/shared_preferences_service.dart';
import '../../services/network/api_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<FavoriteItem>? favoriteList;

  Future<void> getFavorite() async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await apiService.getFavorite(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
      );
      log('getFavorite res: $res');
      if (res.success == true) {
        favoriteList = res.data ?? [];
        log('${res.message}');
      } else {
        favoriteList = [];
        log('${res.message}');
      }
    } catch (e) {
      favoriteList = [];
      debugPrint("Error getFavorite: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
