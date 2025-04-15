import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/login_signup.dart';
import 'package:flutter/material.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverEmailController = TextEditingController();
    final recoverFormKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 60),
                SizedBox(
                  width: 330,
                  height: 220,
                  child: Image.asset(
                    'assets/others/recover_password.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 7),

                Text(
                  'Recover your password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 280,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: blackColor, fontSize: 17),
                      children: [
                        TextSpan(
                          text: 'Enter the email ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text:
                              'that you used when you signed up to recover your password. You will receive a ',
                        ),
                        TextSpan(
                          text: 'password reset link.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 50),

                Form(
                  key: recoverFormKey,
                  child: GradientTextfield(
                    controller: recoverEmailController,
                    hintText: 'Email',
                    icon: Icons.email_rounded,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 30),

                //Navigate to login screen
                LoginSignupButton(
                  title: 'Send Email',
                  navigation: () {
                    if (recoverFormKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
