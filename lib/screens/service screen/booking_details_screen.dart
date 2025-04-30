import 'dart:developer';

import 'package:autoshine/controller/booking_controller.dart';
import 'package:autoshine/models/service_model.dart';
import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_container.dart';
import 'package:autoshine/widget/titled_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingDetailsScreen extends StatelessWidget {
  final ServiceModel service;
  final VehicleTypeModel vehicle;
  BookingDetailsScreen({
    super.key,
    required this.service,
    required this.vehicle,
  });
  final BookingController bookingController = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitledAppbar(title: 'Booking Details'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => bookingController.pickDate(context),
                      child: Obx(
                        () => CustomContainer(
                          decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            gradient: linearGradient,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                size: 25,
                                color: whiteColor,
                              ),
                              Text(
                                DateFormat(
                                  'dd-MM-yyyy',
                                ).format(bookingController.selectedDate.value),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: whiteColor,
                                ),
                              ),
                              const SizedBox(width: 30),
                              Text(
                                'Select Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: whiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      'Select Time Slot',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),
                    Obx(() {
                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children:
                            bookingController.timeSlots.map((slot) {
                              final isSelected =
                                  bookingController.selectedSlot.value ==
                                  slot.time;
                              Color color;

                              if (slot.isBooked) {
                                color = Colors.grey.shade300; // Not available
                              } else if (isSelected) {
                                color = Colors.grey.shade800; // Selected
                              } else {
                                color = Colors.green; // Available
                              }

                              return GestureDetector(
                                onTap: () {
                                  if (!slot.isBooked) {
                                    bookingController.bookSlot(slot.time);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    slot.time,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      );
                    }),

                    TextButton(
                      onPressed: () {
                        log("Service : ${service.id}");
                        log("Vehicle : ${vehicle.id}");
                        bookingController.confirmBooking(
                          service: service,
                          vehicle: vehicle,
                        );
                      },
                      child: Text('Confirm Booking'),
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
