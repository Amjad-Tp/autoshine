import 'package:autoshine/blocs/auth/auth_bloc.dart';
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

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(context, '/navbar');
            } else if (state is AuthFailed) {
              Get.snackbar(
                'Error',
                'Email or Password is invalid',
                colorText: Colors.red,
                backgroundColor: whiteColor,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 330,
                    height: 220,
                    child: Image.asset('assets/others/login_screen.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 33),
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
                        () => Navigator.pushNamed(context, '/recover-password'),
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
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return LoginSignupButton(
                        title: state is AuthLoading ? 'Logging In...' : 'Login',
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
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    '_______ or login with _______',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 215,
                    height: 45,
                    decoration: BoxDecoration(
                      color: rockBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/before_login/google_logo_white.png',
                            width: 29,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/before_login/facebook_white.png',
                            width: 35,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/before_login/Twitter-x_-white.png',
                            width: 28,
                          ),
                        ),
                      ],
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
        ),
      ),
    );
  }
}
