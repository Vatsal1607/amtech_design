import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapProvider extends ChangeNotifier {
  GoogleMapProvider() {
    requestLocationPermission();
  }

  GoogleMapController? mapController;
  final Set<Marker> markers = {};

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      debugPrint("Location permission granted");
    } else if (status.isDenied) {
      debugPrint("Location permission denied");
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // To open app settings to manually enable permission
    }
  }

  // Future<void> getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Check if location services are enabled
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Handle the case when location services are not enabled
  //     return Future.error('Location services are disabled.');
  //   }

  //   // Check for location permissions
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error('Location permissions are permanently denied');
  //   }

  //   // Get the current position
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   print(
  //       'Current Location: Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  // }
}
