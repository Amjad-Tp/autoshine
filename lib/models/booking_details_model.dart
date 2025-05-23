import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDetailsModel {
  final String bookingId;
  final String serviceId;
  final String userId;
  final DateTime bookingTime;
  final String selectedVehicleId;

  BookingDetailsModel({
    required this.bookingId,
    required this.serviceId,
    required this.userId,
    required this.bookingTime,
    required this.selectedVehicleId,
  });

  // Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'serviceId': serviceId,
      'userId': userId,
      'bookingTime': Timestamp.fromDate(bookingTime),
      'selectedVehicleId': selectedVehicleId,
    };
  }

  // Convert from Firestore document
  factory BookingDetailsModel.fromMap(Map<String, dynamic> map) {
    return BookingDetailsModel(
      bookingId: map['bookingId'],
      serviceId: map['serviceId'],
      userId: map['userId'],
      bookingTime: (map['bookingTime'] as Timestamp).toDate(),
      selectedVehicleId: map['selectedVehicleId'],
    );
  }
}
