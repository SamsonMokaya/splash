import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'base_geolocation_repository.dart';

class GeolocationRepository extends BaseGeolocationRepository {
  GeolocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    PermissionStatus permission = await Permission.location.status;
    if (permission != PermissionStatus.granted) {
      await Permission.location.request();
      permission = await Permission.location.status;
    }
    if (permission == PermissionStatus.granted) {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } else {
      throw Exception('Location permission not granted');
    }
  }
}
