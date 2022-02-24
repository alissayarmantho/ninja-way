import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninja_way/models/waypoint.dart';
import 'package:ninja_way/services/waypoints.dart';

class WaypointController extends GetxController {
  var waypoints = Waypoints(waypoints: {"random": []}).obs;
  var isLoading = false.obs;

  void fetchWaypoints() async {
    isLoading(true);

    try {
      await WaypointService.fetchWaypoints().then((res) {
        waypoints.value = res;
        Get.snackbar(
          "Success",
          "Successfully deleted contact",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }).catchError((err) {
        Get.snackbar(
          "Error Getting All Waypoints",
          err,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
      });
    } finally {
      isLoading(false);
    }
  }
}
