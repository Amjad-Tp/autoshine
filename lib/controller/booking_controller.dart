import 'package:autoshine/functions/custom_snack_bar.dart';
import 'package:autoshine/models/booking_slot_model.dart';
import 'package:autoshine/models/bookint_details_model.dart';
import 'package:autoshine/models/service_model.dart';
import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/values/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
              primary: darkBlueButton,
              onPrimary: whiteColor,
              onSurface: darkBlueButton,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: darkBlueButton),
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
    String dateKey = _getDateKey(selectedDate.value);

    final slotsSnapshot =
        await FirebaseFirestore.instance
            .collection('bookings')
            .doc(dateKey)
            .collection('slots')
            .get();

    Map<String, bool> bookedSlots = {
      for (var s in slotsSnapshot.docs) s.id: s['isBooked'] ?? false,
    };

    DateTime now = DateTime.now();
    bool isToday = _getDateKey(now) == dateKey;

    timeSlots.value =
        allSlots.map((slot) {
          bool isBooked = bookedSlots[slot] ?? false;

          // Disable if time has already passed today
          if (isToday) {
            DateTime slotTime = DateFormat('hh:mm a').parse(slot);
            DateTime slotDateTime = DateTime(
              now.year,
              now.month,
              now.day,
              slotTime.hour,
              slotTime.minute,
            );
            if (slotDateTime.isBefore(now)) {
              isBooked = true;
            }
          }

          return TimeSlotModel(time: slot, isBooked: isBooked);
        }).toList();
  }

  void bookSlot(String slot) {
    selectedSlot.value = slot;
  }

  String _getDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  var selectedVehicleId = ''.obs;

  // Call this function to save booking
  Future<void> confirmBooking({
    required ServiceModel service,
    required VehicleTypeModel vehicle,
  }) async {
    try {
      if (selectedSlot.value.isEmpty) {
        errorSnackBar('Please select a Time slot!');
        return;
      }

      String dateKey = _getDateKey(selectedDate.value);
      String slotTime = selectedSlot.value;

      // Mark the time slot as booked
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(dateKey)
          .collection('slots')
          .doc(slotTime)
          .set({'isBooked': true});

      final user = FirebaseAuth.instance.currentUser;
      final bookingId = const Uuid().v4();

      final booking = BookingDetailsModel(
        bookingId: bookingId,
        serviceId: service.id,
        userId: user!.uid,
        bookingTime: DateTime(
          selectedDate.value.year,
          selectedDate.value.month,
          selectedDate.value.day,
          DateFormat('hh:mm a').parse(slotTime).hour,
          DateFormat('hh:mm a').parse(slotTime).minute,
        ),
        selectedVehicleId: vehicle.id,
      );

      await FirebaseFirestore.instance
          .collection('confirmedBookings')
          .doc(bookingId)
          .set(booking.toMap());

      successSnackBar('Booking confirmed!');
    } catch (e) {
      errorSnackBar('Failed to book: $e');
    }
  }
}
