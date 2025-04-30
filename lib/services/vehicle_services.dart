import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleService {
  static final _firestore = FirebaseFirestore.instance;
  static final _userCollection = _firestore.collection('users');

  // --- Add Vehicle under user's document ---
  static Future<void> addVehicle({
    required String userId,
    required VehicleTypeModel vehicle,
    required bool isTwoWheeler,
  }) async {
    await _userCollection
        .doc(userId)
        .collection('vehicles')
        .doc(vehicle.id)
        .set({'isTwoWheeler': isTwoWheeler, ...vehicle.toMap()});
  }

  // --- Get one vehicle (example purpose) ---
  static Future<VehicleTypeModel?> getOneVehicle(String userId) async {
    final snapshot =
        await _userCollection.doc(userId).collection('vehicles').limit(1).get();

    if (snapshot.docs.isEmpty) return null;

    final doc = snapshot.docs.first;
    return VehicleTypeModel.fromMap(doc.data(), doc.id);
  }

  // --- Fetch all vehicles of the user ---
  static Stream<List<VehicleTypeModel>> fetchVehicles(String userId) {
    return _userCollection.doc(userId).collection('vehicles').snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) {
        return VehicleTypeModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
