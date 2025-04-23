import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleService {
  static final _vehicleCollection = FirebaseFirestore.instance.collection(
    'vehicles',
  );

  static Future<void> addVehicle({
    required String userId,
    required VehicleTypeModel vehicle,
    required bool isTwoWheeler,
  }) async {
    await _vehicleCollection.add({
      'userId': userId,
      'isTwoWheeler': isTwoWheeler,
      ...vehicle.toJson(),
    });
  }
}
