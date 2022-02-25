import 'dart:convert';

class Waypoints {
  Waypoints({required this.waypoints});

  Map<String, List<DeliveryPoint>> waypoints;

  factory Waypoints.fromRawJson(String str) =>
      Waypoints.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Waypoints.fromJson(Map<String, dynamic> json) => Waypoints(
        waypoints: json["1480106"], // hard-coded value for route id
      );

  Map<String, dynamic> toJson() => {
        "waypoints": waypoints,
      };
}

class DeliveryPoint {
  DeliveryPoint({
    required this.driverId,
    required this.latitude,
    required this.longitude,
    required this.routeId,
    required this.zoneId,
  });

  int driverId;
  double latitude;
  double longitude;
  int routeId;
  int zoneId;

  factory DeliveryPoint.fromRawJson(String str) =>
      DeliveryPoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryPoint.fromJson(Map<String, dynamic> json) => DeliveryPoint(
        driverId: json["driver_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        routeId: json["route_id"],
        zoneId: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "driver_id": driverId,
        "latitude": latitude,
        "longitude": longitude,
        "route_id": routeId,
        "zone_id": zoneId,
      };
}
