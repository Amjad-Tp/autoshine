import 'package:autoshine/screens/Order_screen.dart';
import 'package:autoshine/screens/cart_screen.dart';
import 'package:autoshine/screens/home/home_screen.dart';
import 'package:autoshine/screens/profile_screen.dart';
import 'package:autoshine/screens/support_screen.dart';
import 'package:autoshine/values/colors.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0; // <-- Define this to track selected tab

  final List<Widget> _screens = [
    HomeScreen(),
    OrderScreen(),
    CartScreen(),
    SupportScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: _screens[_currentIndex], // Show selected screen
      bottomNavigationBar: SizedBox(
        height: 80,
        child: CustomNavigationBar(
          iconSize: 30.0,
          strokeColor: const Color(0x46D0D0D0),
          backgroundColor: whiteColor,
          items: [
            CustomNavigationBarItem(
              icon: Image.asset('assets/icons/grey icons/home-fill.png'),
              selectedIcon: Image.asset('assets/icons/home fill.png'),
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
            CustomNavigationBarItem(
              icon: Image.asset('assets/icons/grey icons/Order.png'),
              selectedIcon: Image.asset('assets/icons/Order.png'),
              title: const Text(
                "Order",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
            CustomNavigationBarItem(
              icon: Image.asset('assets/icons/grey icons/cart-fill.png'),
              selectedIcon: Image.asset('assets/icons/cart fill.png'),
              title: const Text(
                "Cart",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
            CustomNavigationBarItem(
              icon: Image.asset('assets/icons/grey icons/Order.png'),
              selectedIcon: Image.asset('assets/icons/Order.png'),
              title: const Text(
                "Support",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
            CustomNavigationBarItem(
              icon: Image.asset('assets/icons/grey icons/profile-fill.png'),
              selectedIcon: Image.asset('assets/icons/profile fill.png'),
              title: const Text(
                "Profile",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
