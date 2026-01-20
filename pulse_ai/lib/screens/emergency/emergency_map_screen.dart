import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EmergencyMapScreen extends StatefulWidget {
  final bool isSelf;
  const EmergencyMapScreen({super.key, required this.isSelf});

  @override
  State<EmergencyMapScreen> createState() => _EmergencyMapScreenState();
}

class _EmergencyMapScreenState extends State<EmergencyMapScreen> {
  late GoogleMapController mapController;

  // 🔴 Mock user & hospital locations
  final LatLng userLocation = const LatLng(28.6139, 77.2090); // Delhi
  final LatLng hospitalLocation = const LatLng(28.6280, 77.2065);

  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setupMarkers();
    _setupMockRoute(); // 👈 real road route
  }

  void _setupMarkers() {
    _markers.add(
      Marker(
        markerId: const MarkerId("user"),
        position: userLocation,
        infoWindow: const InfoWindow(title: "You"),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId("hospital"),
        position: hospitalLocation,
        infoWindow: const InfoWindow(title: "Recommended Hospital"),
      ),
    );
  }

  void _setupMockRoute() {
    _polylines.clear();

    _polylines.add(
      Polyline(
        polylineId: const PolylineId("mock_route"),
        color: Colors.red,
        width: 6,
        patterns: [PatternItem.dash(20), PatternItem.gap(10)],
        points: [userLocation, hospitalLocation],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emergency Route")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: userLocation,
              zoom: 14,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (controller) {
              mapController = controller;
            },
          ),

          // ⏱ ETA Card
          Positioned(bottom: 24, left: 16, right: 16, child: _etaCard()),
        ],
      ),
    );
  }

  Widget _etaCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)],
      ),
      child: const Text(
        "Estimated Arrival: 8 minutes",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
