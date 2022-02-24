import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  late GoogleMapController mapController;
  late CameraPosition initialCameraPosition;
  var center = const LatLng(1.30822042654265, 103.773315219931).obs;

  void refocus() {
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition));
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    initialCameraPosition = CameraPosition(target: center.value, zoom: 15);
  }
}
