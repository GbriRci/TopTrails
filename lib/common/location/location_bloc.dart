import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:main/common/location/location_event.dart';
import 'package:main/common/location/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? _position;

  //eventi da chiamare
  LocationBloc() : super(LocationState()) {
    on<StartLocationTracking>(_onStartTracking);
    on<StopLocationTracking>(_onStopTracking);
    on<_LocationUpdated>(_onLocationUpdated);
  }

  Future<void> _onStartTracking(StartLocationTracking event, Emitter<LocationState> emit) async {
    //chiedo i permessi per la posizione
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return;

    // inizializzo lo stream per la posizione e chiudo eventuali precedenti
    await _position?.cancel();
    _position = Geolocator.getPositionStream(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 5, 
        foregroundNotificationConfig: ForegroundNotificationConfig(
          notificationText: 'Traking of location in progress',
          notificationTitle: 'TopTrail',
          enableWakeLock: true,
        ),
      ),
    ).listen((position) {
      add(_LocationUpdated(position));
    });

    emit(state.copyWith(isTracking: true));
  }

  //fermo il tracking della posizione
  Future<void> _onStopTracking(StopLocationTracking event, Emitter<LocationState> emit) async {
    await _position?.cancel();
    emit(state.copyWith(isTracking: false));
  }

  //quando la posizione viene aggiornata, emetto un evento
  Future<void> _onLocationUpdated(_LocationUpdated event, Emitter<LocationState> emit) async {
    emit(state.copyWith(position: event.position));
  }

  //chiudo la sottoscrizione dello stream quando il blocco viene chiuso
  @override
  Future<void> close() {
    _position?.cancel();
    return super.close();
  }
}

//qunado la posizione viene aggiornata, emetto un evento
class _LocationUpdated extends LocationEvent {
  final Position position;
  _LocationUpdated(this.position);
}
