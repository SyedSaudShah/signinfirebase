import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class LoginState {}

@immutable
class LoginpPostInitialState extends LoginState {}

@immutable
class LoginpPostLoadingState extends LoginState {}

@immutable
class LoginpPostLoadedState extends LoginState {}

@immutable
class LoginpPostErrorState extends LoginState {}

class Login extends StateNotifier<LoginState> {
  Login(LoginpPostInitialState mypostInitialState)
      : super(LoginpPostInitialState());
  signin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      state = LoginpPostLoadedState();
      return 'SignIn';
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }
}
