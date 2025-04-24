import 'package:autoshine/controller/add_vehicle_contrller.dart';
import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/services/cloudinary_uploader.dart';
import 'package:autoshine/services/vehicle_services.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/vehicle_category_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class CarAddScreen extends StatelessWidget {
  final VehicleAddController controller = Get.put(VehicleAddController());
  final CloudinaryUploader cloudinaryUploader = CloudinaryUploader();

  CarAddScreen({super.key});

  final List<Map<String, dynamic>> carBrands = [
    {'name': 'Maruti Suzuki', 'image': 'assets/car_icons/suzuki.png'},
    {'name': 'Hyundai', 'image': 'assets/car_icons/hyundai.png'},
    {'name': 'Tata Motors', 'image': 'assets/car_icons/tata.png'},
    {'name': 'Mahindra', 'image': 'assets/car_icons/mahindra.png'},
    {'name': 'Honda', 'image': 'assets/car_icons/honda.png'},
    {'name': 'Toyota', 'image': 'assets/car_icons/toyota.png'},
    {'name': 'Kia', 'image': 'assets/car_icons/kia.png'},
    {'name': 'Renault', 'image': 'assets/car_icons/renault.png'},
    {'name': 'Volkswagen', 'image': 'assets/car_icons/volkswagen.png'},
    {'name': 'Skoda', 'image': 'assets/car_icons/skoda.png'},
    {'name': 'Nissan', 'image': 'assets/car_icons/nissan.png'},
    {'name': 'MG', 'image': 'assets/car_icons/mg.png'},
    {'name': 'Citroën', 'image': 'assets/car_icons/citron.png'},
    {'name': 'Jeep', 'image': 'assets/car_icons/jeep.png'},
    {'name': 'BMW', 'image': 'assets/car_icons/bmw.png'},
    {'name': 'Mercedes-Benz', 'image': 'assets/car_icons/benz.png'},
    {'name': 'Audi', 'image': 'assets/car_icons/audi.png'},
    {'name': 'Lexus', 'image': 'assets/car_icons/lexus.png'},
    {'name': 'Volvo', 'image': 'assets/car_icons/volvo.png'},
    {'name': 'Porsche', 'image': 'assets/car_icons/porsche.png'},
    {'name': 'Jaguar', 'image': 'assets/car_icons/jaguar.png'},
    {'name': 'Land Rover', 'image': 'assets/car_icons/landrover.png'},
    {'name': 'BYD', 'image': 'assets/car_icons/byd.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: const Text(
          'Add Your Four Wheeler',
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
                        type: 'Hatchback',
                        selectedType: controller.selectedVehicleType.value,
                        onSelect: controller.selectType,
                        title: 'Hatchback type',
                        icon: IcoFontIcons.carAlt3,
                      ),
                    ),
                    Obx(
                      () => vehicleTypeSelector(
                        type: 'Sedan',
                        selectedType: controller.selectedVehicleType.value,
                        onSelect: controller.selectType,
                        title: 'Sedan type',
                        icon: IcoFontIcons.carAlt2,
                      ),
                    ),
                    Obx(
                      () => vehicleTypeSelector(
                        type: 'SUV/MUV',
                        selectedType: controller.selectedVehicleType.value,
                        onSelect: controller.selectType,
                        title: 'SUV or MUV type',
                        icon: IcoFontIcons.carAlt1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            Obx(
              () => GestureDetector(
                onTap: () => controller.pickImage(),
                child: Container(
                  width: 170,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[400],
                    image:
                        controller.selectedImage.value == null
                            ? const DecorationImage(
                              image: AssetImage(
                                'assets/logo/AutoShine_black_tr.png',
                              ),
                              opacity: 0.3,
                            )
                            : DecorationImage(
                              image: FileImage(controller.selectedImage.value!),
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: inputDecoration('Select Brand'),
                value:
                    controller.selectedBrand.value.isEmpty
                        ? null
                        : controller.selectedBrand.value,
                items:
                    carBrands.map((brand) {
                      return DropdownMenuItem<String>(
                        value: brand['name'],
                        child: Row(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.asset(brand['image']),
                            ),
                            const SizedBox(width: 20),
                            Text(brand['name']),
                          ],
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedBrand.value = value;
                  }
                },
              ),
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
                    final brand = controller.selectedBrand.value.trim();
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

                    String imageUrl = '';
                    final imageFile = controller.selectedImage.value;
                    if (imageFile != null) {
                      imageUrl =
                          await cloudinaryUploader.uploadImage(imageFile) ?? '';
                    }

                    final vehicle = VehicleTypeModel(
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

                    Get.snackbar("Success", "Vehicle added");
                    Get.offNamed('/navbar');
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
