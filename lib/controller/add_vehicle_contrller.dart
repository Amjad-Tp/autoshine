import 'dart:io';

import 'package:autoshine/functions/custom_snack_bar.dart';
import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/services/cloudinary_uploader.dart';
import 'package:autoshine/services/vehicle_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class VehicleAddController extends GetxController {
  var selectedVehicleType = ''.obs;
  final RxString selectedBrand = ''.obs;

  final modelController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);

  var isSubmitting = false.obs;

  var vehicles = <VehicleTypeModel>[].obs;
  var selectedVehicle = Rxn<VehicleTypeModel>();

  final CloudinaryUploader cloudinaryUploader = CloudinaryUploader();

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

  void fetchVehicles() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    VehicleService.fetchVehicles(uid).listen((vehicleList) {
      vehicles.value = vehicleList;
    });
  }

  //Add Vehicle Function
  Future<void> addVehicle() async {
    final brand = selectedBrand.value.trim();
    final model = modelController.text.trim();
    final selectedType = selectedVehicleType.value;
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null ||
        brand.isEmpty ||
        model.isEmpty ||
        selectedType.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    isSubmitting.value = true;

    try {
      String imageUrl = '';
      final imageFile = selectedImage.value;
      if (imageFile != null) {
        imageUrl = await cloudinaryUploader.uploadImage(imageFile) ?? '';
      }

      final vehicleId = const Uuid().v4();

      final vehicle = VehicleTypeModel(
        id: vehicleId,
        vehicleType: selectedType,
        category: 'FourWheeler',
        brandName: brand,
        modelName: model,
        vehicleImagePath: imageUrl,
      );

      await VehicleService.addVehicle(
        userId: userId,
        vehicle: vehicle,
        isTwoWheeler: false,
      );

      successSnackBar('Vehicle Added');

      selectedBrand.value = '';
      selectedVehicleType.value = '';
      modelController.clear();
      selectedImage.value = null;

      Get.offAllNamed('/navbar');
    } catch (e) {
      errorSnackBar('Something went wrong');
    } finally {
      isSubmitting.value = false;
    }
  }
}
