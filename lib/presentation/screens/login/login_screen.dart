import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:main/common/authentication/authentication_cubit.dart';
import 'package:main/common/authentication/authentication_state.dart';
import 'package:main/l10n/app_localizations.dart';
import 'package:main/presentation/routes/app_paths.dart';
import 'package:main/presentation/utils/form_validators.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

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
                                    Icons.new_label,
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
                                        )!.signInTitle(""),
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
                                    AppLocalizations.of(context)!.signInEmail,
                                labelStyle: TextStyle(color: Colors.black),
                                hintText:
                                    AppLocalizations.of(
                                      context,
                                    )!.signInInsertEmail,
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
                                    )!.signInPassword,
                                labelStyle: TextStyle(color: Colors.black),
                                hintText:
                                    AppLocalizations.of(
                                      context,
                                    )!.signInInsertPassword,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
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
                                TextButton(
                                  onPressed: () {
                                    _onforgotPassword();
                                  },
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.signInForgotPassword,
                                    style: TextStyle(color: Colors.black54),
                                  ),
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
                                                : () {
                                                  _onLoginPressed();
                                                },
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.signInButton,
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
                                      )!.signInNewUser(""),
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
                                AppLocalizations.of(context)!.signInLongText,
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
                                    context.go(AppPaths.register);
                                  },
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.signInSignUpButton,
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

  void _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (_rememberMe) {
          context.read<AuthenticationCubit>().saveCredentials(email, password);
        }
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
          default:
            errorMessage = AppLocalizations.of(context)!.signInError;
        }
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      } catch (e) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.signInGenericError),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  void _onforgotPassword() {
    if (_emailController.text.isNotEmpty) {
      context.read<AuthenticationCubit>().forgotPassword(_emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.signInEmailSent),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.signInEnterEmailToResetPassword,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _loadSavedCredentials() async {
    final creds = await context.read<AuthenticationCubit>().loadCredentials();
    if (mounted) {
      setState(() {
        _emailController.text = creds['email'] ?? '';
        _passwordController.text = creds['password'] ?? '';
        _rememberMe =
            creds['email']!.isNotEmpty && creds['password']!.isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
