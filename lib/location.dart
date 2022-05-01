import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
class Location {
  double longitude = 0;
  double latitude = 0;
  Future<void> fuck() async {
    Position a = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    longitude = a.longitude;
    latitude = a.latitude;
  }
}
