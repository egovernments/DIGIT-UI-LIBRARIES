import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationFetchBloc {
  Future<void> getCurrentLocation(TextEditingController controller, void Function(String)? onChange) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      /// Request location permission
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      /// Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      /// Update the text controller with the current location
      controller.text = "${position.latitude}, ${position.longitude}";

      if (onChange != null) {
        onChange(controller.text);
      }
    }
  }
}