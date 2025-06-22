//Emetto gli stati e eventi
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:main/common/trail/trail_event.dart';
import 'package:main/common/trail/trail_state.dart';
import 'package:main/data/overpass_api_service.dart';

class TrailBloc extends Bloc<TrailEvent, TrailState> {
  final OverpassApiService apiService;

  TrailBloc({required this.apiService}) : super(const TrailState(trails: [])) {
    on<TrailLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    TrailLoadRequested event,
    Emitter<TrailState> emit,
  ) async {
    //chiedo i permessi di localizzazione prima di procedere
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      emit(
        state.copyWith(isLoading: false, error: 'Permesso posizione negato'),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));
    try {
      final trails = await apiService.trailGetter(
        lat: event.lat,
        lon: event.lon,
      );
      emit(state.copyWith(trails: trails, isLoading: false, error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Errore nel caricamento'));
    }
  }
}
