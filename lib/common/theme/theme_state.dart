import 'package:main/domain/models/app_theme.dart';

/// classe che rappresenta lo stato del tema dell'app
class ThemeState {
  final AppTheme theme;

  ThemeState({required this.theme});

  //gli passo sempre gli stessi parametri del costruttore ma opzionali
  //se gli arriva lo cambia se no usa quello vecchio
  ThemeState copyWith({AppTheme? themeNew}) =>
      ThemeState(theme: themeNew ?? theme);
}
