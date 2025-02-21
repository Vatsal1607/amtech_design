import 'dart:developer';
import 'package:amtech_design/models/location_model.dart';
import 'package:amtech_design/modules/provider/socket_provider.dart';
import 'package:amtech_design/services/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/utils/constants/keys.dart';
import '../../models/edit_location.dart';
import '../../models/edit_location_request_model.dart' as request_model;
import '../../services/local/shared_preferences_service.dart';

class GoogleMapProvider extends ChangeNotifier {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  Set<Marker> markers = {};
  LatLng? selectedLocation;

  onCameraMove(position) {
    selectedLocation = position.target; //* Update marker position dynamically
    notifyListeners();
  }

  bool isCheckedHome = false;
  bool isCheckedWork = false;
  bool isCheckedOther = false;
  String? addressType;

  onChangedHome(bool? value) {
    isCheckedHome = value ?? false;
    if (isCheckedHome) {
      isCheckedWork = false;
      isCheckedOther = false;
    }
    notifyListeners();
  }

  onChangedWork(bool? value) {
    isCheckedWork = value ?? false;
    if (isCheckedWork) {
      isCheckedHome = false;
      isCheckedOther = false;
    }
    notifyListeners();
  }

  onChangedOther(bool? value) {
    isCheckedOther = value ?? false;
    if (isCheckedOther) {
      isCheckedHome = false;
      isCheckedWork = false;
    }
    notifyListeners();
  }

  bool isLoading = false;

  Future<void> getCurrentLocation({
    BuildContext? context,
    SocketProvider? socketProvider,
  }) async {
    isLoading = true; // Set loader to true
    notifyListeners(); //
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLoading = false; // Stop loader
      notifyListeners();
      if (context != null) {
        _showLocationServiceDialog(context);
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLoading = false; // Stop loader
        notifyListeners();
        return Future.error("Location permission denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isLoading = false; // Stop loader
      notifyListeners();
      return Future.error("Location permission permanently denied.");
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentLocation = LatLng(position.latitude, position.longitude);
    if (socketProvider != null) {
      emitAndListenGetLocation(socketProvider);
      notifyListeners();
    }
    _updateMarker(currentLocation!);
    _moveCamera(currentLocation!);
    isLoading = false; // Stop loader
    notifyListeners();
  }

  void updateMarkerLocation(LatLng newPosition) {
    currentLocation = newPosition;
    _updateMarker(newPosition);
    notifyListeners();
  }

  void _updateMarker(LatLng position) {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: position,
        infoWindow: const InfoWindow(title: "Your Location"),
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onDragEnd: updateMarkerLocation,
      ),
    );
  }

  void _moveCamera(LatLng position) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 14),
      ),
    );
  }

  void _showLocationServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Required"),
        content: const Text(
          "Location services are disabled. Please enable them in settings.",
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
            },
            child: const Text("Open Settings"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Future<void> checkLocationOnResume(BuildContext context) async {
    if (await Geolocator.isLocationServiceEnabled()) {
      getCurrentLocation(context: context);
    }
  }

  String? address;
  String? distance;
  bool isFirstCall = true;

  //* Emit location
  void emitAndListenGetLocation(SocketProvider socketProvider) async {
    isLoading = true;
    notifyListeners();
    final accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType);

    Map<String, dynamic> data = {
      "userId": sharedPrefsService.getString(SharedPrefsKeys.userId),
      "socketId": socketProvider.socket.id,
      'deviceId': sharedPrefsService.getString(SharedPrefsKeys.deviceId),
      "latitude": selectedLocation?.latitude,
      "longitude": selectedLocation?.longitude,
      "role": accountType == 'business' ? '0' : '1',
    };

    if (isFirstCall) {
      data["isFirst"] = true;
      isFirstCall = false; //* Set to false after first call
    }
    log('userLocation data is: $data');
    socketProvider.emitEvent(SocketEvents.userLocation, data);

    socketProvider.listenToEvent(SocketEvents.realTimeLocationUpdate, (data) {
      try {
        log('Raw socket realTimeLocationUpdate data: $data');

        if (data is Map<String, dynamic>) {
          LocationModel location = LocationModel.fromJson(data);
          address = location.data?.address;
          distance = location.data?.distance.toString();
          log('Updated Address: $address');

          if (selectedLocation?.latitude != location.data?.latitude ||
              selectedLocation?.longitude != location.data?.longitude) {
            selectedLocation = LatLng(
                double.parse(location.data!.latitude.toString()),
                double.parse(location.data!.longitude.toString()));
          }

          isLoading = false; // Stop loading after receiving data
          notifyListeners(); // Update UI
        } else {
          log('Received unexpected data format');
        }
      } catch (e) {
        log('Error parsing socket data: $e');
        isLoading = false; // Stop loading even if there's an error
        notifyListeners();
      }
    });
  }

  TextEditingController addressController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  bool isEditLocationLoading = false;
  EditLocationModel? editLocationModel;
  ApiService apiService = ApiService();

  //* Edit location API
  Future<void> editLocation(
    BuildContext context,
  ) async {
    isEditLocationLoading = true;
    notifyListeners();
    try {
      final userId = sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      final accountType =
          sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
      final res = await apiService.editLocation(
        userId: userId,
        editLocationRequestModel: request_model.EditLocationRequestModel(
          role: accountType == 'business' ? 0 : 1,
          addresses: [
            request_model.Addresses(
              propertyNumber: floorController.text,
              residentialAddress: companyController.text,
              nearLandmark: landmarkController.text,
              addressType: '', //* checkbox
            ),
          ],
        ),
      );
      log('editLocation response: ${res.data}');
      if (res.success == true) {
        log('editLocation message: ${res.message}');
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error editLocation: ${e.toString()}");
    } finally {
      isEditLocationLoading = false;
      notifyListeners();
    }
  }

  // Future<void> editLocation({
  //   required String userId,
  //   required EditLocationRequestModel editLocationRequestModel,
  // }) async {
  //   isEditLocationLoading = true;
  //   notifyListeners();

  //   try {
  //     editLocationModel = await apiService.editLocation(
  //       userId: userId,
  //       editLocationRequestModel: editLocationRequestModel,
  //     );
  //   } catch (e) {
  //     debugPrint("Error: $e");
  //   }
  //   isEditLocationLoading = false;
  //   notifyListeners();
  // }
}
