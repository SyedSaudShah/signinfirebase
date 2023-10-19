import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

@immutable
abstract class PostState {}

@immutable
class SignupPostInitialState extends PostState {}

@immutable
class SignupPostLoadingState extends PostState {}

@immutable
class SignupPostLoadedState extends PostState {}

@immutable
class SignupPostErrorState extends PostState {
  final String message;
  SignupPostErrorState({
    required this.message,
  });
}

class RegisterUserStateNotifer extends StateNotifier<PostState> {
  RegisterUserStateNotifer(SignupPostInitialState signuppostInitialState)
      : super(SignupPostInitialState());
  registerUser(
      String email, String password, String name, String lastName) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await sendToFirebase(name, lastName, email, password, '');
      state = SignupPostInitialState();
      return "Signed up!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}

Future<void> sendToFirebase(
  String name,
  String lastName,
  String email,
  String password,
  String uid,
) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  await firebaseFirestore.collection('User').doc(email).set({
    'User_Name': name,
    'LastName': lastName,
    'Email': email,
    'Password': password,
    'uid': uid,
  });
}
