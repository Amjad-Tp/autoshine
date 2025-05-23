import 'package:autoshine/blocs/auth/auth_bloc.dart';
import 'package:autoshine/functions/custom_snack_bar.dart';
import 'package:autoshine/services/auth_service.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/login_signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final AuthService authService = AuthService();

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(context, '/navbar');
            } else if (state is AuthFailed) {
              errorSnackBar(state.error);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 330,
                            height: 220,
                            child: Image.asset(
                              'assets/others/login_screen.png',
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 33,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: loginFormKey,
                            child: Column(
                              children: [
                                GradientTextfield(
                                  controller: emailController,
                                  hintText: 'Email Address',
                                  icon: Icons.email_rounded,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(
                                      r'^[^@]+@[^@]+\.[^@]+',
                                    ).hasMatch(value)) {
                                      return 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                GradientTextfield(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  icon: Icons.lock_rounded,
                                  obsecureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap:
                                () => Navigator.pushNamed(
                                  context,
                                  '/recover-password',
                                ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          LoginSignupButton(
                            title: 'Login',
                            navigation: () {
                              if (loginFormKey.currentState!.validate()) {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();

                                context.read<AuthBloc>().add(
                                  AuthLoginRequested(
                                    email: email,
                                    password: password,
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            '_______ or login with _______',
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              await authService.signInWithGoogle();
                              Get.offNamed('/navbar');
                            },
                            child: Container(
                              width: 215,
                              height: 45,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 16,
                                    color: blackColor.withValues(alpha: .3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/before_login/google_logo.png',
                                    width: 29,
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    'Google',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: blackColor),
                              children: [
                                TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () => Get.offNamed('signup'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state is AuthLoading)
                    Positioned.fill(
                      child: Container(
                        color: whiteColor.withValues(alpha: .6),
                        child: Center(
                          child: CircularProgressIndicator(color: deepAmber),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
