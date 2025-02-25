import 'dart:developer';
import 'package:amtech_design/models/saved_address_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constants/keys.dart';
import '../../../../models/nearby_address_model.dart';
import '../../../../services/local/shared_preferences_service.dart';
import '../../../provider/socket_provider.dart';

class SavedAddressProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isFirstCall = true;

  //* Emit & Listen Saved Address
  void emitAndListenSavedAddress(SocketProvider socketProvider) async {
    isLoading = true;
    notifyListeners();
    final userId = sharedPrefsService.getString(SharedPrefsKeys.userId);
    final lat = sharedPrefsService.getString(SharedPrefsKeys.lat);
    final long = sharedPrefsService.getString(SharedPrefsKeys.long);
    final accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType);
    Map<String, dynamic> data = {
      "userId": userId,
    };
    if (isFirstCall) {
      data["latitude"] = lat;
      data["longitude"] = long;
      data["isFirst"] = true;
      data["role"] = accountType == 'business' ? 0 : 1;
      isFirstCall = false; //* Set to false after first call
    }
    log('userLocation data is: $data');
    socketProvider.emitEvent(SocketEvents.saveAddressEventName, data);

    log('emitAndListenSavedAddress called');

    socketProvider.listenToEvent(SocketEvents.searchSavedLocationListen,
        (data) {
      log('Raw data socket SavedAddress: $data');
      try {
        if (data is Map<String, dynamic>) {
          SavedAddressModel savedAddress = SavedAddressModel.fromJson(data);
          isLoading = false;
          notifyListeners();
        } else {
          log('Received unexpected data format SavedAddress');
        }
      } catch (e) {
        log('Error parsing socket data SavedAddressModel: $e');
        isLoading = false;
        notifyListeners();
      }
    });
  }

  bool isLoadingNearBy = false;

  //* Emit & Listen Nearby Address
  void emitAndListenNearBy({
    required SocketProvider socketProvider,
    double? lat,
    double? long,
  }) async {
    isLoadingNearBy = true;
    notifyListeners();
    Map<String, dynamic> data = {
      "latitude": lat,
      "longitude": long,
    };
    log('NearBy data is: $data');
    socketProvider.emitEvent(SocketEvents.nearByLocationEventName, data);
    socketProvider.listenToEvent(SocketEvents.nearByLocationListen, (data) {
      try {
        log('Raw data socket NearBy: $data');

        if (data is Map<String, dynamic>) {
          NearByAddressModel savedAddress = NearByAddressModel.fromJson(data);
          isLoadingNearBy = false;
          notifyListeners();
        } else {
          log('Received unexpected data format NearBy');
        }
      } catch (e) {
        log('Error parsing socket data NearBy: $e');
        isLoadingNearBy = false;
        notifyListeners();
      }
    });
  }
}
