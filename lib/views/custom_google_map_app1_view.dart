import 'package:flutter/material.dart';
import 'package:flutterwithgooglemap/utils/custom_shapes.dart';
import 'package:flutterwithgooglemap/utils/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMapApp1 extends StatefulWidget {
  const CustomGoogleMapApp1({super.key});

  @override
  State<CustomGoogleMapApp1> createState() => _CustomGoogleMapApp1State();
}

class _CustomGoogleMapApp1State extends State<CustomGoogleMapApp1> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;
  late CustomShapes customShapes;
  bool firstRun = true;
  bool themeOn = false;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(30.535924242653955, 31.37988834664815),
      zoom: 1,
    );
    locationService = LocationService();
    customShapes = CustomShapes();
    upMyLocation();
    super.initState();
  }

  GoogleMapController? googleMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            polylines: customShapes.polinies,
            polygons: customShapes.polygons,
            markers: customShapes.markers,
            circles: customShapes.circles,
            mapType: themeOn ? MapType.satellite : MapType.normal,
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapStyle();
            },
            initialCameraPosition: initialCameraPosition,
            // cameraTargetBounds: CameraTargetBounds(
            //   LatLngBounds(
            //     southwest: LatLng(30.125967590301627, 30.53517875284858),
            //     northeast: LatLng(31.190412733238606, 32.37551305932879),
            //   ),
            // ),
          ),
          Positioned(
            bottom: 40,
            left: 15,
            child: FloatingActionButton(
              child: Icon(Icons.map_outlined),
              onPressed: () {
                setState(() {
                  themeOn = !themeOn;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void initMapStyle() async {
    var mapStyleDark = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/maps_styles/map_dark_style.json');
    // ignore: deprecated_member_use
    googleMapController!.setMapStyle(mapStyleDark);
  }

  void upMyLocation() async {
    await locationService.chickAndRequestService();
    var isGranted = await locationService.chickAndRequestPermission();
    if (isGranted) {
      locationService.gitLocationData((locationData) {
        setMyCameraPosition(locationData);
        setMyMarker(locationData);
      });
    }
  }

  void setMyCameraPosition(LocationData locationData) {
    if (firstRun) {
      var cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 22,
      );

      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      firstRun = false;
    } else {
      googleMapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );
    }
  }

  void setMyMarker(LocationData locationData) async {
    var myLiveIcon = await BitmapDescriptor.asset(
      width: 50,
      height: 50,
      const ImageConfiguration(),
      'assets/maps_styles/images/target.png',
    );
    var myMarker = Marker(
      icon: myLiveIcon,
      markerId: const MarkerId('myLocation'),
      anchor: const Offset(0.5, 0.5),
      position: LatLng(locationData.latitude!, locationData.longitude!),
      infoWindow: InfoWindow(title: 'My Location'),
    );
    customShapes.markers.add(myMarker);
    setState(() {});
  }
}
// giss work zoome level
// world view 0 -> 3
// country view 4-> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20

// 1- get location
// inquire about location service
 // request permission
 // get location
 // display