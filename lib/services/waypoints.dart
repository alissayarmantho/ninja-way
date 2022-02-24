import 'dart:convert';

import 'package:ninja_way/models/waypoint.dart';

import 'api_constants.dart';
import 'base_api.dart';

class WaypointService {
  static Future<Waypoints> fetchWaypoints() async {
    String url = baseApi + "/getExampleJson";
    try {
      var response = await BaseApi.get(url: url);
      var jsonString = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(Waypoints.fromJson(jsonString));
        return Waypoints.fromJson(jsonString);
      } else {
        return Future.error("Error getting waypoints");
      }
    } catch (e) {
      return Future.error("Getting all waypoints error");
    }
  }
}
