import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/list_cart_model.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routes.dart';
import '../../services/network/api_service.dart';

class CartProvider extends ChangeNotifier {
  bool isExpanded = false;
  onExpansionChanged(value) {
    isExpanded = value;
    notifyListeners();
  }

  double dragPosition = 10.w; // Track the drag position
  final double maxDrag = 280.w; // Maximum drag length
  // maxDrag parentWidth - buttonWidth - 10.0;
  final minDrag = 10.w;
  bool isConfirmed = false; // Track if the action is confirmed

  String selectedPaymentMethod = 'Perks';

  updateSelectedPaymentMethod(value) {
    selectedPaymentMethod = value;
    debugPrint('selectedPaymentMethod: $selectedPaymentMethod');
    notifyListeners();
  }

  // * old gesture effect
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    dragPosition += details.delta.dx;
    // Prevent sliding left
    if (dragPosition < 0) {
      dragPosition = 10.w;
    }
    // Limit max drag
    if (dragPosition > maxDrag) {
      dragPosition = maxDrag;
    }
    notifyListeners(); // Notify listeners of the change
  }

  void onHorizontalDragEnd(details, context) {
    if (dragPosition >= maxDrag * 0.8) {
      // Action confirmed
      isConfirmed = true;
      dragPosition = maxDrag; // Snap to the end
      debugPrint("Order Placed!");
      rechargeDeduct(); // ! rechargeDeduct API call
      Navigator.pushNamed(context, Routes.orderStatus);
      Future.delayed(const Duration(seconds: 2), () {
        dragPosition = 10.w;
      });
    } else {
      //* Reset position
      dragPosition = 10.w;
      isConfirmed = false;
    }
    notifyListeners();
  }

  bool isLoading = false;
  final ApiService apiService = ApiService();
  List<CartItems>? cartItemList;
  ListCartModel? listCartResponse;

  // * getListCart API
  Future<void> getListCart() async {
    isLoading = true;
    notifyListeners();
    try {
      final userId = sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      final accountType =
          sharedPrefsService.getString(SharedPrefsKeys.accountType);
      final res = await apiService.getListCart(
        userId: userId,
        userType: accountType == 'business' ? 0 : 1,
      );
      log('getListCart: ${res.data}');
      if (res.success == true && res.data != null) {
        listCartResponse = res;
        cartItemList = res.data?.carts?[0].items;
        totalAmount = res.data?.carts?.first.totalAmount?.toString() ?? '';
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error getListCart: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String? totalAmount;
  // * rechargeDeduct API
  Future<void> rechargeDeduct() async {
    isLoading = true;
    notifyListeners();
    try {
      final requestBody = {
        "userId": sharedPrefsService.getString(SharedPrefsKeys.userId),
        "amountToDeduct": totalAmount,
      };
      log('requestBody: ${requestBody.toString()}');
      final res = await apiService.rechargeDeduct(
        body: requestBody,
      );
      log('rechargeDeduct: ${res.data}');
      if (res.success == true && res.data != null) {
        //
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error rechargeDeduct: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  double calculateGST(double totalAmount) {
    return double.parse(((5 / 100) * totalAmount).toStringAsFixed(2));
  }

  //* clearCart
  Future<void> clearCart() async {
    // isLoading = true;
    notifyListeners();
    try {
      final res = await apiService.clearCart(
        cartId: listCartResponse?.data?.carts?[0].sId ?? '',
      );
      if (res.success == true) {
        log('${res.message}');
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error clearCart: ${e.toString()}");
    } finally {
      // isLoading = false;
      // notifyListeners();
    }
  }
}
