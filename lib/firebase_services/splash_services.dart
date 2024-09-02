import 'package:firebase_project/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/ui/posts/post_screen.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const PostScreen()),));
    } else {
      Timer(const Duration(seconds: 3), 
      ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()))
      );
    }
  }
}
