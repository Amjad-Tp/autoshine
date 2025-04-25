import 'package:autoshine/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(child: Center(child: Text('Order Screen'))),
        ],
      ),
    );
  }
}
