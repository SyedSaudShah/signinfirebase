// ignore_for_file: subtype_of_sealed_class

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signinfirebase/riverpod/stateprovider.dart';

final registerUserNotifierProvider =
    StateNotifierProvider<RegisterUserStateNotifer, PostState>((ref) {
  return RegisterUserStateNotifer(SignupPostInitialState());
});
