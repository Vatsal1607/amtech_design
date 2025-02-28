import 'dart:developer';
import 'package:amtech_design/models/saved_address_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constants/keys.dart';
import '../../../../models/nearby_address_model.dart';
import '../../../../services/local/shared_preferences_service.dart';
import '../../../provider/socket_provider.dart';

class SavedAddressProvider extends ChangeNotifier {
  List<NearByAddressList> filteredSearchLocationList = [];

  bool isLoadingSavedAddress = false;
  bool isFirstCall = true;
  List<SavedAddressList>? savedAddressList;

  //* Emit & Listen Saved Address
  void emitAndListenSavedAddress(SocketProvider socketProvider) async {
    isLoadingSavedAddress = true;
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
          savedAddressList = savedAddress.data;
          log('savedAddressList ${savedAddressList}');
          isLoadingSavedAddress = false;
          notifyListeners();
        } else {
          log('Received unexpected data format SavedAddress');
        }
      } catch (e) {
        log('Error parsing socket data SavedAddressModel: $e');
        isLoadingSavedAddress = false;
        notifyListeners();
      }
    });
  }

  bool isLoadingNearBy = false;
  List<NearByAddressList>? nearByAddressList;

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
    socketProvider.emitEvent(SocketEvents.nearByLocationEvent, data);
    socketProvider.listenToEvent(SocketEvents.nearByLocationListen, (data) {
      try {
        log('Raw data socket NearBy: $data');

        if (data is Map<String, dynamic>) {
          NearByAddressModel nearByAddress = NearByAddressModel.fromJson(data);
          if (nearByAddress.data != null && nearByAddress.data!.isNotEmpty) {
            nearByAddressList = nearByAddress.data;
            filteredSearchLocationList = nearByAddress.data ?? [];
            log('nearByAddressList from assign condition: ${nearByAddressList}');
            isLoadingNearBy = false;
            notifyListeners();
          }
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

  String formatDistance(double? distance) {
    if (distance == null) return "--";

    return distance % 1 == 0
        ? "${(distance * 10).toInt()} M away" // Convert to meters if whole number
        : "$distance KM away"; // Show as KM if decimal
  }

  double parseDouble(dynamic value) {
    if (value is double) return value; // If already double, return as is
    if (value is int) return value.toDouble(); // Convert int to double
    if (value is String) {
      return double.tryParse(value) ??
          0.0; // Try parsing string to double, fallback to 0.0
    }
    return 0.0; // Fallback in case of unexpected type
  }

  bool isLoadingSearchAddress = false;

  // List<NearByAddressList>? searchLocationList;

  //* Emit & Listen search Nearby Address
  void emitAndListenSearchLocation({
    required SocketProvider socketProvider,
    required String search,
    double? lat,
    double? long,
  }) async {
    isLoadingSearchAddress = true;
    notifyListeners();
    Map<String, dynamic> requestData = {
      "search": search,
      "userLat": lat,
      "userLon": long,
    };
    log('SearchLocation requestData: $requestData');
    socketProvider.emitEvent(SocketEvents.searchLocationEvent, requestData);
    socketProvider.listenToEvent(SocketEvents.searchLocationByGoogleListen,
        (data) {
      try {
        log('Raw data socket SearchLocation: $data');
        if (data is Map<String, dynamic>) {
          NearByAddressModel nearByAddress = NearByAddressModel.fromJson(data);
          if (nearByAddress.data != null && nearByAddress.data!.isNotEmpty) {
            // searchLocationList = nearByAddress.data;
            filteredSearchLocationList = nearByAddress.data ?? [];
            log('SearchLocation from assign condition: ${filteredSearchLocationList}');
            isLoadingSearchAddress = false;
            notifyListeners();
          }
        } else {
          log('Received unexpected data form SearchLocation');
        }
      } catch (e) {
        log('Error parsing socket data SearchLocation: $e');
        isLoadingSearchAddress = false;
        notifyListeners();
      }
    });
  }

  //* Search Location functionality
  void onSearchChanged({
    required String value,
    required SocketProvider socketProvider,
    double? lat,
    double? long,
  }) {
    if (value.isNotEmpty) {
      if (value.length % 3 == 0) {
        //* Call API every 3rd character
        emitAndListenSearchLocation(
          socketProvider: socketProvider,
          search: value,
          lat: lat,
          long: long,
        );
        notifyListeners();
      }
      notifyListeners();
    } else {
      emitAndListenNearBy(
        socketProvider: socketProvider,
        lat: lat,
        long: long,
      );
      filteredSearchLocationList = [];
      notifyListeners();
    }
  }
}
