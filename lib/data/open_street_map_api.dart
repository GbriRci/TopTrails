import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class OpenStreetMapApi {
  static Future<LatLng?> coordinatesFromSearch(String query) async {
    if (query.trim().isEmpty) return null;
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1',
    );
    try {
      final response = await http.get(url, headers: {'User-Agent': 'TopTrail'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          return LatLng(lat, lon);
        }
      } else {
        debugPrint('Errore OSM: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Eccezione OSM: $e');
    }
    return null;
  }
}
