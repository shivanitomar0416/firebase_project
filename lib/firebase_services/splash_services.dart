import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/ui/posts/post_screen.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context, Widget loginScreen, Widget postScreen) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    Future.delayed(const Duration(seconds: 3), () {
      try {
        if (user != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => postScreen),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => loginScreen),
            (route) => false,
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    });
  }
}