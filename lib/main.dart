import 'package:autoshine/blocs/auth/auth_bloc.dart';
import 'package:autoshine/screens/home_screen.dart';
import 'package:autoshine/screens/login_screen.dart';
import 'package:autoshine/screens/navigation_bar.dart';
import 'package:autoshine/screens/onboarding_screen.dart';
import 'package:autoshine/screens/recover_password_screen.dart';
import 'package:autoshine/screens/signup_screen.dart';
import 'package:autoshine/screens/splash_screen.dart';
import 'package:autoshine/screens/vehicle_type_screen.dart';
import 'package:autoshine/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authService: AuthService())),
      ],
      child: GetMaterialApp(
        title: 'AutoShine',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'poppins'),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const SplashScreen()),
          GetPage(name: '/onboarding', page: () => OnboardingScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/signup', page: () => SignupScreen()),
          GetPage(name: '/vehicletype', page: () => VehicleTypeScreen()),
          GetPage(
            name: '/recover-password',
            page: () => RecoverPasswordScreen(),
          ),
          GetPage(name: '/home', page: () => HomeScreen()),
          GetPage(name: '/navbar', page: () => CustomBottomNavigationBar()),
        ],
      ),
    );
  }
}
