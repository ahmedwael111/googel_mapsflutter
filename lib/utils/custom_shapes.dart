import 'package:flutter/material.dart';
import 'package:flutterwithgooglemap/models/places_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomShapes {
  Set<Marker> markers = {};
  Set<Polyline> polinies = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};
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
    // setState(() {});
  }

  void initPolinies() {
    Polyline polyline = Polyline(
      polylineId: const PolylineId('1'),
      color: Colors.red,
      width: 5,
      zIndex: 2,
      startCap: Cap.roundCap,
      points: [
        LatLng(30.54070320743897, 31.368692763051207),
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