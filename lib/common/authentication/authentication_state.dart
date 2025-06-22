import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class Authenticated extends AuthenticationState {
  final User user;
  const Authenticated({required this.user});
}

class NotAuthenticated extends AuthenticationState {
  const NotAuthenticated();
}
