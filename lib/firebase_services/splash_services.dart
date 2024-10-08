import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/ui/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/ui/firestore/firestore_list_screen.dart';
import 'package:firebase_project/ui/upload_image.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => UploadImageScreen())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => loginScreen())));
    }
  }
}
