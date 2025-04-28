import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorSnackBar(String message) {
  Get.snackbar(
    'Error',
    message,
    colorText: whiteColor,
    backgroundColor: Colors.red,
  );
}

void successSnackBar(String message) {
  Get.snackbar(
    'Success',
    message,
    colorText: const Color(0xFF2E7B30),
    backgroundColor: whiteColor,
  );
}
