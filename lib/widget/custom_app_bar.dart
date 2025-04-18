import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [rockBlue, darkTurquoise]),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/icons/before_login/sedan_white.png',
                width: 50,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Honda, ',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextSpan(text: 'Amaze'),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.search_rounded, color: whiteColor),
              Icon(Icons.notifications_active_rounded, color: whiteColor),
              Icon(Icons.shopping_cart_rounded, color: whiteColor),
            ],
          ),
        ],
      ),
    );
  }
}
