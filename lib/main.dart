import 'package:autoshine/screens/login_screen.dart';
import 'package:autoshine/screens/onboarding_screen.dart';
import 'package:autoshine/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoShine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'poppins'),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
