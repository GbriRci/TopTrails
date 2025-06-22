import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:main/domain/models/folder.dart';
import 'package:main/presentation/routes/app_paths.dart';
import 'package:main/presentation/screens/edit_folder/edit_folder_page.dart';
import 'package:main/presentation/screens/folder/folder_page.dart';
import 'package:main/presentation/screens/image_picker/image_picker_page.dart';
import 'package:main/presentation/screens/login/login_page.dart';
import 'package:main/presentation/screens/registration/registration_page.dart';
import 'package:main/presentation/screens/home/home_page.dart';
import 'package:main/presentation/screens/profile/profile_page.dart';
import 'package:main/presentation/screens/settings/settings_page.dart';
import 'package:main/presentation/screens/trailDetails/trail_details_page.dart';
import 'package:main/presentation/screens/welcome/welcome_page.dart';

final GoRouter router = GoRouter(
  initialLocation: AppPaths.welcome,
  routes: <RouteBase>[
    GoRoute(
      path: AppPaths.home,
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: AppPaths.settings,
      builder: (BuildContext context, GoRouterState state) {
        return SettingsPage();
      },
    ),
    GoRoute(
      path: AppPaths.trailDetails,
      builder: (context, state) {
        return TrailDetailsPage();
      },
    ),
    GoRoute(
      path: AppPaths.profile,
      builder: (context, state) {
        return ProfilePage();
      },
    ),
    GoRoute(
      path: AppPaths.login,
      builder: (context, state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: AppPaths.register,
      builder: (context, state) {
        return RegistrationPage();
      },
    ),
    GoRoute(
      path: AppPaths.welcome,
      builder: (context, state) {
        return WelcomePage();
      },
    ),
    GoRoute(
      path: AppPaths.folder,
      builder: (context, state) {
        final folder = state.extra as Folder;
        return FolderPage(folder: folder);
      },
    ),
    GoRoute(
      path: AppPaths.editFolder,
      builder: (context, state) {
        final folder = state.extra as Folder;
        return EditFolderPage(folder: folder);
      },
    ),
    GoRoute(
      path: AppPaths.imagePicker,
      builder: (context, state) {
        return ImagePickerPage();
      },
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("404 Pagina non trovata"),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: Text(
                "Torna indietro",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  },
);
