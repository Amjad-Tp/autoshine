import 'package:autoshine/controller/add_vehicle_contrller.dart';
import 'package:autoshine/models/service_model.dart';
import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/titled_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final ServiceModel service;
  const ServiceDetailsScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final VehicleAddController vehicleAddController =
        Get.find<VehicleAddController>();
    return Scaffold(
      body: Column(
        children: [
          TitledAppbar(title: service.name),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(service.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 250,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                blackColor.withValues(alpha: .7),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              service.name,
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Package Details',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    ListView.builder(
                      padding: EdgeInsets.only(top: 15),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: service.tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 7),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: rockBlue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  service.tasks[index],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    Row(
                      children: [
                        Text(
                          'Select Vehicle : ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() {
                            return DropdownButtonFormField<VehicleTypeModel>(
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(20),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: rockBlue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: rockBlue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a vehicle';
                                }
                                return null;
                              },
                              value: vehicleAddController.selectedVehicle.value,
                              hint: Text('Choose your vehicle'),
                              items:
                                  vehicleAddController.vehicles.map((vehicle) {
                                    return DropdownMenuItem(
                                      value: vehicle,
                                      child: Text(
                                        '${vehicle.brandName}, ${vehicle.modelName}',
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (val) {
                                vehicleAddController.selectedVehicle.value =
                                    val;
                              },
                            );
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      '₹${service.charge}',
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
