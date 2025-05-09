import 'dart:async';
import 'package:autoshine/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        Navigator.pushReplacementNamed(context, '/navbar');
      } else {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });

    return Scaffold(
      backgroundColor: deepAmber,
      body: Center(
        child: Image.asset(
          'assets/logo/AutoShine_logo_white_tr.png',
          width: 112,
          height: 112,
        ),
      ),
    );
  }
}
