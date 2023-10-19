// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:signinfirebase/Modelclass/imgModel.dart';

// abstract class HomeState {}

// String? errorMessage = "";

// @immutable
// class HomeInitialState extends HomeState {}

// @immutable
// class HomeLoadingState extends HomeState {}

// @immutable
// class HomeLoadedState extends HomeState {
//   final List<GetImage> list;
//   HomeLoadedState({required this.list});
// }

// @immutable
// class HomeErrorState extends HomeState {
//   final String message;
//   HomeErrorState({required this.message});
// }

// class HomePageNotifier extends StateNotifier<HomeState> {
//   HomePageNotifier(HomeInitialState homeInitialState)
//       : super(HomeInitialState());
//   Future<String?> getImageFromFirebase(String imagePath) async {
//     try {
//       final foodfirstore=FirebaseFirestore.instance.collection('food').snapshots();


    
//     } on FirebaseException catch (e) {
//       errorMessage = e.message;
//       return e.message;
//     }
//   }
// }
