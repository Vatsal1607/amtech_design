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

  Future<void> onHorizontalDragEnd({
    required DragEndDetails details,
    required BuildContext context,
    required socketProvider,
    required orderCreateData,
  }) async {
    if (dragPosition >= maxDrag * 0.8) {
      dragPosition = maxDrag; // Snap to the end
      //! API call
      await rechargeDeduct(context).then(
        (isSuccess) {
          if (isSuccess == true) {
            //* Emit socket event
            socketProvider.emitEvent(
              SocketEvents.orderCreate,
              orderCreateData,
            );
          } else if (isSuccess == false) {
            //* Reset position
            dragPosition = 10.w;
            isConfirmed = false;
          }
        },
      );
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
  Future rechargeDeduct(BuildContext context) async {
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
        Future.delayed(
          const Duration(milliseconds: 500),
          () async {
            debugPrint("Order Placed!");
            //* Action confirmed
            isConfirmed = true;
            //* clear cart API
            Navigator.pushNamed(context, Routes.orderStatus);
            await clearCart();
            Future.delayed(const Duration(seconds: 1), () {
              dragPosition = 10.w;
            });
          },
        );
        return true; //* success
      } else {
        log('${res.message}');
        return false; //* failure
      }
    } catch (e) {
      debugPrint("Error rechargeDeduct: ${e.toString()}");
      return false; //* failure
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
