import 'package:flutter/material.dart';
import 'package:flutterwithgooglemap/models/places_model.dart';
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
    initMarker();
    initPolinies();
    initPolygons();
    initCircles();
    super.initState();
  }

  Set<Marker> markers = {};
  Set<Polyline> polinies = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};
  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: true,
            polylines: polinies,
            polygons: polygons,
            markers: markers,
            circles: circles,
            mapType: MapType.satellite,
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapStyle();
            },
            initialCameraPosition: initialCameraPosition,
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                southwest: LatLng(30.125967590301627, 30.53517875284858),
                northeast: LatLng(31.190412733238606, 32.37551305932879),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 290,
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

  void initMapStyle() async {
    var mapStyleDark = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/maps_styles/map_dark_style.json');
    // ignore: deprecated_member_use
    googleMapController.setMapStyle(mapStyleDark);
  }

  void initMarker() async {
    var customMarkerIcon = await BitmapDescriptor.asset(
      width: 50,
      height: 50,
      const ImageConfiguration(),
      'assets/maps_styles/images/location-pin.png',
    );
    var myMarkers =
        mosquesPlaces
            .map(
              (placeModel) => Marker(
                icon: customMarkerIcon,

                position: placeModel.latLng,
                markerId: MarkerId(placeModel.id.toString()),
                infoWindow: InfoWindow(title: placeModel.name),
              ),
            )
            .toSet();

    markers.addAll(myMarkers);
    setState(() {});
  }

  void initPolinies() {
    Polyline polyline = Polyline(
      polylineId: const PolylineId('1'),
      color: Colors.red,
      width: 5,
      zIndex: 2,
      startCap: Cap.roundCap,
      points: [
        LatLng(30.519182937909576, 31.39761146427662),
        LatLng(30.53814195786214, 31.381663642722387),
        LatLng(30.582134289972924, 31.491501182730598),
        LatLng(30.7489369006646, 31.422782957810053),
      ],
    );
    Polyline polyline2 = Polyline(
      polylineId: const PolylineId('2'),
      color: Colors.white,
      zIndex: 1,
      width: 5,
      startCap: Cap.roundCap,
      points: [
        LatLng(30.527384919942765, 31.446736969550674),
        LatLng(30.572944251115068, 31.358333091091456),
      ],
    );
    polinies.add(polyline);
    polinies.add(polyline2);
  }

  void initPolygons() {
    Polygon polygon = Polygon(
      holes: [
        [
          LatLng(30.9715795535707, 31.283477250578503),
          LatLng(31.127237314486646, 31.32106825503933),
          LatLng(31.044072596347814, 31.458901938062347),
        ],
      ],
      fillColor: Colors.black38,
      strokeWidth: 5,
      polygonId: const PolygonId('1'),
      points: [
        LatLng(30.97301722696273, 31.745629259578724),
        LatLng(31.4041468608422, 31.09826227558601),
        LatLng(30.82010469397158, 31.003593554808173),
      ],
    );
    polygons.add(polygon);
  }

  void initCircles() {
    Circle circle = Circle(
      circleId: const CircleId('1'),
      center: LatLng(30.55583398051956, 31.00471696925325),
      radius: 10000,
      fillColor: Colors.black38,
      strokeWidth: 5,
    );
    circles.add(circle);
  }
}

// world view 0 -> 3
// country view 4-> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20
