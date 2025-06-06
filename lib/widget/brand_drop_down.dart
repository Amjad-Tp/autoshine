import 'package:autoshine/controller/add_vehicle_contrller.dart';
import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandDropDown extends StatelessWidget {
  const BrandDropDown({
    super.key,
    required this.controller,
    required this.brandMap,
  });

  final VehicleAddController controller;
  final List<Map<String, dynamic>> brandMap;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: 'Select Brand',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: deepAmber),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: deepAmber, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        value:
            controller.selectedBrand.value.isEmpty
                ? null
                : controller.selectedBrand.value,
        items:
            brandMap.map((brand) {
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
    );
  }
}
