import 'package:autoshine/screens/cart_screen.dart';
import 'package:autoshine/screens/home/notification_screen.dart';
import 'package:autoshine/screens/home/search_screen.dart';
import 'package:autoshine/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      width: double.infinity,
      height: 185,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [rockBlue, darkTurquoise]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Welcome Text
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello ${user?.displayName ?? 'Guest'},',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Welcome to AutoShine',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // Icon Row
                  Row(
                    children: [
                      iconButton(
                        Icons.search_rounded,
                        () => Get.to(SearchScreen()),
                      ),
                      iconButton(
                        Icons.notifications_outlined,
                        () => Get.to(NotificationScreen()),
                      ),
                      iconButton(
                        Icons.shopping_cart_rounded,
                        () => Get.to(CartScreen()),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => Get.toNamed('/vehicletype'),
                  label: Text('Add Vehicle'),
                  icon: Icon(Icons.add_rounded),
                  style: TextButton.styleFrom(foregroundColor: whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell iconButton(IconData icon, VoidCallback navigation) {
    return InkWell(
      onTap: navigation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: whiteColor),
      ),
    );
  }
}
