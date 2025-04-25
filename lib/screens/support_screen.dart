import 'package:autoshine/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(child: Center(child: Text('Support Screen'))),
        ],
      ),
    );
  }
}
