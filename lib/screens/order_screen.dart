import 'package:autoshine/controller/order_controller.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_app_bar.dart';
import 'package:autoshine/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: CustomContainer(
              decoration: BoxDecoration(
                gradient: linearGradient,
                borderRadius: borderRadius,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    arrowButtons(
                      controller,
                      () =>
                          controller.goToPage(controller.currentPage.value - 1),
                      Icons.arrow_back_ios_rounded,
                    ),
                    Text(
                      controller.pageTitles[controller.currentPage.value],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    arrowButtons(
                      controller,
                      () =>
                          controller.goToPage(controller.currentPage.value + 1),
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.currentPage.value = index;
              },
              children: const [
                Center(child: Text('Bookings Page')),
                Center(child: Text('Orders Page')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton arrowButtons(
    OrderController controller,
    VoidCallback function,
    IconData icon,
  ) {
    return IconButton(
      onPressed: function,
      icon: Icon(icon),
      // style: IconButton.styleFrom(foregroundColor: whiteColor),
    );
  }
}
