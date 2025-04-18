import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CarAddScreen extends StatefulWidget {
  const CarAddScreen({super.key});

  @override
  State<CarAddScreen> createState() => _CarAddScreenState();
}

class _CarAddScreenState extends State<CarAddScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: const Text(
          'Add Your Four Wheeler',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: scaffoldColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 15),
          child: Column(
            children: [
              Card(
                elevation: 15,
                color: whiteColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 22, 22, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildSelectableTile(
                        0,
                        'Hatchback type',
                        FontAwesomeIcons.carRear,
                      ),
                      buildSelectableTile(
                        1,
                        'Sedan type',
                        FontAwesomeIcons.taxi,
                      ),
                      buildSelectableTile(
                        2,
                        'SUV or MUV type',
                        FontAwesomeIcons.carSide,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 45),
              Container(
                width: 170,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage('assets/logo/AutoShine_black_tr.png'),
                    opacity: .3,
                  ),
                  color: Colors.grey[400],
                ),
              ),

              const SizedBox(height: 30),

              textFeild('Brand Name'),
              const SizedBox(height: 15),
              textFeild('Model Name'),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(
                    () {
                      Navigator.pop(context);
                    },
                    'Back',
                    rockBlue,
                    Colors.transparent,
                    rockBlue,
                  ),
                  const SizedBox(width: 12),
                  button(
                    () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    ),
                    'Done',
                    rockBlue,
                    rockBlue,
                    whiteColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextButton button(
    VoidCallback onPressed,
    String name,
    Color borderColor,
    Color backgroundColor,
    Color textColor,
  ) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(13),
        ),
      ),
      child: Text(
        name,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }

  TextFormField textFeild(String title) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: title,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: rockBlue, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: rockBlue, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildSelectableTile(int index, String title, IconData icon) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            children: [
              const SizedBox(width: 15),
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black,
                size: 20,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
