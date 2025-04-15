import 'dart:async';

import 'package:autoshine/blocs/auth/auth_bloc.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/login_signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final signupFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPsController = TextEditingController();

  bool showResendButton = false;
  Timer? _resendTimer;

  Timer? _checkEmailVerifiedTimer;
  bool isEmailVerified = false;

  void startResendTimer() {
    setState(() {
      showResendButton = false;
    });

    _resendTimer?.cancel();
    _resendTimer = Timer(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          showResendButton = true;
        });
      }
    });
  }

  void startCheckingEmailVerification() {
    _checkEmailVerifiedTimer?.cancel();
    _checkEmailVerifiedTimer = Timer.periodic(const Duration(seconds: 3), (
      timer,
    ) async {
      final user = context.read<AuthBloc>().authService.getCurrentUser();
      await user?.reload();
      final refreshedUser =
          context.read<AuthBloc>().authService.getCurrentUser();

      if (refreshedUser != null && refreshedUser.emailVerified) {
        timer.cancel();
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home'); // or '/login'
        }
      }
    });
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _checkEmailVerifiedTimer?.cancel();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Verification email sent. Please check your email.",
                  ),
                ),
              );
              startCheckingEmailVerification();
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is AuthVerificationEmailSent) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 330,
                    height: 220,
                    child: Image.asset('assets/others/login_screen.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sign up',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 33),
                  ),
                  const SizedBox(height: 15),
                  Form(
                    key: signupFormKey,
                    child: Column(
                      children: [
                        GradientTextfield(
                          controller: emailController,
                          hintText: 'Email',
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
                          controller: nameController,
                          hintText: 'Name',
                          icon: Icons.person_rounded,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is Required';
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
                              return 'Password is Required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        GradientTextfield(
                          controller: confirmPsController,
                          hintText: 'Confirm Password',
                          icon: Icons.lock_rounded,
                          obsecureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirmation Password is Required';
                            }
                            if (value != passwordController.text) {
                              return "Passwords don't match";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Sign Up and Resend
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          LoginSignupButton(
                            title:
                                state is AuthLoading
                                    ? 'Signing Up...'
                                    : 'Sign Up',
                            navigation: () {
                              if (signupFormKey.currentState!.validate()) {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                final name = nameController.text.trim();

                                context.read<AuthBloc>().add(
                                  AuthSignUpRequested(
                                    email: email,
                                    password: password,
                                    name: name,
                                  ),
                                );

                                startResendTimer();
                              }
                            },
                          ),
                          TextButton(
                            onPressed:
                                showResendButton
                                    ? () {
                                      context.read<AuthBloc>().add(
                                        AuthResendVerificationEmail(),
                                      );
                                    }
                                    : null,
                            child: Text(
                              'Resend Verification Email',
                              style: TextStyle(
                                color:
                                    showResendButton
                                        ? Colors.blue
                                        : Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 5),
                  const Text(
                    '_______ or Sign up with _______',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 15),
                  // Social Buttons
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
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: blackColor),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap =
                                    () => Navigator.pushReplacementNamed(
                                      context,
                                      '/login',
                                    ),
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
