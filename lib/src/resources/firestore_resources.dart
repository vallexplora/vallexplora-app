import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreResources {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> citiesList() => _firestore
      .collection("cities")
      .orderBy('canonicalName', descending: false)
      .snapshots();
}