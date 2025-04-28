import 'dart:async';
import 'dart:developer';
import 'package:amtech_design/modules/provider/socket_provider.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/enums/enums.dart';
import '../../../core/utils/strings.dart';

class OrderStatusProvider extends ChangeNotifier {
  bool isLoading = false;

  OrderStatus orderStatusEnum = OrderStatus.placed;
  Timer? orderStatusTimer;

  void emitAndListenOrderStatus(SocketProvider socketProvider, String orderId) {
    isLoading = true;
    orderStatusTimer?.cancel(); // Just in case it was running already
    //* Timer to emit the event every second
    orderStatusTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Emit event
      socketProvider.emitEvent(SocketEvents.getOrderStatusEmit, {
        'orderId': orderId,
      });
    });
    // Listen for event
    socketProvider.listenToEvent(SocketEvents.orderStatusResponseListen,
        (data) {
      try {
        log('Raw socket OrderStatus data: $data');
        //* Uses example
        final statusFromApi = data.containsKey('data') &&
                data['data'] == 'Accepted by DeliveryBoy'
            ? data['data']
            : data['currentStatus'] ?? data['data'];
        // final statusFromApi = data['data'];
        orderStatusEnum = OrderStatusExtension.fromString(statusFromApi);
        // debugPrint(
        //     'orderStatusEnum: ${orderStatusEnum}'); // OrderStatus.prepared
        log('orderStatusEnum.value: ${orderStatusEnum.value}'); // Prepared
        //* Switch case handle on order status
        switch (orderStatusEnum) {
          case OrderStatus.placed:
            log("Order placed.");
            break;
          case OrderStatus.confirmed:
            log("Order confirmed.");
            break;
          case OrderStatus.preparing:
            log("Order being prepared.");
            break;
          case OrderStatus.outForDelivery:
            log("Order outForDelivery.");
            break;
          case OrderStatus.delivered:
            log("Order delivered.");
            break;
          default:
            log("Status: ${orderStatusEnum.value}");
        }

        isLoading = false;
        notifyListeners();
      } catch (e) {
        isLoading = false;
        notifyListeners();
        log('Error parsing socket data OrderStatus: $e');
      }
    });
  }

  bool isBack = false;

  void setIsBack(bool value) {
    isBack = value;
    notifyListeners();
  }

  @override
  void dispose() {
    log('dispose called (OrderStatusProvider)');
    orderStatusTimer?.cancel();
    orderStatusTimer = null;
    super.dispose();
  }

  //* Get Lotties Files
  String getLottieFile(String accountType, OrderStatus status) {
    final isBusiness = accountType == 'business';

    switch (status) {
      case OrderStatus.placed:
        return isBusiness
            ? LottieStrings.orderPlaced
            : LottieStrings.orderPlacedPersonal;
      case OrderStatus.confirmed:
        return isBusiness
            ? LottieStrings.orderConfirm
            : LottieStrings.orderConfirmPersonal;
      case OrderStatus.prepared:
        return isBusiness
            ? LottieStrings.orderPreparation
            : LottieStrings.orderPreparationPersonal;
      case OrderStatus.outForDelivery:
        return isBusiness
            ? LottieStrings.orderOutForDelivery
            : LottieStrings.orderOutForDeliveryPersonal;
      case OrderStatus.delivered:
        return isBusiness
            ? LottieStrings.orderDelivered
            : LottieStrings.orderDeliveredPersonal;
      default:
        return isBusiness
            ? LottieStrings.orderPlaced
            : LottieStrings.orderPlacedPersonal;
    }
  }

  //* Get Orderstatus Text
  String getOrderStatusText(String accountType, OrderStatus status) {
    final isBusiness = accountType == 'business';

    switch (status) {
      case OrderStatus.placed:
        return isBusiness ? "Placed Successfully!" : "Placed Successfully!";
      case OrderStatus.confirmed:
        return isBusiness ? "Confirmed!" : "Confirmed!";
      case OrderStatus.prepared:
        return isBusiness ? "Prepared!" : "Prepared!";
      case OrderStatus.outForDelivery:
        return isBusiness
            ? "Out for Delivery!"
            : "Hang tight! It’s on the way!";
      case OrderStatus.delivered:
        return isBusiness ? "Delivered Successfully!" : "Enjoy your meal!";
      case OrderStatus.rejected:
        return isBusiness ? "Order Rejected!" : "Sorry! Order Rejected.";
      case OrderStatus.acceptedByDeliveryBoy:
        return isBusiness ? "Accepted by Delivery Boy" : "Rider is on the way!";
      default:
        return isBusiness ? "Placed Successfully!" : "Placed Successfully!";
    }
  }
}
