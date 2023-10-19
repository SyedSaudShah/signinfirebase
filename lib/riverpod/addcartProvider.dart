// ignore: file_names
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signinfirebase/riverpod/addcartState.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartState>(
  (ref) {
    return CartNotifier();
  },
);
