import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:main/data/firestore_api_service.dart';
import 'package:main/common/authentication/authentication_cubit.dart';
import 'package:main/domain/models/app_theme.dart';
import 'package:main/common/theme/theme_bloc.dart';
import 'package:main/common/theme/theme_event.dart';
import 'package:main/common/theme/theme_state.dart';
import 'package:main/l10n/app_localizations.dart';
import 'package:main/presentation/routes/app_paths.dart';
import 'package:main/presentation/utils/change_credentials.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Text(
          AppLocalizations.of(context)!.settingsTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 30,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppPaths.home);
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context)!.settingsPreferences,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      //theme
                      return ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.settingsTheme,
                        ),
                        leading: Icon(
                          state.theme == AppTheme.dark
                              ? Icons.dark_mode
                              : Icons.light_mode,
                        ),
                        onTap: () {
                          context.read<ThemeBloc>().add(ThemeToggled());
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 2),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context)!.settingData,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  // change email
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.settingsChangeEmail,
                    ),
                    leading: Icon(Icons.email_rounded),
                    onTap: () {
                      ChangeCredentials().changeEmail(context);
                    },
                  ),
                  // change password
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.settingsChangePassword,
                    ),
                    leading: Icon(Icons.lock_rounded),
                    onTap: () {
                      ChangeCredentials().changePassword(context);
                    },
                  ),
                  // password forgotten
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.settingsForgotPassword,
                    ),
                    leading: Icon(Icons.lock_reset_rounded),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.settingsForgotPassworQuestion,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.settingsForgotPasswordText,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.settingsForgotPasswordCancel,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.pop();
                                        context
                                            .read<AuthenticationCubit>()
                                            .logout();
                                        context.go(AppPaths.login);
                                      },
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.settingsForgotPasswordContinue,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 2),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context)!.settingsSafety,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              //safety in the mountains
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.settingsMountainSafety,
                    ),
                    leading: Icon(Icons.security_rounded),
                    onTap: () {
                      _safetyLink(context);
                    },
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 2),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context)!.settingsAccount,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              //logout
              child: Column(
                children: [
                  // sign out
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.settingsSignOut,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(Icons.logout, color: Colors.red),
                    onTap: () async {
                      await context.read<AuthenticationCubit>().logout();
                      context.go(AppPaths.login);
                    },
                  ),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.settingsDeleteAccount,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                    ),
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext bottomSheetContext) {
                          return Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.settingsDeleteAccountConfirm,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.settingsDeleteAccountText,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.settingsForgotPasswordCancel,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        context.pop();
                                        try {
                                          await FirestoreApiService()
                                              .deleteUser(uid);
                                          await context
                                              .read<AuthenticationCubit>()
                                              .deleteAccount();
                                          await FirebaseAuth.instance.signOut();
                                          context.go(AppPaths.login);
                                        } catch (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.settingsDeleteAccountError,
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.settingsDeleteAccount,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _safetyLink(BuildContext context) async {
    final url = Uri.parse('https://theuiaa.org/mountain-safety/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.settingsNoApp),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
