import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreResources {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Events

  Stream<QuerySnapshot> eventsList() => _firestore
      .collection("events")
      .orderBy("eventJson.startDate", descending: false)
      .snapshots();

  // Sales

  Stream<QuerySnapshot> salesList() => _firestore
      .collection("discounts")
      .orderBy("expirationDate", descending: false)
      .snapshots();

  // Map

  Stream<QuerySnapshot> citiesList() => _firestore
      .collection("city")
      .orderBy('canonicalName', descending: false)
      .snapshots();

  // Challenges

  Stream<QuerySnapshot> challengesList() => _firestore
      .collection("challenges")
      .orderBy('points', descending: true)
      .snapshots();

  // Profile

  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getUserInfo(
          Future<String> uid) async =>
      _firestore.collection("users").doc(await uid).snapshots();

  Future<void> updateUsername(
          {required String id, required String username}) async =>
      _firestore
          .collection("users")
          .doc(id)
          .set({"displayName": username}, SetOptions(merge: true));

  Future<void> updateEmail({required String id, required String email}) async =>
      _firestore
          .collection("users")
          .doc(id)
          .set({"email": email}, SetOptions(merge: true));

  void updateGlobalNotifications({required String id, required bool value}) =>
      _firestore
          .collection("users")
          .doc(id)
          .set({"globalNotifications": value}, SetOptions(merge: true));

  void updateGeoNotifications({required String id, required bool value}) =>
      _firestore
          .collection("users")
          .doc(id)
          .set({"geoNotifications": value}, SetOptions(merge: true));
}
