import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VehicleAddController extends GetxController {
  var selectedVehicleType = ''.obs;
  final RxString selectedBrand = ''.obs;

  final brandController = TextEditingController();
  final modelController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);

  void selectType(String type) {
    selectedVehicleType.value = type;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  @override
  void onClose() {
    brandController.clear();
    modelController.clear();

    super.onClose();
  }
}
