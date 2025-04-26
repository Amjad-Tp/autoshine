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

  static Future<VehicleTypeModel?> getOneVehicle(String userId) async {
    final snapshot =
        await _vehicleCollection
            .where('userId', isEqualTo: userId)
            .limit(1)
            .get();

    if (snapshot.docs.isEmpty) return null;

    final data = snapshot.docs.first.data();
    return VehicleTypeModel.fromJson(data);
  }

  static Future<List<VehicleTypeModel>> fetchVehicles(String userId) async {
    final snapshot =
        await _vehicleCollection.where('userId', isEqualTo: userId).get();

    return snapshot.docs.map((doc) {
      return VehicleTypeModel.fromJson(doc.data());
    }).toList();
  }
}
