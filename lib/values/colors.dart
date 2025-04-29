import 'package:flutter/material.dart';

final rockBlue = const Color(0xFF8FA4C0);
final darkTurquoise = const Color(0xFF00D0E7);

final scaffoldColor = const Color(0xFFF2F2F2); //--Scaffold background color

final blackButton = const Color(0xFF212121); //--Used for Oder,Confirm buttons

final whiteColor = Colors.white;
final blackColor = Colors.black;

final editButton = Colors.blue; //---------blue color
final removeButton = Colors.red; //---------red color

final greyColor = Colors.grey.shade300; //-------Grey color

final darkBlueButton = const Color(0xff00A0B2);

final shadow = [
  BoxShadow(
    blurRadius: 14,
    color: blackColor.withValues(alpha: .2),
  ), //-----BoxShadow of custome card(container)
];

final borderRadius = BorderRadius.circular(10); //--------Border Radius = 10

final screenPadding = EdgeInsets.only(
  top: 20,
  right: 10,
  left: 10,
); //------Padding (use as default padding)
