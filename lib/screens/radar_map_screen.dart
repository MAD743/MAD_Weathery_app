import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RadarMapScreen extends StatelessWidget {
  final String mapboxAccessToken = 'YOUR_MAPBOX_ACCESS_TOKEN_HERE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Radar Map')),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(37.7749, -122.4194), // Default San Francisco
          zoom: 8.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/mapbox/satellite-v9/tiles/256/{z}/{x}/{y}@2x?access_token=$mapboxAccessToken",
            additionalOptions: {'accessToken': mapboxAccessToken},
          ),
        ],
      ),
    );
  }
}
