import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signinfirebase/secreens/home.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBU0D--zRtqcXgN-tT95a2HedXchktuTQk",
          authDomain: "signin-4e052.firebaseapp.com",
          projectId: "signin-4e052",
          storageBucket: "signin-4e052.appspot.com",
          messagingSenderId: "179758272338",
          appId: "1:179758272338:web:df3c65d7e1a0435827f48b"));
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen());
  }
}
