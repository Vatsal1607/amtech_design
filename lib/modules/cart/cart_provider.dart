import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/list_cart_model.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/provider/socket_provider.dart';
import 'package:amtech_design/modules/recharge/recharge_provider.dart';
import 'package:amtech_design/modules/subscriptions/subscription_cart/subscription_cart_provider.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../core/utils/enums/enums.dart';
import '../../custom_widgets/snackbar.dart';
import '../../models/api_global_model.dart';
import '../../models/home_menu_model.dart';
import '../../routes.dart';
import '../../services/network/api_service.dart';
import '../../services/razorpay/razorpay_service.dart';

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

  String selectedPaymentMethod = SelectedPaymentMethod.perks.name;

  bool isAddressSelected(String? address) {
    return address != null && address.isNotEmpty;
  }

  updateSelectedPaymentMethod(value) {
    selectedPaymentMethod = value;
    log('selectedPaymentMethod: $selectedPaymentMethod');
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

  String? orderId;
  Future<void> onHorizontalDragEnd({
    required DragEndDetails details,
    required BuildContext context,
    required SocketProvider socketProvider,
    orderCreateData,
    required bool isSubscriptionPay,
    required String payableAmount,
  }) async {
    if (dragPosition >= maxDrag * 0.8) {
      dragPosition = maxDrag; // Snap to the end
      if (!isSubscriptionPay) {
        //! Normal order payment things
        //* Handle API call Normal Order PERKS
        if (selectedPaymentMethod == SelectedPaymentMethod.perks.name) {
          await rechargeDeduct(
            context,
            totalAmount ?? '',
            isSubscriptionPay,
          ).then(
            (isSuccess) {
              if (isSuccess == true) {
                //* Emit socket event
                socketProvider.emitEvent(
                  SocketEvents.orderCreate,
                  orderCreateData,
                );
                socketProvider.listenToEvent(
                  SocketEvents.orderReceive,
                  (data) async {
                    log('listenToEvent orderReceive: $data');
                    final order = data['order'];
                    if (order != null && order['_id'] != null) {
                      orderId = order['_id'];
                      //* API call
                      await orderPaymentDeduct(
                        orderId: orderId ?? '',
                        paymentMethod: selectedPaymentMethod,
                      );
                    } else {
                      log('Order or _id not found in received data.');
                    }
                  },
                );
              } else if (isSuccess == false) {
                //* Reset position
                dragPosition = 10.w;
                isConfirmed = false;
              }
            },
          );
        } else if (selectedPaymentMethod == SelectedPaymentMethod.upi.name) {
          //* Emit socket event
          socketProvider.emitEvent(
            SocketEvents.orderCreate,
            orderCreateData,
          );
          socketProvider.listenToEvent(
            SocketEvents.orderReceive,
            (data) {
              log('listenToEvent orderReceive: $data');
              final order = data['order'];
              if (order != null && order['_id'] != null) {
                orderId = order['_id'];
                log('ApiResponseOrderId is: $orderId');
                //* User Recharge API (payment initiate)
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final rechargeProvider =
                      Provider.of<RechargeProvider>(context, listen: false);
                  //* API call
                  rechargeProvider
                      .userRecharge(
                    context: context,
                    amount: getTotalAmountWithGST(
                            double.tryParse(totalAmount ?? '') ?? 0.0)
                        .round(),
                  )
                      .then((isSuccess) {
                    if (isSuccess) {
                      //! Open razorpay
                      RazorpayService().openRazorpayCheckout(
                        amountText: getTotalAmountWithGST(
                                double.tryParse(totalAmount ?? '') ?? 0.0)
                            .toStringAsFixed(2),
                        orderId: rechargeProvider.razorpayOrderId ?? '',
                        description: '',
                        name: '',
                      );
                      // openRazorpay(context: context);
                      debugPrint('isSuccess callback api-——: $isSuccess');
                    } else {
                      debugPrint('isSuccess callback api-——: $isSuccess');
                    }
                  });
                });
                // * Handle API call Normal Order UPI (HDFC)
                // HyperSDK hyperSDK = HyperSDK();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PaymentPage(
                //       apiResponseOrderId: orderId,
                //       paymentType: PaymentType.order,
                //       hyperSDK: hyperSDK,
                //       subsId:
                //           context.read<CreateSubscriptionPlanProvider>().subsId,
                //       amount: totalAmount ?? '',
                //     ),
                //   ),
                // );
              } else {
                log('Order or _id not found in received data.');
              }
            },
          );
        }
      } else if (isSubscriptionPay) {
        //! Subscription payment things
        if (selectedPaymentMethod == SelectedPaymentMethod.perks.name) {
          await rechargeDeduct(
            context,
            payableAmount,
            isSubscriptionPay,
          ).then(
            (isSuccess) {
              if (isSuccess == true) {
                final subsCartprovider = Provider.of<SubscriptionCartProvider>(
                    context,
                    listen: false);
                subsCartprovider.subscriptionsPaymentDeduct(
                  context,
                  selectedPaymentMethod,
                ); //* API call
                //* Reset position
                dragPosition = 10.w;
                isConfirmed = false;
              } else if (isSuccess == false) {
                //* Reset position
                dragPosition = 10.w;
                isConfirmed = false;
              }
            },
          );
        } else if (selectedPaymentMethod == SelectedPaymentMethod.upi.name) {
          final rechargeProvider =
              Provider.of<RechargeProvider>(context, listen: false);
          //* API call Subscription payment
          final subscriptionCartProvider =
              Provider.of<SubscriptionCartProvider>(context, listen: false);
          subscriptionCartProvider
              .getTotalWithGST(subscriptionCartProvider.getGrandTotal())
              .toStringAsFixed(2);
          log('Amount (subs cart): ${subscriptionCartProvider.getTotalWithGST(subscriptionCartProvider.getGrandTotal()).toStringAsFixed(2)}');
          log('Amount totalAmount (subs cart): ${subscriptionCartProvider.getGrandTotal()}');
          await rechargeProvider
              .userRecharge(
            context: context,
            amount: subscriptionCartProvider
                .getTotalWithGST(subscriptionCartProvider.getGrandTotal())
                .round(),
          )
              .then((isSuccess) {
            if (isSuccess) {
              //! Open razorpay
              RazorpayService().openRazorpayCheckout(
                amountText: subscriptionCartProvider
                    .getTotalWithGST(subscriptionCartProvider.getGrandTotal())
                    .toStringAsFixed(2),
                orderId: rechargeProvider.razorpayOrderId ?? '',
                description: '',
                name: '',
              );
              debugPrint('isSuccess callback api-——: $isSuccess');
            } else {
              debugPrint('isSuccess callback api-——: $isSuccess');
            }
          });
          //* HDFC
          // HyperSDK hyperSDK = HyperSDK();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PaymentPage(
          //       paymentType: PaymentType.subscription,
          //       hyperSDK: hyperSDK,
          //       subsId: context.read<CreateSubscriptionPlanProvider>().subsId,
          //       amount: context
          //           .read<SubscriptionCartProvider>()
          //           .getGrandTotal()
          //           .toStringAsFixed(2),
          //     ),
          //   ),
          // );
        }
      } else {
        log('No payment handler found');
      }
    } else {
      //* Reset position
      dragPosition = 10.w;
      isConfirmed = false;
    }
    notifyListeners();
  }

  // ! Razorpay
  void handlePaymentSuccess(
    BuildContext context,
    PaymentSuccessResponse response,
  ) {
    log('Payment-Success: ${response.data}');
    if (response.paymentId != null) {
      //* Reset position
      dragPosition = 10.w;
      isConfirmed = false;
      //* Normal order payment success API
      orderPayment(
        orderId: orderId ?? '',
        razorpayOrderId: response.orderId,
        razorpayPaymentId: response.paymentId,
        paymentMethod: selectedPaymentMethod,
        context: context,
      );
    }
  }

  Future<ApiGlobalModel> orderPayment({
    required String orderId,
    razorpayOrderId,
    razorpayPaymentId,
    paymentMethod,
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.orderPayment(
        orderId: orderId,
        razorpayOrderId: razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId,
        paymentMethod: paymentMethod,
      );
      if (response.success == true) {
        log('SUCCESS of orderPayment');
        await clearCart(); //* API
        Navigator.pushNamed(
          context,
          Routes.orderStatus,
          arguments: {
            'orderId': orderId,
            'isBack': false,
          },
        );
      }
      return response;
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }

  void handlePaymentError(
      BuildContext context, PaymentFailureResponse response) {
    log('Payment-Failure: ${response.toString()}');
    // Payment failure callback
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Failed"),
        content: Text(
            "Error Code: ${response.code}\nError Message: ${response.message}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }

  void handleExternalWallet(
      BuildContext context, ExternalWalletResponse response) {
    log('Payment-External wallet: ${response.toString()}');
    // External wallet callback
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("External Wallet Selected"),
        content: Text("Wallet Name: ${response.walletName}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
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

  //* Show cart snackbar
  void showCartSnackbarIfNeeded(BuildContext context, String accountType) {
    final cartItems = cartItemList ?? [];
    // Calculate total quantity of items in the cart
    final int totalItems = cartItems.fold<int>(
      0,
      (sum, item) => sum + (item.quantity ?? 0),
    );
    if (totalItems == 0) return; // Don't show snackbar if cart is empty
    // Get clean item names
    final List<String> itemNames = cartItems
        .map((item) => item.itemName?.trim() ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
    final String cartSnackbarItemText = itemNames.join(', ');
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    // Ensure Snackbar shows only after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      menuProvider.updateSnackBarVisibility(true);
      ScaffoldMessenger.of(context)
          .showSnackBar(
            cartSnackbarWidget(
              accountType: accountType,
              // message: '$totalItems item(s) added',
              message:
                  '$totalItems ${totalItems == 1 ? 'item' : 'items'} added',
              items: cartSnackbarItemText,
              context: context,
            ),
          )
          .closed
          .then((_) {
        menuProvider.updateSnackBarVisibility(false);
        log('Snackbar closed');
      });
    });
  }

  String? totalAmount;
  // * rechargeDeduct API
  Future rechargeDeduct(
    BuildContext context,
    String payableAmount,
    bool isSubscriptionPay,
  ) async {
    isLoading = true;
    try {
      final requestBody = {
        "userId": sharedPrefsService.getString(SharedPrefsKeys.userId),
        "amountToDeduct": double.parse(payableAmount).toInt(),
      };
      log('requestBody: ${requestBody.toString()}');
      final res = await apiService.rechargeDeduct(
        body: requestBody,
      );
      log('rechargeDeduct: ${res.data}');
      if (res.success == true && res.data != null) {
        if (!isSubscriptionPay) {
          Future.delayed(
            const Duration(seconds: 1),
            () async {
              debugPrint("Order Placed!");
              //* Action confirmed
              isConfirmed = true;
              //* clear cart API
              await clearCart();
              Navigator.pushNamed(
                context,
                Routes.orderStatus,
                arguments: {'orderId': orderId},
              );
              Future.delayed(const Duration(seconds: 1), () {
                dragPosition = 10.w;
                isConfirmed = false;
              });
            },
          );
        } else if (isSubscriptionPay) {
          //* Subscription
          debugPrint("Order Placed!");
          //* Action confirmed
          isConfirmed = true;
          Navigator.popUntil(
              context, ModalRoute.withName(Routes.bottomBarPage));
          Future.delayed(const Duration(seconds: 1), () {
            // * Reset position
            dragPosition = 10.w;
            isConfirmed = false;
          });
        }
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

  //* Order payment deduct (payment complete)
  Future orderPaymentDeduct({
    required String orderId,
    required String paymentMethod,
  }) async {
    try {
      final response = await apiService.orderPaymentDeduct(
        orderId: orderId,
        paymentMethod: paymentMethod,
        paymentStatus: 'Completed',
      );
      log('orderPaymentDeduct: $response');
      if (response.success == true) {
        log('SUCCESS of orderPaymentDeduct');
      }
      return response;
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }

  double getGSTCharges(double totalAmount) {
    return double.parse((totalAmount * 0.12).toStringAsFixed(2));
  }

  double getTotalAmountWithGST(double totalAmount) {
    return double.parse((totalAmount * 1.12).toStringAsFixed(2));
  }

  num getTotalAmountWithGSTWithRound(double totalAmount) {
    return (totalAmount * 1.12).round();
  }

  //* clearCart
  Future<void> clearCart() async {
    // isLoading = true;
    // notifyListeners();
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

  //* You may like products
  List<MenuItems> getMixedItemsFromCategories(List<MenuCategories> categories,
      {int perCategory = 2}) {
    final List<MenuItems> mixedItems = [];

    for (final category in categories) {
      // Copy and shuffle items from this category
      final items = List<MenuItems>.from(category.menuItems ?? [])..shuffle();

      // Take a few items (if available)
      final selected = items.take(perCategory);
      mixedItems.addAll(selected);
    }

    // Optionally shuffle the final list to mix items from different categories
    mixedItems.shuffle();
    return mixedItems;
  }
}
