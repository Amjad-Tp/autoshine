import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleAddController extends GetxController {
  var selectedVehicleType = ''.obs;

  final brandController = TextEditingController();
  final modelController = TextEditingController();

  void selectType(String type) {
    selectedVehicleType.value = type;
  }

  @override
  void onClose() {
    brandController.dispose();
    modelController.dispose();
    super.onClose();
  }
}
