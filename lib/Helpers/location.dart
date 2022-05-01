import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double longitude = 0;
  double latitude = 0;
  Future<void> GetLocation() async {
    Position a = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    longitude = a.longitude;
    latitude = a.latitude;
  }
}
