
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesModel {
  final String name;
  final String id;
  final LatLng latLng;

  PlacesModel({required this.name, required this.id, required this.latLng});
}


 List<PlacesModel> mosquesPlaces = [
  PlacesModel(
    name: 'مسجد الحرمين',
    id: '1',
    latLng: const LatLng(30.534805540837525, 31.38215114152525),
  ),
  PlacesModel(
    name: 'مسجد المصطفي',
    id: '2',
    latLng: const LatLng(30.510284767587372, 31.346786513201003),
  ),
  PlacesModel(
    name: 'مسجد بن عنان',
    id: '3',
    latLng: const LatLng(30.53189952244665, 31.38647141770929),
  ),
];