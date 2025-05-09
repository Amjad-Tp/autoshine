import 'dart:ui';

import 'package:autoshine/blocs/auth/auth_bloc.dart';
import 'package:autoshine/controller/sign_up_controller.dart';
import 'package:autoshine/functions/custom_snack_bar.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/login_signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final SignupController controller = Get.put(
    SignupController(authBloc: Get.find<AuthBloc>()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          bloc: controller.authBloc,
          listener: (context, state) {
            if (state is AuthSuccess) {
              successSnackBar(
                'Verification email sent. Please check your email.',
              );
              controller.startEmailVerificationCheck();
            } else if (state is AuthFailed) {
              errorSnackBar(state.error);
            } else if (state is AuthVerificationEmailSent) {
              Get.snackbar('Message', state.message);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            bloc: controller.authBloc,
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 330,
                            height: 220,
                            child: Image.asset(
                              'assets/others/login_screen.png',
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 33,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildTextField(
                                  _emailController,
                                  'Email',
                                  Icons.email_rounded,
                                  (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Please enter your email';
                                    if (!RegExp(
                                      r'^[^@]+@[^@]+\.[^@]+',
                                    ).hasMatch(value)) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                _buildTextField(
                                  _nameController,
                                  'Name',
                                  Icons.person_rounded,
                                  (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Name is required';
                                    if (value.contains(' '))
                                      return 'Name cannot contain spaces';
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                Obx(() {
                                  final obscure =
                                      !controller.showPassword.value;
                                  return _buildTextField(
                                    _passwordController,
                                    'Password',
                                    Icons.lock_rounded,
                                    (value) {
                                      if (value == null || value.isEmpty)
                                        return 'Password is required';
                                      if (value.length < 6)
                                        return 'Password must be at least 6 characters';
                                      return null;
                                    },
                                    obscureText: obscure,
                                  );
                                }),
                                const SizedBox(height: 10),
                                Obx(() {
                                  final obscure =
                                      !controller.showPassword.value;
                                  return _buildTextField(
                                    _confirmPasswordController,
                                    'Confirm Password',
                                    Icons.lock_rounded,
                                    (value) {
                                      if (value == null || value.isEmpty)
                                        return 'Confirmation is required';
                                      if (value != _passwordController.text)
                                        return "Passwords don't match";
                                      return null;
                                    },
                                    obscureText: obscure,
                                  );
                                }),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          LoginSignupButton(
                            title: 'Sign Up',
                            navigation: () {
                              if (_formKey.currentState!.validate()) {
                                final email = _emailController.text.trim();
                                final password =
                                    _passwordController.text.trim();
                                final name = _nameController.text.trim();
                                controller.authBloc.add(
                                  AuthSignUpRequested(
                                    email: email,
                                    password: password,
                                    name: name,
                                  ),
                                );
                                controller.startResendTimer();
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => TextButton(
                              onPressed:
                                  controller.showResendButton.value
                                      ? () {
                                        controller.authBloc.add(
                                          AuthResendVerificationEmail(),
                                        );
                                      }
                                      : null,
                              child: Text(
                                'Resend Verification Email',
                                style: TextStyle(
                                  color:
                                      controller.showResendButton.value
                                          ? Colors.blue
                                          : Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildLoginRedirect(),
                        ],
                      ),
                    ),
                  ),

                  // Blur and loading indicator
                  if (state is AuthLoading)
                    Positioned.fill(
                      child: Stack(
                        children: [
                          Container(color: whiteColor),
                          Center(
                            child: CircularProgressIndicator(color: deepAmber),
                          ),
                        ],
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

  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    IconData icon,
    String? Function(String?) validator, {
    bool obscureText = false,
  }) {
    return GradientTextfield(
      controller: controller,
      hintText: hintText,
      icon: icon,
      validator: validator,
      obsecureText: obscureText,
    );
  }

  Widget _buildLoginRedirect() {
    return RichText(
      text: TextSpan(
        text: "Already have an account? ",
        style: TextStyle(color: blackColor, fontSize: 16),
        children: [
          TextSpan(
            text: 'Login',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            recognizer:
                TapGestureRecognizer()..onTap = () => Get.offAllNamed('/login'),
          ),
        ],
      ),
    );
  }
}
