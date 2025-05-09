import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  final pageTitles = ['Bookings', 'Orders'];

  void goToPage(int page) {
    if (page >= 0 && page < pageTitles.length) {
      currentPage.value = page;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
