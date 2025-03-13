import 'package:location/location.dart' show Location, LocationData, PermissionStatus;

class LocationService {
  Location location = Location();
  Future<bool> chickAndRequestService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> chickAndRequestPermission() async {
    var permissionStates = await location.hasPermission();
    if (permissionStates == PermissionStatus.deniedForever) {
      // show dialog error
      return false;
    }
    if (permissionStates == PermissionStatus.denied) {
      permissionStates = await location.requestPermission();

      return permissionStates == PermissionStatus.granted;
    }
    return true;
  }

  void gitLocationData(void Function(LocationData)? onData) {
    location.changeSettings(distanceFilter: 1);
    location.onLocationChanged.listen(onData);
  }
}
