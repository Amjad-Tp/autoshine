import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/titled_appbar.dart';
import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitledAppbar(title: 'Booking Details'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: screenPadding,
                child: Column(children: [Text("Booking Details Screen")]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
