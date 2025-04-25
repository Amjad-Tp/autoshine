import 'package:autoshine/models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarwashServices {
  final _firestore = FirebaseFirestore.instance;
  final String _collection = 'services';

  Future<List<ServiceModel>> getAllServices() async {
    final snapshot = await _firestore.collection(_collection).get();
    return snapshot.docs
        .map((doc) => ServiceModel.fromMap(doc.data()))
        .toList();
  }

  Stream<List<ServiceModel>> streamServices() {
    return _firestore
        .collection(_collection)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ServiceModel.fromMap(doc.data()))
                  .toList(),
        );
  }
}
