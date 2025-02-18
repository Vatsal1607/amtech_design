import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'google_map_provider.dart';

// class GoogleMapPage extends StatelessWidget {
//   const GoogleMapPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<GoogleMapProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Google Map')),
//       body: GoogleMap(
//         onMapCreated: (controller) {
//           provider.mapController = controller;
//         },
//         initialCameraPosition: const CameraPosition(
//           target: LatLng(37.7749, -122.4194), // San Francisco as an example
//           zoom: 10,
//         ),
//         markers: provider.markers,
//       ),
//     );
//   }
// }

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController mapController;

  final LatLng _center =
      const LatLng(37.7749, -122.4194); // Example coordinates (San Francisco)

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Example'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
