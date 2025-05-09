import 'package:autoshine/models/booking_slot_model.dart';
import 'package:autoshine/models/booking_details_model.dart';
import 'package:autoshine/models/service_model.dart';
import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<List<TimeSlotModel>> fetchTimeSlots(
    DateTime selectedDate,
    List<String> allSlots,
  ) async {
    String dateKey = getDateKey(selectedDate);
    final snapshot =
        await _firestore
            .collection('bookings')
            .doc(dateKey)
            .collection('slots')
            .get();

    Map<String, bool> bookedSlots = {
      for (var doc in snapshot.docs) doc.id: doc['isBooked'] ?? false,
    };

    DateTime now = DateTime.now();
    bool isToday = getDateKey(now) == dateKey;

    return allSlots.map((slot) {
      bool isBooked = bookedSlots[slot] ?? false;

      if (isToday) {
        DateTime slotTime = DateTime(
          now.year,
          now.month,
          now.day,
          DateFormat('hh:mm a').parse(slot).hour,
          DateFormat('hh:mm a').parse(slot).minute,
        );
        if (slotTime.isBefore(now)) isBooked = true;
      }

      return TimeSlotModel(time: slot, isBooked: isBooked);
    }).toList();
  }

  Future<void> confirmBooking({
    required DateTime selectedDate,
    required String selectedSlot,
    required ServiceModel service,
    required VehicleTypeModel vehicle,
  }) async {
    String dateKey = getDateKey(selectedDate);

    await _firestore
        .collection('bookings')
        .doc(dateKey)
        .collection('slots')
        .doc(selectedSlot)
        .set({'isBooked': true});

    final user = _auth.currentUser;
    final bookingId = const Uuid().v4();

    final booking = BookingDetailsModel(
      bookingId: bookingId,
      serviceId: service.id,
      userId: user!.uid,
      bookingTime: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        DateFormat('hh:mm a').parse(selectedSlot).hour,
        DateFormat('hh:mm a').parse(selectedSlot).minute,
      ),
      selectedVehicleId: vehicle.id,
    );

    await _firestore
        .collection('confirmedBookings')
        .doc(bookingId)
        .set(booking.toMap());
  }

  Stream<List<BookingDetailsModel>> fetchUserBookings() {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _firestore
        .collection('confirmedBookings')
        .where('userId', isEqualTo: user.uid)
        .orderBy('bookingTime', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => BookingDetailsModel.fromMap(doc.data()))
              .toList();
        });
  }
}
