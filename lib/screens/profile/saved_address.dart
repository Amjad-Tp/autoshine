import 'package:autoshine/screens/profile/add_address_screen.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_container.dart';
import 'package:autoshine/widget/titled_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedAddress extends StatelessWidget {
  const SavedAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Column(
        children: [
          TitledAppbar(title: 'Saved Address'),
          Expanded(
            child: Padding(
              padding: screenPadding,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onTap: () => Get.to(() => AddAddressScreen()),
                        child: CustomContainer(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_rounded, size: 23),
                              const SizedBox(width: 10),
                              Text(
                                'Add Address',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    CustomContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amjad TP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text('TP House,Valakkai,Thalipparamba'),
                                Text('670142'),
                                const SizedBox(height: 10),
                                Text(
                                  '+91 8089340972',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: button(
                                  () {}, //---------edit Screen navigation
                                  'Edit',
                                  editButton,
                                  BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: button(
                                  () {}, //---------Delete method
                                  'Delete',
                                  removeButton,
                                  BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector button(
    VoidCallback navigation,
    String name,
    Color color,
    BorderRadius radius,
  ) {
    return GestureDetector(
      onTap: navigation,
      child: CustomContainer(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: color, borderRadius: radius),
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
