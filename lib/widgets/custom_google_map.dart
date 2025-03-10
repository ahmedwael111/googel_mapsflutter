import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(30.535924242653955, 31.37988834664815),
      zoom: 10,
    );
    super.initState();
  }

  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            initialCameraPosition: initialCameraPosition,
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                southwest: LatLng(30.447115811757914, 31.20534317413323),
                northeast: LatLng(30.736146431967974, 31.678369192780483),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 90,
            child: ElevatedButton(
              onPressed: () {
                googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    const CameraPosition(
                      target: LatLng(30.531748913625503, 31.38476543450614),

                      zoom: 15,
                    ),
                  ),
                );
              },
              child: const Text('HOME'),
            ),
          ),
        ],
      ),
    );
  }
}
// world view 0 -> 3
 // country view 4-> 6
 // city view 10 -> 12
 // street view 13 -> 17
 // building view 18 -> 20