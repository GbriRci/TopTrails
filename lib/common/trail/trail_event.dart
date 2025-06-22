//Lista degli eventi 
abstract class TrailEvent {}

class TrailLoadRequested extends TrailEvent {
  final double lat;
  final double lon;
  TrailLoadRequested({required this.lat, required this.lon});
}