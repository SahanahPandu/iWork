import 'dart:convert';

class DriverLocation {
  final String? dateTime;
  final double? lat, long;

  DriverLocation({
    this.dateTime,
    this.lat,
    this.long,
  });

  factory DriverLocation.fromJson(Map<String, dynamic> jsonData) {
    return DriverLocation(
      dateTime: jsonData['dateTime'],
      lat: jsonData['latitude'],
      long: jsonData['longitude'],
    );
  }

  static Map<String, dynamic> toMap(DriverLocation loc) => {
        'dateTime': loc.dateTime,
        'latitude': loc.lat,
        'longitude': loc.long,
      };

  static String encodeOfflinePositions(List<DriverLocation> locs) => json.encode(
        locs
            .map<Map<String, dynamic>>((loc) => DriverLocation.toMap(loc))
            .toList(),
      );

  static List<DriverLocation> decodeOfflinePositions(String locs) =>
      (json.decode(locs) as List<dynamic>)
          .map<DriverLocation>((item) => DriverLocation.fromJson(item))
          .toList();
}
