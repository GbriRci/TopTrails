import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:main/domain/models/app_theme.dart';
import 'package:main/common/theme/theme_event.dart';
import 'package:main/common/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

//bloc che gestisce il tema dell'app: ThemeEvent è l'evento che viene emesso quando si cambia il tema, e ThemeState è lo stato del bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc([AppTheme initialTheme = AppTheme.light])
    : super(ThemeState(theme: initialTheme)) {
    on<ThemeToggled>(_onThemeToggled);
  }

  //funzione che gestisce l'evento di cambio tema (emette un nuovo stato)
  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    final newTheme =
        state.theme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme', newTheme.name);
    emit(state.copyWith(themeNew: newTheme));
  }

  static Future<AppTheme> loadThemeFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final themeString = prefs.getString('app_theme');
  if (themeString == AppTheme.dark.name) return AppTheme.dark;
  if (themeString == AppTheme.light.name) return AppTheme.light;
  return AppTheme.light;
}
}
