import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapController extends GetxController {
  late GoogleMapController mapController;
  late CameraPosition initialCameraPosition;
  late List<String> postalCodes;
  var waypointsLatLong = List<LatLng>.from([]).obs;
  var waypointsAddress = List<String>.from([]).obs;
  var center = const LatLng(1.30822042654265, 103.773315219931).obs;
  var currLat = 0.00.obs;
  var currLong = 0.00.obs;
  var currAddress = "".obs;
  var isLoading = false.obs;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = Set<Polyline>();
  var currentStep = 0;

  var waypoints = data[routeId];
  var markers = Set<Marker>.from({}).obs;

  void onMapCreated(GoogleMapController controller) {
    isLoading.value = true;
    mapController = controller;
    setPolyLines();
    initialCameraPosition = CameraPosition(target: center.value, zoom: 15);
    isLoading.value = false;
  }

  void setPolyLines() async {
    for (var i = 0; i < waypointsLatLong.length - 1; i++) {
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
          "AIzaSyDv6v-bHlUOANCoX01U6wVh9y5UZNtskG4",
          PointLatLng(waypointsLatLong[i].latitude, waypointsLatLong[i].longitude),
          PointLatLng(waypointsLatLong[i+1].latitude, waypointsLatLong[i+1].longitude));

      if (result.status == "OK") {
        print("WOAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHASHADAHDHA");
        // print(result.points);
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude,point.longitude));
        });

        polylines.add(
            Polyline(
                width: 10,
                polylineId: PolylineId('polyLine'),
                color: Color(0xFF08A5CB),
                points: polylineCoordinates
            )
        );
      }
    }

  }

  Future<void> initialize() async {
    isLoading.value = true;
    postalCodes = List.from(waypoints!.keys);
    getLatLongForPostalCodesFromData();
    await getAddressForPostalCodesLatLong();
    populateWaypointsMarkers();
    isLoading.value = false;
  }

  void moveCameraToFirstWaypoint() async {
    mapController.animateCamera(
      CameraUpdate.newLatLng(waypointsLatLong[0]),
    );
  }
  // Future<void> getLatLongForPostalCodes() async {
  //   for (var i in postalCodes) {
  //     var location = await getCoordinatesFromPostalCode(i);
  //     waypointsLatLong.add(location);
  //   }
  // }

  void getLatLongForPostalCodesFromData() async {
    for (var i in postalCodes) {
      var location = getCoordinateFromPostalData(i);
      waypointsLatLong.add(location);
    }
  }

  LatLng getCoordinateFromPostalData(String postalCode) {
    var location = waypoints![postalCode]![0];
    dynamic deliveryPoint = location;
    return LatLng(deliveryPoint["latitude"], deliveryPoint["longitude"]);
  }

  Future<void> getAddressForPostalCodesLatLong() async {
    for (var i in waypointsLatLong) {
      var address = await getAddress(i.latitude, i.longitude);
      waypointsAddress.add(address);
    }
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

  void populateWaypointsMarkers() {
    for (var i in waypointsLatLong) {
      String coordinates =
          "(" + i.latitude.toString() + ", " + i.longitude.toString() + ")";
      var marker = Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId(coordinates),
          position: LatLng(i.latitude, i.longitude));
      markers.add(marker);
    }
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
      currAddress.value =
          await getAddress(position.latitude, position.longitude);
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
