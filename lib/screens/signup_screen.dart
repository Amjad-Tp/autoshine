import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/login_signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signupFormKey = GlobalKey<FormState>();

    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPsController = TextEditingController();

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
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

                Text(
                  'Sign up',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 33),
                ),

                const SizedBox(height: 15),

                Form(
                  key: signupFormKey,
                  child: Column(
                    children: [
                      //--email
                      GradientTextfield(
                        controller: emailController,
                        hintText: 'Email',
                        icon: Icons.email_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email or username';
                          }
                          // Simple email pattern check (optional)
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      //--name
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
                        hintText: 'Password',
                        icon: Icons.lock_rounded,
                        obsecureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirmation Password is Required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          if (passwordController.text != value) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                //Navigate to Home screen
                LoginSignupButton(
                  title: 'Sign Up',
                  navigation: () {
                    if (signupFormKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                ),

                const SizedBox(height: 20),
                Text(
                  '_______ or Sign up with _______',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 15),
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
                      //---Google
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          'assets/icons/before_login/google_logo_white.png',
                          width: 29,
                        ),
                      ),
                      //---Face book
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          'assets/icons/before_login/facebook_white.png',
                          width: 35,
                        ),
                      ),
                      //---Twitter X
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
    );
  }
}
