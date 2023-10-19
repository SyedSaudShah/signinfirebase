// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// FirebaseAuth auth = FirebaseAuth.instance;
// FirebaseStorage fbStorage = FirebaseStorage.instance;
// FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// Future<String?> signUp({
//   required String email,
//   required String password,
// }) async {
//   try {
//     await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);
//     return "Signed up!";
//   } on FirebaseAuthException catch (e) {
//     return e.message;
//   }
// }

// // //SIGN IN METHOD
// // Future signIn({required String email, required String password}) async {
// //   try {
// //     await _auth.signInWithEmailAndPassword(email: email, password: password);
// //     return 'Signup!';
// //   } on FirebaseAuthException catch (e) {
// //     return e.message;
// //   }
// // }

// Future<void> sendToFirebase(
//   String name,
//   String lastName,
//   String email,
//   String password,
//   String uid,
// ) async {
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   await firebaseFirestore.collection('User').doc(uid).set({
//     'User_Name': name,
//     'LastName': lastName,
//     'Email': email,
//     'Password': password,
//     'uid': uid,
//   });
// }
// //SIGN OUT METHOD
// Future signOut() async {
//   await _auth.signOut();

//   print('signout');
// }
