import 'package:autoshine/controller/add_vehicle_contrller.dart';
import 'package:autoshine/functions/custom_snack_bar.dart';
import 'package:autoshine/models/service_model.dart';
import 'package:autoshine/screens/service%20screen/booking_details_screen.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/service_details_widgets.dart';
import 'package:autoshine/widget/titled_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final ServiceModel service;
  const ServiceDetailsScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final serviceDetailsWidgets = ServiceDetailsWidgets();
    final VehicleAddController vehicleAddController = Get.find();

    return Scaffold(
      body: Column(
        children: [
          TitledAppbar(title: service.name),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
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

                    serviceDetailsWidgets.buildPackageDetails(service.tasks),

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
                          child: serviceDetailsWidgets.buildVehicleDropdown(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

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

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () {
                          serviceDetailsWidgets.showAddressBottomSheet();
                        },

                        style: TextButton.styleFrom(
                          foregroundColor: whiteColor,
                          backgroundColor: darkBlueButton,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: Icon(Icons.location_on_rounded),
                        label: Text('Change Address'),
                      ),
                    ),

                    const SizedBox(height: 10),

                    serviceDetailsWidgets.buildAddressSection(),

                    const SizedBox(height: 15),

                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          final selectedVehicle =
                              vehicleAddController.selectedVehicle.value;

                          if (selectedVehicle == null) {
                            errorSnackBar('Please Select a Vehicle');
                            return;
                          }

                          Get.to(
                            () => BookingDetailsScreen(
                              service: service,
                              vehicle: selectedVehicle,
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: whiteColor,
                          backgroundColor: blackButton,
                          padding: EdgeInsets.symmetric(
                            horizontal: 125,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Book Now',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
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
