import 'package:latlong2/latlong.dart';

class MapCenter {
  static double getCenterLat(List<LatLng> points) {
    if (points.isEmpty) return 0.0;
    double latSum = 0.0;
    for (final point in points) {
      latSum += point.latitude;
    }
    final centerLat = latSum / points.length;

    return centerLat;
  }

  static double getCenterLng(List<LatLng> points) {
    if (points.isEmpty) return 0.0;
    double lngSum = 0.0;
    for (final point in points) {
      lngSum += point.longitude;
    }
    final centerLng = lngSum / points.length;

    return centerLng;
  }
}
