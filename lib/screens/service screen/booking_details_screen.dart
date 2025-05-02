import 'dart:developer';

import 'package:autoshine/controller/booking_controller.dart';
import 'package:autoshine/models/service_model.dart';
import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_container.dart';
import 'package:autoshine/widget/titled_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                      return GridView.builder(
                        itemCount: bookingController.timeSlots.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio:
                              2.5, // Makes buttons look wider (like pills)
                        ),
                        itemBuilder: (context, index) {
                          final slot = bookingController.timeSlots[index];
                          final isSelected =
                              bookingController.selectedSlot.value == slot.time;
                          Color color;

                          if (slot.isBooked) {
                            color = Colors.grey.shade300;
                          } else if (isSelected) {
                            color = Colors.black87;
                          } else {
                            color = Colors.green;
                          }

                          return GestureDetector(
                            onTap: () {
                              if (!slot.isBooked) {
                                bookingController.bookSlot(slot.time);
                              }
                            },
                            child: CustomContainer(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                slot.time,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),

                    const SizedBox(height: 30),

                    CustomContainer(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //--------Vehicle Details
                          Text(
                            'Vehicle Details',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          Divider(),
                          rowOfVehicleAndPriceDetails(
                            'Brand Name :',
                            vehicle.brandName,
                          ),
                          const SizedBox(height: 10),
                          rowOfVehicleAndPriceDetails(
                            'Model Name :',
                            vehicle.modelName,
                          ),
                          //-------Price Details
                          const SizedBox(height: 10),
                          Divider(),
                          Text(
                            'Service Details',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          Divider(),
                          rowOfVehicleAndPriceDetails(
                            'Service Name : ',
                            service.name,
                          ),
                          const SizedBox(height: 10),
                          rowOfVehicleAndPriceDetails(
                            'Total Price : ',
                            service.charge.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Payment Mode Column
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Mode',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    final paymentOptions = ['Cash', 'Online'];
                    return Wrap(
                      spacing: 10,
                      children:
                          paymentOptions.map((option) {
                            final isSelected =
                                bookingController.selectedPaymentMode.value ==
                                option;
                            return ChoiceChip(
                              label: Text(option),
                              selected: isSelected,
                              onSelected: (_) {
                                bookingController.selectedPaymentMode.value =
                                    option;
                              },
                              checkmarkColor: whiteColor,
                              selectedColor: blackButton,
                              backgroundColor: greyColor,
                              labelStyle: TextStyle(
                                color: isSelected ? whiteColor : blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }).toList(),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(width: 10),

            TextButton(
              onPressed: () {
                log("Service : ${service.id}");
                log("Vehicle : ${vehicle.id}");
                log(
                  "Payment Mode : ${bookingController.selectedPaymentMode.value}",
                );
                bookingController.confirmBooking(
                  service: service,
                  vehicle: vehicle,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: blackButton,
                foregroundColor: whiteColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row rowOfVehicleAndPriceDetails(String leftText, String rightText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText, style: TextStyle(fontSize: 16)),
        Flexible(
          child: Text(
            rightText,
            style: GoogleFonts.workSans(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
