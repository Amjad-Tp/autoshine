import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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

  Future<String> uploadImage(File imageFile) async {
    final storageRef = FirebaseStorage.instance.ref().child(
      'vehicle_images/${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL();
  }

  @override
  void onClose() {
    brandController.clear();
    modelController.clear();

    super.onClose();
  }
}
