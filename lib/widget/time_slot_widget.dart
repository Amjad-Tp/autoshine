import 'package:autoshine/controller/booking_controller.dart';
import 'package:autoshine/models/booking_slot_model.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlotWidget extends StatelessWidget {
  final TimeSlotModel slot;
  final BookingController controller;

  const TimeSlotWidget({
    super.key,
    required this.slot,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedSlot.value == slot.time;
      Color color;

      if (slot.isBooked) {
        color = timeSlotLightGrey;
      } else if (isSelected) {
        color = timeSlotDark;
      } else {
        color = timeSlotGreen;
      }

      return GestureDetector(
        onTap: () {
          if (!slot.isBooked) {
            controller.bookSlot(slot.time);
          }
        },
        child: CustomContainer(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
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
    });
  }
}
