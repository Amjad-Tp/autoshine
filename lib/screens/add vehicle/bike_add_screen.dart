import 'package:autoshine/controller/add_vehicle_contrller.dart';
import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/services/vehicle_services.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/vehicle_category_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class BikeAddScreen extends StatelessWidget {
  final VehicleAddController controller = Get.put(VehicleAddController());

  BikeAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: const Text(
          'Add Your Two Wheeler',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: scaffoldColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: [
            Card(
              elevation: 10,
              color: whiteColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => vehicleTypeSelector(
                        type: 'Bike',
                        selectedType: controller.selectedVehicleType.value,
                        onSelect: controller.selectType,
                        title: 'Bike type',
                        icon: IcoFontIcons.motorBikeAlt,
                      ),
                    ),
                    Obx(
                      () => vehicleTypeSelector(
                        type: 'Scooter',
                        selectedType: controller.selectedVehicleType.value,
                        onSelect: controller.selectType,
                        title: 'Scooter type',
                        icon: IcoFontIcons.scooter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 45),
            Container(
              width: 170,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/logo/AutoShine_black_tr.png'),
                  opacity: .3,
                ),
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: controller.brandController,
              decoration: inputDecoration('Brand Name'),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: controller.modelController,
              decoration: inputDecoration('Model Name'),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(
                  () => Get.back(),
                  'Back',
                  rockBlue,
                  Colors.transparent,
                  rockBlue,
                ),
                const SizedBox(width: 12),
                button(
                  () async {
                    final brand = controller.brandController.text.trim();
                    final model = controller.modelController.text.trim();
                    final selectedType = controller.selectedVehicleType.value;
                    final userId = FirebaseAuth.instance.currentUser?.uid;

                    if (userId == null ||
                        brand.isEmpty ||
                        model.isEmpty ||
                        selectedType.isEmpty) {
                      Get.snackbar("Error", "Please fill all fields");
                      return;
                    }

                    final vehicle = VehicleTypeModel(
                      vehicleType: selectedType,
                      category: 'TwoWheeler',
                      brandName: brand,
                      modelName: model,
                      vehicleImagePath: 'some_path_or_url',
                    );

                    await VehicleService.addVehicle(
                      userId: userId,
                      vehicle: vehicle,
                      isTwoWheeler: true,
                    );

                    Get.snackbar("Success", "Vehicle added");
                    Get.offAllNamed('/home');
                  },
                  'Done',
                  rockBlue,
                  rockBlue,
                  whiteColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String title) {
    return InputDecoration(
      hintText: title,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: rockBlue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: rockBlue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
