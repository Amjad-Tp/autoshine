import 'dart:io';

import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/services/vehicle_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  var isSubmitting = false.obs;

  var vehicles = <VehicleTypeModel>[].obs;
  var selectedVehicle = Rxn<VehicleTypeModel>();

  @override
  void onInit() {
    fetchVehicles();
    super.onInit();
  }

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

  void fetchVehicles() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final vehicleList = await VehicleService.fetchVehicles(uid);
    vehicles.value =
        vehicleList
            .map(
              (v) => VehicleTypeModel(
                vehicleType: v.vehicleType,
                brandName: v.brandName,
                modelName: v.modelName,
                category: v.category,
                vehicleImagePath: v.vehicleImagePath,
              ),
            )
            .toList();
  }

  @override
  void onClose() {
    brandController.clear();
    modelController.clear();

    super.onClose();
  }
}
