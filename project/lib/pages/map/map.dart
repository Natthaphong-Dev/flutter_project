import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
          // จุดเริ่มต้นแผนที่
          initialCenter: LatLng(
            16.8211,
            100.2659,
          ),

          // ระดับ Zoom
          initialZoom: 13,
        ),

        children: [
          // =========================
          // MAP TILE
          // =========================
          TileLayer(
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

            userAgentPackageName:
                'com.example.flutter_map',
          ),

          // =========================
          // MARKER
          // =========================
          MarkerLayer(
            markers: [
              Marker(
                point: const LatLng(
                  16.8211,
                  100.2659,
                ),

                width: 60,
                height: 60,

                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 50,
                ),
              ),

              Marker(
                point: const LatLng(
                  16.8150,
                  100.2630,
                ),

                width: 60,
                height: 60,

                child: const Icon(
                  Icons.location_pin,
                  color: Colors.blue,
                  size: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}