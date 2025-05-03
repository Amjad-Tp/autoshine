import 'package:flutter/material.dart';

final deepAmber = const Color(0xFFFBC02D); // Golden Yellow
final goldenYellow = const Color(0xFFFFA000); // Deep Amber

final scaffoldColor = const Color(0xFFF2F2F2); //--Scaffold background color

final blackButton = const Color(0xFF212121); //--Used for Oder,Confirm buttons

final whiteColor = Colors.white;
final blackColor = Colors.black;

final editButton = Colors.blue; //---------blue color
final removeButton = Colors.red; //---------red color

final greyColor = Colors.grey.shade300; //-------Grey color

final darkYellowButton = const Color(0xFFFF9100);

final linearGradient = LinearGradient(colors: [goldenYellow, deepAmber]);

final shadow = [
  BoxShadow(
    blurRadius: 14,
    color: blackColor.withValues(alpha: .2),
  ), //-----BoxShadow of custome card(container)
];

final borderRadius = BorderRadius.circular(10); //--------Border Radius = 10

final screenPadding = EdgeInsets.only(
  top: 20,
  right: 12,
  left: 12,
); //------Padding (use as default padding)

//-------Time Slot Colors----------
final timeSlotGreen = const Color(0xff32BD00);
final timeSlotLightGrey = const Color(0xffD9D9D9);
final timeSlotDark = const Color(0xff585858);
