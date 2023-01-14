import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationP {
  double latitude = 0;

  double longitude = 0;

  Future<void> getLocation() async {
    Location location = Location();
    LocationData locationData;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    latitude = locationData.latitude ?? 0;
    longitude = locationData.longitude ?? 0;

    location.onLocationChanged.listen((LocationData currentLocation) async {
      locationData = await location.getLocation();

      latitude = locationData.latitude ?? 0;
      longitude = locationData.longitude ?? 0;
    });
  }
}
