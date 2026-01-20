import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsService {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json";

  final String apiKey;

  DirectionsService(this.apiKey);

  Future<List<LatLng>> getRoutePoints(LatLng origin, LatLng destination) async {
    final url =
        "$_baseUrl?origin=${origin.latitude},${origin.longitude}"
        "&destination=${destination.latitude},${destination.longitude}"
        "&mode=driving"
        "&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    print("Directions status: ${response.statusCode}");
    print("Directions body: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch directions");
    }

    final data = json.decode(response.body);

    if (data["routes"].isEmpty) {
      throw Exception("No routes found");
    }

    final encodedPolyline = data["routes"][0]["overview_polyline"]["points"];

    final polylinePoints = PolylinePoints()
        .decodePolyline(encodedPolyline)
        .map((p) => LatLng(p.latitude, p.longitude))
        .toList();

    return polylinePoints;
  }
}
