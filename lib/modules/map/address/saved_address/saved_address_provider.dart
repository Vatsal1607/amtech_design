import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:amtech_design/models/saved_address_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants/keys.dart';
import '../../../../models/nearby_address_model.dart';
import '../../../../services/local/shared_preferences_service.dart';
import '../../../../services/network/api_service.dart';
import '../../../provider/socket_provider.dart';

class SavedAddressProvider extends ChangeNotifier {
  List<NearByAddressList> filteredSearchLocationList = [];

  bool isLoadingSavedAddress = false;
  bool isFirstCall = true;
  List<SavedAddressList> savedAddressList = []; // Not nullable

  //* Emit & Listen Saved Address
  void emitAndListenSavedAddress(SocketProvider socketProvider) async {
    log('emitAndListenSavedAddress called');
    log('isSocketConnected: ${socketProvider.isConnected}');
    isLoadingSavedAddress = true;
    notifyListeners();
    final userId = sharedPrefsService.getString(SharedPrefsKeys.userId);
    final lat = sharedPrefsService.getString(SharedPrefsKeys.currentLat);
    final long = sharedPrefsService.getString(SharedPrefsKeys.currentLong);
    final accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType);
    Map<String, dynamic> data = {
      "userId": userId,
      "role": accountType == 'business' ? 0 : 1,
      "deviceId": sharedPrefsService.getString(SharedPrefsKeys.deviceId),
      "socketId": socketProvider.socket.id,
    };
    if (isFirstCall) {
      data["latitude"] = lat;
      data["longitude"] = long;
      data["isFirst"] = true;
      data["role"] = accountType == 'business' ? 0 : 1;
      data["deviceId"] = sharedPrefsService.getString(SharedPrefsKeys.deviceId);
      data["socketId"] = socketProvider.socket.id;
      isFirstCall = false; //* Set to false after first call
    }
    log('request Data: $data');
    socketProvider.emitEvent(SocketEvents.saveAddressEventName, data);
    socketProvider.listenToEvent(SocketEvents.searchSavedLocationListen,
        (data) {
      log('Raw data socket SavedAddress: $data');
      try {
        if (data is Map<String, dynamic>) {
          SavedAddressModel savedAddress = SavedAddressModel.fromJson(data);
          savedAddressList = savedAddress.data ?? [];
          log('savedAddressList $savedAddressList');
        } else {
          log('Received unexpected data format SavedAddress');
          savedAddressList = []; // Set explicitly if format is wrong
        }
      } catch (e) {
        log('Error parsing socket data SavedAddressModel: $e');
        savedAddressList = []; // Also clear in case of error
      } finally {
        isLoadingSavedAddress = false;
        notifyListeners();
      }
    });
  }

  bool isLoadingNearBy = false;
  List<NearByAddressList>? nearByAddressList;

  //* Emit & Listen Nearby Address
  //! Currently not used
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
    log('NearBy data is:----- $data');
    socketProvider.emitEvent(SocketEvents.nearByLocationEvent, data);
    socketProvider.listenToEvent(SocketEvents.nearByLocationListen, (data) {
      try {
        log('Raw data socket NearBy: $data');

        if (data is Map<String, dynamic>) {
          NearByAddressModel nearByAddress = NearByAddressModel.fromJson(data);
          if (nearByAddress.data != null && nearByAddress.data!.isNotEmpty) {
            nearByAddressList = nearByAddress.data;
            filteredSearchLocationList = nearByAddress.data ?? [];
            log('nearByAddressList from assign condition: $nearByAddressList');
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

  //* Normalize & Store Distance Always in KM
  double normalizeDistance(dynamic distance) {
    if (distance == null) return 0.0;
    final doubleValue = double.tryParse(distance.toString()) ?? 0.0;
    // If value is a whole number and >= 100, assume it's in meters
    if (doubleValue % 1 == 0) {
      return doubleValue / 1000; // convert meters to KM
    }
    // Otherwise, assume it's already in KM
    return doubleValue;
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
            log('SearchLocation from assign condition: $filteredSearchLocationList');
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

  ApiService apiService = ApiService();

  //* chooseLocation
  Future chooseLocation({
    required BuildContext context,
    required String address,
  }) async {
    // isEditLocationLoading = true;
    // notifyListeners();
    try {
      final userId = sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      final res = await apiService.chooseLocation(
        userId: userId,
        address: address,
      );
      if (res.success == true) {
        Navigator.pop(context);
        log('chooseLocation message: ${res.message}');
        return true; // Indicate success
      } else {
        log('${res.message}');
        return false; // Indicate failure
      }
    } catch (e) {
      debugPrint("Error chooseLocation: ${e.toString()}");
      return false; // Indicate failure
    } finally {
      // isEditLocationLoading = false;
      notifyListeners();
    }
  }

  // editAddress
  Future editAddress({
    required BuildContext context,
    required String addressId,
    String? propertyNumber,
    String? residentialAddress,
    String? nearLandmark,
    String? addressType,
    String? lat,
    String? long,
  }) async {
    // isEditLocationLoading = true;
    // notifyListeners();
    try {
      final userId = sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      Map<String, dynamic> requestBody = {
        "propertyNumber": "",
        "residentialAddress": "",
        "nearLandmark": "",
        "addressType": "",
        "lat": "",
        "long": "",
      };

      final res = await apiService.editAddress(
        userId: userId,
        addressId: addressId,
        body: requestBody,
      );
      if (res.success == true) {
        Navigator.pop(context);
        log('editAddress message: ${res.message}');
        return true; // Indicate success
      } else {
        log('${res.message}');
        return false; // Indicate failure
      }
    } catch (e) {
      debugPrint("Error editAddress: ${e.toString()}");
      return false; // Indicate failure
    } finally {
      // isEditLocationLoading = false;
      notifyListeners();
    }
  }

  bool isLoadingDeleteAddress = false;
  // Delete Address
  Future deleteAddress({
    required BuildContext context,
    required String addressId,
    required SocketProvider socketProvider,
  }) async {
    isLoadingDeleteAddress = true;
    notifyListeners();
    try {
      final userId = sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      final res = await apiService.deleteAddress(
        userId: userId,
        addressId: addressId,
      );
      if (res.success == true) {
        emitAndListenSavedAddress(socketProvider);
        customSnackBar(
          context: context,
          message: '${res.message}',
          backgroundColor: AppColors.white,
          textColor: AppColors.black,
        );
        log('deleteAddress message: ${res.message}');
        return true; // Indicate success
      } else {
        log('deleteAddress message: ${res.message}');
        return false; // Indicate failure
      }
    } catch (e) {
      debugPrint("Error deleteAddress: ${e.toString()}");
      return false; // Indicate failure
    } finally {
      isLoadingDeleteAddress = false;
      notifyListeners();
    }
  }
}
