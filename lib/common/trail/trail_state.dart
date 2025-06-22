//Gestione degli stati della lista di percorsi
import 'package:main/domain/models/trail.dart';

class TrailState {
  final List<Trail> trails;
  final bool isLoading;
  final String? error;

  const TrailState({
    required this.trails,
    this.isLoading = false,
    this.error,
  });

  TrailState copyWith({
    List<Trail>? trails,
    bool? isLoading,
    String? error,
  }) {
    return TrailState(
      trails: trails ?? this.trails,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
