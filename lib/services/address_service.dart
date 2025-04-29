import 'package:autoshine/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressService {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _userCollection = 'users';

  //---Add Address
  Future<void> addAddress(AddressModel address) async {
    final addressRef = _firestore
        .collection(_userCollection)
        .doc(uid)
        .collection('address');

    final existingAddresses = await addressRef.get();

    final data = address.toMap();
    data['isDefault'] = existingAddresses.docs.isEmpty;

    await addressRef.add(data);
  }

  //---Fetch Real time data
  Stream<List<AddressModel>> fetchAllAddress() {
    return _firestore
        .collection(_userCollection)
        .doc(uid)
        .collection('address')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => AddressModel.fromMap(doc.data()))
              .toList();
        });
  }
}
