import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signinfirebase/addcart/cart.dart';

abstract class CartState {}

@immutable
class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {}

class CartErrorState extends CartState {
  final String error;
  CartErrorState({required this.error});
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartInitialState());

  Future<void> setDataToFirestore(Cartitem cartitem) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference documentReference =
          firestore.collection('your_collection_name').doc('your_document_id');

      Map<String, dynamic> dataToSet = {
        'field_name_1': 'cartitem',
        'nkfj': 'img',
        'num': '23'
      };

      await documentReference.set(dataToSet);
    } on FirebaseException catch (e) {
      e.message;
    }
  }
}
