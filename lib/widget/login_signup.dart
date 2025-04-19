import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';

class GradientTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obsecureText;
  final String? Function(String?)? validator;

  const GradientTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obsecureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 350,
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [rockBlue, darkTurquoise],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: controller,
                obscureText: obsecureText,
                cursorColor: whiteColor,
                onChanged: (value) => field.didChange(value),
                style: TextStyle(color: whiteColor),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: whiteColor),
                  prefixIcon: Icon(icon, color: whiteColor, size: 30),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(
                    color: const Color(0xFFC71408),
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class LoginSignupButton extends StatelessWidget {
  final String title;
  final VoidCallback navigation;
  const LoginSignupButton({
    super.key,
    required this.title,
    required this.navigation,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      //---Navigation
      onPressed: navigation,
      style: TextButton.styleFrom(
        foregroundColor: whiteColor,
        backgroundColor: rockBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 70),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }
}
