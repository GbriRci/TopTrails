import 'dart:math';
import 'package:latlong2/latlong.dart';

class OverpassDataUtils {
  //funzione per calcolare la distanza tra due punti sulla superficie terrestre
  static double haversine(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000;
    final dLat = (lat2 - lat1) * pi / 180;
    final dLon = (lon2 - lon1) * pi / 180;
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) *
            cos(lat2 * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  static int calculateLength(List geometry) {
    double length = 0.0;
    for (int i = 1; i < geometry.length; i++) {
      final prev = geometry[i - 1];
      final curr = geometry[i];
      length += haversine(prev['lat'], prev['lon'], curr['lat'], curr['lon']);
    }
    return length.round();
  }

  //controllo se il punto di partenza e arrivo sono vicini tra loro
  static bool isLoopTrail(List<LatLng> points) {
    if (points.length < 2) return false;
    final Distance distance = Distance();
    final double dist = distance(points.first, points.last);
    return dist < 200;
  }
}
