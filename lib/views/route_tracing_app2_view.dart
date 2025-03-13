import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteTracingApp2 extends StatelessWidget {
  const RouteTracingApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.535924242653955, 31.37988834664815),
          zoom: 17,
        ),
      ),
    );
  }
}
