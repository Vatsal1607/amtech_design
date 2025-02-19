import 'dart:developer';

import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../core/utils/app_colors.dart';
import 'google_map_provider.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<GoogleMapProvider>(context, listen: false)
          .getCurrentLocation(context);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<GoogleMapProvider>().checkLocationOnResume(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleMapProvider>(context);
    const String accountType = 'business';

    return Scaffold(
      appBar: const CustomAppbarWithCenterTitle(
        backgroundColor: Colors.red,
        title: 'Google Map',
        accountType: accountType,
      ),
      body: provider.currentLocation == null
          ? const Center(
              child: CustomLoader(
              color: AppColors.primaryColor,
            ))
          : Consumer<GoogleMapProvider>(
              builder: (context, _, child) => Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) {
                      provider.mapController = controller;
                      provider.getCurrentLocation(
                          context); // Ensure location updates
                    },
                    initialCameraPosition: CameraPosition(
                      target: provider.currentLocation!,
                      zoom: 14,
                    ),
                    onCameraMove: provider.onCameraMove,
                    onCameraIdle: () {
                      //* Camera stops moving, use the new center position
                      log("Updated Location: ${provider.selectedLocation?.latitude}, ${provider.selectedLocation?.longitude},");
                    },
                    // markers: provider.markers,
                    myLocationEnabled:
                        true, // Show blue dot for current location
                    myLocationButtonEnabled: true, // Enable location button
                  ),
                  const Center(
                    child: Icon(Icons.location_pin,
                        color: AppColors.red, size: 40),
                  ),
                ],
              ),
            ),
    );
  }
}
