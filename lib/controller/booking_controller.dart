import 'package:autoshine/functions/custom_snack_bar.dart';
import 'package:autoshine/models/booking_slot_model.dart';
import 'package:autoshine/models/service_model.dart';
import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/screens/service%20screen/Booking_confiremed_screen.dart';
import 'package:autoshine/services/booking_service.dart';
import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var selectedSlot = ''.obs;
  var timeSlots = <TimeSlotModel>[].obs;

  var selectedPaymentMode = 'Cash'.obs;

  final List<String> allSlots = [
    '07:00 AM',
    '08:00 AM',
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
  ];

  final BookingService _bookingService = BookingService();

  @override
  void onInit() {
    super.onInit();
    fetchSlotsForDate();
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: darkYellowButton,
              onPrimary: whiteColor,
              onSurface: darkYellowButton,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: darkYellowButton),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      fetchSlotsForDate();
    }
  }

  Future<void> fetchSlotsForDate() async {
    timeSlots.value = await _bookingService.fetchTimeSlots(
      selectedDate.value,
      allSlots,
    );
  }

  void bookSlot(String slot) {
    selectedSlot.value = slot;
  }

  // Confirm booking
  Future<void> confirmBooking({
    required ServiceModel service,
    required VehicleTypeModel vehicle,
  }) async {
    try {
      if (selectedSlot.value.isEmpty) {
        errorSnackBar('Please select a Time slot!');
        return;
      }

      await _bookingService.confirmBooking(
        selectedDate: selectedDate.value,
        selectedSlot: selectedSlot.value,
        service: service,
        vehicle: vehicle,
      );

      await fetchSlotsForDate();
      selectedSlot.value = '';
      successSnackBar('Booking confirmed!');
      Get.to(() => BookingConfiremedScreen());
    } catch (e) {
      errorSnackBar('Failed to book: $e');
    }
  }
}
