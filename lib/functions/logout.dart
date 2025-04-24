import 'dart:ui';
import 'package:autoshine/blocs/auth/auth_bloc.dart';
import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<void> logoutAlert(BuildContext context) async {
  Get.dialog(
    Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(),
        ),
        Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Alert...!'),
            titleTextStyle: const TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              // Cancel button
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: blackColor, fontSize: 15),
                ),
              ),
              // Logout button
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                  Get.offAllNamed('/login');
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
