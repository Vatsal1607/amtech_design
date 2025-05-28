import 'dart:async';
import 'dart:developer';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/enums/enums.dart';
import '../../../models/all_order_status_model.dart';
import '../../provider/socket_provider.dart';

class OrderListProvider extends ChangeNotifier {
  bool isLoading = false;
  Timer? allOrderStatusListTimer;
  AllOrderStatusModel? allOrderStatusModel;

  void emitAndListenAllOrderStatus(SocketProvider socketProvider) {
    isLoading = true;
    notifyListeners();
    allOrderStatusListTimer?.cancel(); // Just in case it was running already
    //* Timer to emit the event every second
    allOrderStatusListTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      // Emit event
      socketProvider.emitEvent(SocketEvents.getAllOrderStatusesEmit, {
        'userId': sharedPrefsService.getString(SharedPrefsKeys.userId),
      });
    });
    // Listen for event
    socketProvider.listenToEvent(SocketEvents.allOrderStatusesResponseListen,
        (data) {
      try {
        log('Raw socket AllOrderStatus data: $data');
        allOrderStatusModel = AllOrderStatusModel.fromJson(data);
        isLoading = false;
        notifyListeners();
      } catch (e) {
        isLoading = false;
        notifyListeners();
        log('Error parsing socket data AllOrderStatus: $e');
      }
    });
  }

  OrderStatus getOrderStatusFromString(String? status) {
    switch (status?.toLowerCase()) {
      case 'placed':
      case 'confirmed':
        return OrderStatus.placed;
      case 'prepared':
        return OrderStatus.prepared;
      case 'out for delivery':
        return OrderStatus.outForDelivery;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        return OrderStatus
            .placed; // Default to 'placed' if the status is unrecognized
    }
  }

  void disposeAllOrderStatus(SocketProvider socketProvider) {
    // Cancel periodic timer
    allOrderStatusListTimer?.cancel();
    allOrderStatusListTimer = null;
    // Remove socket listener
    socketProvider.offEvent(SocketEvents.allOrderStatusesResponseListen);
  }
}
