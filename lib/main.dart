import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/ui/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 222, 147, 201),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 222, 147, 201), // Set the app bar color
        ),
      ),
      home: const SplashScreen(),
    );
  }
}