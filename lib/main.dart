import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

import 'package:main/common/authentication/authentication_cubit.dart';
import 'package:main/common/location/location_bloc.dart';
import 'package:main/data/overpass_api_service.dart';
import 'package:main/l10n/app_localizations.dart';
import 'package:main/domain/models/app_theme.dart';
import 'package:main/presentation/routes/routes.dart';
import 'package:main/common/theme/theme_bloc.dart';
import 'package:main/common/theme/theme_state.dart';
import 'package:main/common/trail/trail_bloc.dart';
import 'package:main/presentation/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://uvbsrcalcmbvwhdewmgm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV2YnNyY2FsY21idndoZGV3bWdtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA1MTU2NTcsImV4cCI6MjA2NjA5MTY1N30._Z2E_60IFRa9kRuqBEOHy92zubc5UuBy2w596NFTgXQ',
  );

  final initialTheme = await ThemeBloc.loadThemeFromPrefs();

  runApp(MyApp(initialTheme: initialTheme));
}

class MyApp extends StatelessWidget {
  final AppTheme initialTheme;
  const MyApp({super.key, required this.initialTheme});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider<LocationBloc>(create: (context) => LocationBloc()),
        BlocProvider<TrailBloc>(
          create: (context) => TrailBloc(apiService: OverpassApiService()),
        ),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc(initialTheme)),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            locale: Locale('it'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                state.theme == AppTheme.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            title: 'Top Trails',
          );
        },
      ),
    );
  }
}
