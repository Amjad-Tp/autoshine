import 'dart:ui';

import 'package:autoshine/controller/add_vehicle_contrller.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/brand_drop_down.dart';
import 'package:autoshine/widget/custom_container.dart';
import 'package:autoshine/widget/text_feild_custom.dart';
import 'package:autoshine/widget/vehicle_category_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class CarAddScreen extends StatelessWidget {
  final VehicleAddController controller = Get.find<VehicleAddController>();

  CarAddScreen({super.key}) {
    controller.selectedBrand.value = '';
    controller.selectedVehicleType.value = '';
    controller.modelController.clear();
    controller.selectedImage.value = null;
  }

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
    return Stack(
      children: [
        Scaffold(
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
                CustomContainer(
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
                                  image: FileImage(
                                    controller.selectedImage.value!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                BrandDropDown(controller: controller, brandMap: carBrands),
                const SizedBox(height: 15),
                TextFeildCustom(
                  controller: controller.modelController,
                  labelText: 'Model Name',
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
                    Obx(() {
                      return controller.isSubmitting.value
                          ? const SizedBox()
                          : button(
                            () async {
                              controller.addVehicle();
                            },
                            'Done',
                            rockBlue,
                            rockBlue,
                            whiteColor,
                          );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
        // --- Fullscreen Loader Overlay ---
        Obx(() {
          if (!controller.isSubmitting.value) return const SizedBox();
          return Container(
            color: Colors.black.withValues(alpha: .3),
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: Colors.black.withValues(alpha: .4)),
                ),
                Center(child: CircularProgressIndicator(color: whiteColor)),
              ],
            ),
          );
        }),
      ],
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
