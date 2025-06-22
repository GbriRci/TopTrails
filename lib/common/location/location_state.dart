import 'package:geolocator/geolocator.dart';

class LocationState {
  final Position? position;
  final bool isTracking;

  LocationState({this.position, this.isTracking = false});

  LocationState copyWith({Position? position, bool? isTracking}) {
    return LocationState(
      position: position ?? this.position,
      isTracking: isTracking ?? this.isTracking,
    );
  }
}
