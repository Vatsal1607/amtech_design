import 'dart:convert';
import 'dart:developer';
import 'package:amtech_design/models/location_model.dart';
import 'package:amtech_design/modules/provider/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/utils/constants/keys.dart';
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

  Future<void> getCurrentLocation({
    BuildContext? context,
    SocketProvider? socketProvider,
  }) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context != null) {
        _showLocationServiceDialog(context);
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
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

  //* Emit location
  void emitAndListenGetLocation(SocketProvider socketProvider) async {
    final accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType);

    socketProvider.emitEvent(SocketEvents.userLocation, {
      'userId': sharedPrefsService.getString(SharedPrefsKeys.userId),
      "socketId": socketProvider.socket.id,
      "role": accountType == 'business' ? '0' : '1',
      'deviceId': sharedPrefsService.getString(SharedPrefsKeys.deviceId),
      "latitude": selectedLocation?.latitude,
      "longitude": selectedLocation?.longitude,
    });

    socketProvider.listenToEvent(SocketEvents.realTimeLocationUpdate, (data) {
      try {
        log('Raw socket realTimeLocationUpdate data: $data');
        // Ensure 'data' is a Map<String, dynamic>
        if (data is Map<String, dynamic>) {
          LocationModel location = LocationModel.fromJson(data);
          address = location.data?.address;
          log('Address: $address');
          // Notify listeners if this is inside a provider
          notifyListeners();
        } else {
          log('Received unexpected data format');
        }
      } catch (e) {
        log('Error parsing socket data: $e');
      }
    });
  }
}
