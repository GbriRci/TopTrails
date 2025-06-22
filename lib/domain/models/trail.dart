// Modello dei percorsi
import 'package:latlong2/latlong.dart';

class Trail {
  final String id;
  final String name;
  final int length;
  final String grade;
  final String surface;
  final String type;
  final bool loop;
  final List<LatLng> geometry;

  const Trail({
    required this.id,
    required this.name,
    required this.length,
    required this.grade,
    required this.surface,
    required this.type,
    required this.loop,
    required this.geometry,
  });

  @override
  String toString() {
    return "Id: $id, Name: $name, Lenght: $length, Grade: $grade, Surface: $surface, Type: $type, Loop: $loop, Geometry: $geometry";
  }
}
