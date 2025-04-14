import 'dart:async';

import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
    return Scaffold(
      backgroundColor: rockBlue,
      body: Center(
        child: Image(
          image: AssetImage('assets/logo/AutoShine_logo_white_tr.png'),
          width: 112,
          height: 112,
        ),
      ),
    );
  }
}
