import 'dart:async';
import 'dart:developer';
import 'package:amtech_design/core/utils/enums/enums.dart';
import 'package:amtech_design/custom_widgets/custom_confirm_dialog.dart';
import 'package:amtech_design/models/location_model.dart';
import 'package:amtech_design/modules/map/address/saved_address/saved_address_provider.dart';
import 'package:amtech_design/modules/provider/socket_provider.dart';
import 'package:amtech_design/routes.dart';
import 'package:amtech_design/services/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constants/keys.dart';
import '../../models/edit_location_model.dart';
import '../../models/edit_location_request_model.dart' as request_model;
import '../../services/local/shared_preferences_service.dart';
import '../menu/menu_provider.dart';

class GoogleMapProvider extends ChangeNotifier {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  LatLng? selectedLocation;
  Set<Marker> markers = {};

  onCameraMove(position) {
    selectedLocation = position.target; //* Update marker position dynamically
    notifyListeners();
  }

  //* show Selected Location in map
  Future<void> showSelectedLocationAddressCard({
    required double latitude,
    required double longitude,
    required BuildContext context,
    bool isNavigateHome = false,
  }) async {
    if (isNavigateHome) {
      Navigator.pop(context);
    }
    if (mapController != null) {
      if (!isNavigateHome) {
        Navigator.pop(context);
      }
      LatLng location = LatLng(latitude, longitude);
      await mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: location,
            zoom: 14,
            bearing: 60,
            tilt: 45,
          ),
        ),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      await mapController?.animateCamera(CameraUpdate.zoomTo(18));
      selectedLocation = location;
      currentLocation = location;
      log("Selected Location: $latitude, $longitude");
    }
  }

  bool isCheckedHome = true;
  bool isCheckedWork = false;
  bool isCheckedOther = false;
  String addressType = AddressType.Home.name;

  onChangedHome(bool? value) {
    isCheckedHome = value ?? false;
    if (isCheckedHome) {
      addressType = AddressType.Home.name;
      isCheckedWork = false;
      isCheckedOther = false;
    }
    notifyListeners();
  }

  onChangedWork(bool? value) {
    isCheckedWork = value ?? false;
    if (isCheckedWork) {
      addressType = AddressType.Work.name;
      isCheckedHome = false;
      isCheckedOther = false;
    }
    notifyListeners();
  }

  onChangedOther(bool? value) {
    isCheckedOther = value ?? false;
    if (isCheckedOther) {
      addressType = AddressType.Other.name;
      isCheckedHome = false;
      isCheckedWork = false;
    }
    notifyListeners();
  }

  bool isLoading = false;

  Future<void> getCurrentLocation({
    BuildContext? context,
    SocketProvider? socketProvider,
    LatLng? editAddressLatLng,
  }) async {
    isLoading = true;
    notifyListeners();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLoading = false;
      notifyListeners();
      if (context != null) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomConfirmDialog(
              title: 'Location Required',
              subTitle:
                  'Location services are disabled. Please enable them in settings.',
              accountType:
                  sharedPrefsService.getString(SharedPrefsKeys.accountType) ??
                      '',
              yesBtnText: 'Open Settings',
              onTapYes: () async {
                Navigator.pop(context);
                await Geolocator.openLocationSettings();
              },
            );
          },
        );
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLoading = false; // Stop loader
        notifyListeners();
        return Future.error(
            "Location permission denied from getCurrentLocation.");
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
    if (currentLocation != null) {
      sharedPrefsService.setString(SharedPrefsKeys.currentLat,
          currentLocation?.latitude.toString() ?? '');
      sharedPrefsService.setString(SharedPrefsKeys.currentLong,
          currentLocation?.longitude.toString() ?? '');
    }
    // * Prioritize `editAddressLatLng`
    LatLng targetLocation = editAddressLatLng ?? currentLocation!;
    // * Emit socket event with the correct location
    if (socketProvider != null) {
      //* Socket get location
      emitAndListenGetLocation(
        socketProvider: socketProvider,
        editLat: targetLocation.latitude,
        editLong: targetLocation.longitude,
      );
      notifyListeners();
    }
    // * Update marker and move camera to the selected location
    updateMarker(targetLocation);
    Future.delayed(const Duration(milliseconds: 100), () {
      moveCamera(targetLocation);
    });
    isLoading = false;
    notifyListeners();
  }

  void updateMarkerLocation(LatLng newPosition) {
    currentLocation = newPosition;
    updateMarker(newPosition);
    notifyListeners();
  }

  //* UpdateMarker
  void updateMarker(LatLng position) {
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

  final Completer<GoogleMapController> mapControllerCompleter = Completer();

  //* move Camera
  Future<void> moveCamera(LatLng position) async {
    log('move camera latlong: ${position.latitude} ${position.longitude}');
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (mapController != null) {
        await mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: position,
              zoom: 14,
            ),
          ),
        );
      }
    });
  }

  Future<void> checkLocationOnResume(BuildContext context) async {
    if (await Geolocator.isLocationServiceEnabled()) {
      await getCurrentLocation(
        context: context,
        editAddressLatLng: null,
      );
    }
  }

  String? address;
  String? distance;
  bool isFirstCall = true;

  //* Socket Get location
  void emitAndListenGetLocation({
    required SocketProvider socketProvider,
    double? editLat,
    double? editLong,
  }) async {
    isLoading = true;
    notifyListeners();
    final accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType);
    final lat = editLat ?? selectedLocation?.latitude;
    final long = editLong ?? selectedLocation?.longitude;
    Map<String, dynamic> data = {
      "userId": sharedPrefsService.getString(SharedPrefsKeys.userId),
      "socketId": socketProvider.socket.id,
      'deviceId': sharedPrefsService.getString(SharedPrefsKeys.deviceId),
      "latitude": lat.toString(),
      "longitude": long.toString(),
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
          addressController.text = location.data?.address ?? '';
          distance = location.data?.distance.toString();
          // * Prevent overriding edited lat/long
          if (editLat == null && editLong == null) {
            if (selectedLocation?.latitude != location.data?.latitude ||
                selectedLocation?.longitude != location.data?.longitude) {
              selectedLocation = LatLng(
                  double.parse(location.data!.latitude.toString()),
                  double.parse(location.data!.longitude.toString()));
              // moveCamera(selectedLocation!);
            }
          } else {
            selectedLocation = LatLng(editLat!, editLong!);
            // moveCamera(selectedLocation!);
          }
          isLoading = false;
          notifyListeners();
        } else {
          log('Received unexpected data format');
        }
      } catch (e) {
        log('Error parsing socket data: $e');
        isLoading = false;
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
  Future<void> editLocation({
    required BuildContext context,
    required SavedAddressProvider savedAddressProvider,
    required SocketProvider socketProvider,
  }) async {
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
              addressType: addressType,
              suggestAddress: addressController.text,
              lat: selectedLocation?.latitude,
              long: selectedLocation?.longitude,
            ),
          ],
        ),
      );
      if (res.success == true) {
        sharedPrefsService.setString(
            SharedPrefsKeys.selectedAddress, addressController.text);
        floorController.clear();
        companyController.clear();
        landmarkController.clear();
        //* Emit saved address event
        savedAddressProvider.emitAndListenSavedAddress(socketProvider);
        Navigator.popUntil(context, ModalRoute.withName(Routes.bottomBarPage));
        context.read<MenuProvider>().homeMenuApi(); //* API call
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
}
