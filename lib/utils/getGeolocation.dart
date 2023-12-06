// location_service.dart

// ignore_for_file: use_rethrow_when_possible, avoid_print, file_names

import 'package:geolocator/geolocator.dart';

class GeolocationUtils {
  static Future<Position> getGeoLocationPosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw 'Location service Not Enabled';
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permission denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permission denied forever, we cannot access';
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("Error getting location: $e");
      throw e;
    }
  }
}
