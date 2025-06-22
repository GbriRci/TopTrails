import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:main/common/authentication/authentication_cubit.dart';
import 'package:main/common/authentication/authentication_state.dart';
import 'package:main/data/firestore_api_service.dart';
import 'package:main/l10n/app_localizations.dart';
import 'package:main/presentation/routes/app_paths.dart';
import 'package:main/presentation/utils/form_validators.dart';

final _formKey = GlobalKey<FormState>();

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();
  late final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(AppPaths.home);
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/background.jpg', fit: BoxFit.cover),
            Container(color: Colors.black.withAlpha(60)),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(330),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 45,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  radius: 35,
                                  child: Icon(
                                    Icons.supervised_user_circle,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 15),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(
                                          context,
                                        )!.registrationTitle(""),
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\nTop Trails',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black,
                                          fontFamily:
                                              'Montserrat-Italic-VariableFont_wght',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 9),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(
                                      context,
                                    )!.registrationEmail,
                                labelStyle: TextStyle(color: Colors.black),
                                hintText:
                                    AppLocalizations.of(
                                      context,
                                    )!.registrationInsertEmail,
                                hintStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.only(bottom: 10),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                              ),
                              style: TextStyle(color: Colors.black),
                              controller: _emailController,
                              validator:
                                  (value) => FormValidators.emailValidator(
                                    context,
                                    value,
                                  ),
                            ),
                            SizedBox(height: 9),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(
                                      context,
                                    )!.registrationPassword,
                                labelStyle: TextStyle(color: Colors.black),
                                hintText:
                                    AppLocalizations.of(
                                      context,
                                    )!.registrationInsertPassword,
                                hintStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                contentPadding: EdgeInsets.only(bottom: 10),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                              ),
                              style: TextStyle(color: Colors.black),
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              validator:
                                  (value) => FormValidators.passwordValidator(
                                    context,
                                    value,
                                  ),
                            ),
                            SizedBox(height: 9),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(
                                      context,
                                    )!.registrationConfirmPassword,
                                labelStyle: TextStyle(color: Colors.black),
                                hintText:
                                    AppLocalizations.of(
                                      context,
                                    )!.registrationInsertConfirmPassword,
                                hintStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(
                                  Icons.verified_user,
                                  color: Colors.black,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                                contentPadding: EdgeInsets.only(bottom: 10),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                              ),
                              style: TextStyle(color: Colors.black),
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              validator:
                                  (value) =>
                                      FormValidators.confirmPasswordValidator(
                                        context,
                                        value,
                                        _passwordController.text,
                                      ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.black,
                                  ),
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                    activeColor: Colors.black,
                                    checkColor: Colors.white,
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.signInRememberData,
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              width: 200,
                              height: 40,
                              child:
                                  _isLoading
                                      ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                      : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                        ),
                                        onPressed:
                                            _isLoading
                                                ? null
                                                : _onRegisterPressed,
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.registrationButton,
                                          style: TextStyle(
                                            fontSize: 19,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(330),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 45,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(
                                        context,
                                      )!.registrationAlreadyUser(""),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Top Trails?",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontFamily:
                                            'Montserrat-Italic-VariableFont_wght',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                )!.registrationLongText,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 150,
                                height: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.go(AppPaths.login);
                                  },
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.registrationSignInButton,
                                    style: TextStyle(
                                      fontSize: 19,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRegisterPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        if (_rememberMe) {
          context.read<AuthenticationCubit>().saveCredentials(email, password);
        }

        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final user = userCredential.user;
        if (!mounted) return;

        if (user != null) {
          await FirestoreApiService().addUser(userId: user.uid, email: email);
        }
        if (!mounted) return;
      } on FirebaseAuthException catch (e) {
        var errorMessage = '';
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage =
                AppLocalizations.of(context)!.registrationAlreadyHaveAccount;
            break;
          case 'weak-password':
            errorMessage =
                AppLocalizations.of(context)!.registrationWeakPassword;
            break;
          default:
            errorMessage = AppLocalizations.of(context)!.registrationError;
            break;
        }
        if (!mounted) return;
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      } catch (e) {
        if (!mounted) return;
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.registrationGenericError,
            ),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
