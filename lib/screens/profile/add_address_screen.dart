import 'package:autoshine/controller/address_add_controller.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/text_feild_custom.dart';
import 'package:autoshine/widget/titled_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressAddController controller = Get.put(AddressAddController());

    final List<String> dropdownItems = ['Home', 'Work', 'Other'];

    return Scaffold(
      body: Column(
        children: [
          TitledAppbar(title: 'Add Address'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Your Address',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() => dropDown(controller, dropdownItems)),
                    const SizedBox(height: 15),

                    TextFeildCustom(
                      capitalization: TextCapitalization.words,
                      controller: controller.firstNameController,
                      labelText: 'First Name (Required)*',
                    ),

                    const SizedBox(height: 15),
                    TextFeildCustom(
                      capitalization: TextCapitalization.words,
                      controller: controller.lastNameController,
                      labelText: 'Last Name',
                    ),

                    const SizedBox(height: 15),
                    TextFeildCustom(
                      prefixText: '+91 ',
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      controller: controller.phoneController,
                      labelText: 'Phone Number (Required)*',
                    ),
                    //-----alternative phone number...
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: alternativeButton(controller),
                          ),
                          const SizedBox(height: 10),
                          if (controller.isAlternativePhoneVisible.value)
                            TextFeildCustom(
                              prefixText: '+91 ',
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              controller: controller.alternativePhoneController,
                              labelText: 'Alternative Phone Number (Optional)',
                            ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: TextFeildCustom(
                            capitalization: TextCapitalization.words,
                            controller: controller.houseController,
                            labelText: 'House/Building No',
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: TextFeildCustom(
                            keyboardType: TextInputType.number,
                            controller: controller.pinCodeController,
                            labelText: 'Pincode',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFeildCustom(
                      capitalization: TextCapitalization.words,
                      controller: controller.cityController,
                      labelText: 'City',
                    ),
                    const SizedBox(height: 10),
                    TextFeildCustom(
                      capitalization: TextCapitalization.sentences,
                      controller: controller.landmarkController,
                      labelText: 'Landmark (Optional)',
                    ),

                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: controller.saveAddress,
                        style: TextButton.styleFrom(
                          foregroundColor: whiteColor,
                          backgroundColor: darkYellowButton,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Add Address',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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

  GestureDetector alternativeButton(AddressAddController controller) {
    return GestureDetector(
      onTap: () => controller.toggleAlternativePhoneVisibility(),
      child: Row(
        children: [
          Icon(
            controller.isAlternativePhoneVisible.value
                ? Icons.remove_rounded
                : Icons.add_rounded,
            color: editButton,
            size: 20,
          ),
          const SizedBox(width: 3),
          Text(
            'Alternative Phone',
            style: TextStyle(
              color: editButton,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
