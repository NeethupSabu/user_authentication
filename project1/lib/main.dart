import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:project1/add_phone.dart';
import 'package:project1/home.dart';
//import 'package:project1/verify.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC2NQLFzuwJ3B_fDa0MFd0SZa59RgZ_5KE",
          appId: "1:674974861180:android:a24d878501306779c706f9",
          messagingSenderId: "674974861180",
          projectId: "otpverify-48aa0",
          storageBucket: "otpverify-48aa0.appspot.com"));
  runApp(const MyApp()); // Wrap your app with MaterialApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(), // Set Home widget
    );
  }
}
