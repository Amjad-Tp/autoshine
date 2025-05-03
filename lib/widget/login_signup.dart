import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';

class GradientTextfield extends StatefulWidget {
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
  State<GradientTextfield> createState() => _GradientTextfieldState();
}

class _GradientTextfieldState extends State<GradientTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obsecureText;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 350,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [goldenYellow, deepAmber],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: whiteColor, size: 30),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      obscureText: _obscureText,
                      cursorColor: whiteColor,
                      onChanged: (value) => field.didChange(value),
                      style: TextStyle(color: whiteColor),
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: TextStyle(color: whiteColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (widget.obsecureText)
                    IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: whiteColor,
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                ],
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 4),
                child: Text(
                  field.errorText ?? '',
                  style: const TextStyle(
                    color: Color(0xFFC71408),
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

//--------Login & SignUp Buttons---------
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
        backgroundColor: goldenYellow,
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
