import 'package:autoshine/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: 'user'),
          Expanded(child: Center(child: Text('Profile Screen'))),
        ],
      ),
    );
  }
}
