import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitledAppbar extends StatelessWidget {
  final String title;
  const TitledAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [rockBlue, darkTurquoise]),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 17,
            left: 17,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: whiteColor,
                size: 28,
              ),
            ),
          ),
          Positioned(
            bottom: 17,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
