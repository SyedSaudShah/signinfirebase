import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class OrderState {}

@immutable
class OrderInicitalState extends OrderState {}

@immutable
class OrderLoadingState extends OrderState {}

@immutable
class OrderLoadedState extends OrderState {}

@immutable
class OrderErrorState extends OrderState {
  final String message;
  OrderErrorState({required this.message});
}

class OrderPageNotifier extends StateNotifier {
  OrderPageNotifier() : super(OrderState);
  Future<void> getfromfirebase() async {
    try {} on FirebaseAuthException catch (e) {
      e.message;
    }
  }
}
