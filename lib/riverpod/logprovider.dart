import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signinfirebase/riverpod/loginstate.dart';

final loginprovider = StateNotifierProvider<Login, LoginState>((ref) {
  return Login(LoginpPostInitialState());
});
