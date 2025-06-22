import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:main/common/authentication/authentication_cubit.dart';
import 'package:main/l10n/app_localizations.dart';

class ChangeCredentials {
  Future<void> changeEmail(BuildContext context) async {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.settingsChangeEmail),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.settingsNewEmail,
                    filled: true,
                    fillColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.settingsCurrentPassword,
                    filled: true,
                    fillColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                  obscureText: true,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.settingsChangeEmailCancel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'email': emailController.text,
                    'password': passwordController.text,
                  });
                },
                child: Text(
                  AppLocalizations.of(context)!.settingsChangeEmailConfirm,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
    );
    emailController.dispose();
    passwordController.dispose();

    if (result != null &&
        result['email']!.isNotEmpty &&
        result['password']!.isNotEmpty) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        final cred = EmailAuthProvider.credential(
          email: user!.email!,
          password: result['password']!,
        );
        await user.reauthenticateWithCredential(cred);
        await context.read<AuthenticationCubit>().updateEmail(result['email']!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.settingsEmailUpdated),
            backgroundColor: Colors.green,
          ),
        );
      } on FirebaseAuthException catch (e) {
        var errorMessage = "";
        switch (e.code) {
          case 'invalid-credential':
            errorMessage =
                AppLocalizations.of(context)!.signInInvalidCredentials;
            break;
          case 'user-disabled':
            errorMessage = AppLocalizations.of(context)!.signInDisabledAccount;
            break;
          case 'email-already-in-use':
            errorMessage =
                AppLocalizations.of(context)!.registrationAlreadyHaveAccount;
            break;
          case 'invalid-email':
            errorMessage = AppLocalizations.of(context)!.registrationError;
            break;
          default:
            errorMessage = AppLocalizations.of(context)!.signInError;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.signInGenericError),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> changePassword(BuildContext context) async {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.settingsChangePassword),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: oldPasswordController,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.settingsCurrentPassword,
                    filled: true,
                    fillColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.settingsNewPassword,
                    filled: true,
                    fillColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                  obscureText: true,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.settingsChangePasswordCancel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'oldPassword': oldPasswordController.text,
                    'newPassword': newPasswordController.text,
                  });
                },
                child: Text(
                  AppLocalizations.of(context)!.settingsChangePasswordConfirm,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
    );
    oldPasswordController.dispose();
    newPasswordController.dispose();
    
    if (result != null &&
        result['oldPassword']!.isNotEmpty &&
        result['newPassword']!.isNotEmpty) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        final cred = EmailAuthProvider.credential(
          email: user!.email!,
          password: result['oldPassword']!,
        );
        await user.reauthenticateWithCredential(cred);
        await context.read<AuthenticationCubit>().updatePassword(
          result['newPassword']!,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password aggiornata!'),
            backgroundColor: Colors.green,
          ),
        );
      } on FirebaseAuthException catch (e) {
        var errorMessage = "";
        switch (e.code) {
          case 'weak-password':
            errorMessage =
                AppLocalizations.of(context)!.registrationWeakPassword;
            break;
          case 'wrong-password':
          case 'invalid-credential':
            errorMessage =
                AppLocalizations.of(context)!.signInInvalidCredentials;
            break;
          case 'user-disabled':
            errorMessage = AppLocalizations.of(context)!.signInDisabledAccount;
            break;
          default:
            errorMessage = AppLocalizations.of(context)!.signInError;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.signInGenericError),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
