import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
class SplashServices {
  void isLogin(BuildContext context, Widget loginScreen, Widget postScreen) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginScreen))
    );
  }
}