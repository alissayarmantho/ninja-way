import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapController extends GetxController {
  late GoogleMapController mapController;
  late CameraPosition initialCameraPosition;
  late List<String> postalCodes;
  var center = const LatLng(1.30822042654265, 103.773315219931).obs;
  var currLat = 0.00.obs;
  var currLong = 0.00.obs;

  var waypoints = data[routeId];

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    initialCameraPosition = CameraPosition(target: center.value, zoom: 15);
    postalCodes = List.from(waypoints!.keys);
  }

  Future<Location> getCoordinatesFromPostalCode(String postalCode) async {
    List<Location> locations = await locationFromAddress(postalCode);
    return locations[0];
  }

  Future<String> getAddress(double lat, double long) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(lat, long);

      Placemark place = p[0];

      var address =
          "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

      return address;
    } catch (err) {
      Get.snackbar(
        "Fail to get address",
        "Please ensure that your GPS and internet connection are turned on",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    }
    return "";
  }

  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currLat.value = position.latitude;
      currLong.value = position.longitude;
      // For moving the camera to current location
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15.0,
          ),
        ),
      );
      // await _getAddress();
    }).catchError((err) {
      Get.snackbar(
        "Error Getting Current Location",
        err,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    });
  }
}
