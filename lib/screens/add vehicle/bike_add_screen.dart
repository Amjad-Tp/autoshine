import 'package:autoshine/controller/add_vehicle_contrller.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/brand_drop_down.dart';
import 'package:autoshine/widget/custom_container.dart';
import 'package:autoshine/widget/text_feild_custom.dart';
import 'package:autoshine/widget/vehicle_category_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class BikeAddScreen extends StatelessWidget {
  final VehicleAddController controller = Get.put(VehicleAddController());

  BikeAddScreen({super.key}) {
    controller.selectedBrand.value = '';
    controller.selectedVehicleType.value = '';
    controller.modelController.clear();
    controller.selectedImage.value = null;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> twoWheelerBrands = [
      {'name': 'Hero MotoCorp', 'image': 'assets/bike_icons/hero.png'},
      {'name': 'Honda Motorcycle', 'image': 'assets/bike_icons/honda.png'},
      {'name': 'TVS Motor Company', 'image': 'assets/bike_icons/tvs.png'},
      {'name': 'Bajaj Auto', 'image': 'assets/bike_icons/bajaj.png'},
      {'name': 'Royal Enfield', 'image': 'assets/bike_icons/royal_enfeild.png'},
      {'name': 'Suzuki Motorcycle', 'image': 'assets/bike_icons/suzuki.png'},
      {'name': 'Yamaha Motor', 'image': 'assets/bike_icons/yamaha.png'},
      {'name': 'KTM', 'image': 'assets/bike_icons/ktm.png'},
      {'name': 'BMW Motorrad', 'image': 'assets/bike_icons/bmw.png'},
      {'name': 'Harley-Davidson', 'image': 'assets/bike_icons/harley.png'},
      {'name': 'Ducati', 'image': 'assets/bike_icons/ducati.png'},
      {'name': 'Kawasaki', 'image': 'assets/bike_icons/kawasaki.png'},
      {'name': 'Vespa', 'image': 'assets/bike_icons/vespa.png'},
      {'name': 'Ola Electric', 'image': 'assets/bike_icons/ola.png'},
      {'name': 'Ather Energy', 'image': 'assets/bike_icons/ather.png'},
      {'name': 'Revolt Motors', 'image': 'assets/bike_icons/revolt.png'},
    ];

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
            CustomContainer(
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
            const SizedBox(height: 35),
            Text('Add an image of your vehicle'),
            const SizedBox(height: 15),
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
            BrandDropDown(controller: controller, brandMap: twoWheelerBrands),
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
                button(
                  () {
                    controller.addVehicle();
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
}
