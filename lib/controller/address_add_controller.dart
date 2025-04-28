import 'dart:developer';

import 'package:autoshine/functions/custom_snack_bar.dart';
import 'package:autoshine/models/address_model.dart';
import 'package:autoshine/services/address_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressAddController extends GetxController {
  final AddressService addressService = AddressService();

  final RxString selectedAddressType = ''.obs;

  final addressType = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final alternativePhoneController = TextEditingController();
  final houseController = TextEditingController();
  final pinCodeController = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();
  final landmarkController = TextEditingController();

  //-------Alternative phonenumber toggle butotn
  var isAlternativePhoneVisible = false.obs;

  void toggleAlternativePhoneVisibility() {
    isAlternativePhoneVisible.value = !isAlternativePhoneVisible.value;
  }

  bool validation(
    String firstName,
    String phone,
    String house,
    String pincode,
    String city,
  ) {
    if (firstName.isEmpty) {
      errorSnackBar('Please enter your First Name');
      return false;
    }
    if (phone.isEmpty || phone.length != 10) {
      errorSnackBar('Please enter a valid 10-digit Phone Number');
      return false;
    }
    if (house.isEmpty) {
      errorSnackBar('Please enter House/Building No');
      return false;
    }
    if (pincode.isEmpty || pincode.length != 6) {
      errorSnackBar('Please enter a valid 6-digit Pincode');
      return false;
    }
    if (city.isEmpty) {
      errorSnackBar('Please Enter Your City');
      return false;
    }
    return true;
  }

  Future<void> saveAddress() async {
    final addressType = selectedAddressType.value.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final phone = phoneController.text.trim();
    final alternative = alternativePhoneController.text.trim();
    final house = houseController.text.trim();
    final pinCode = pinCodeController.text.trim();
    final city = cityController.text.trim();
    final landmark = landmarkController.text.trim();
    if (validation(firstName, phone, house, pinCode, city)) {
      try {
        final address = AddressModel(
          addressType: addressType,
          firstName: firstName,
          phone: phone,
          house: house,
          pinCode: pinCode,
          city: city,
          landmark: landmark,
          lastName: lastName,
          alternativePhone: alternative,
        );

        await addressService.addAddress(address);
        log('Address succesfully stored');
        Get.back();
      } catch (e) {
        errorSnackBar('Something went wrong : $e');
      }
    }
  }
}
