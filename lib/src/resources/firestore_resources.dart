import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreResources {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  void updateProfile({
    required String id,
    required String username,
    required String origin,
    required List<dynamic> interests,
    required bool globalNotifications,
    required bool geoNotifications,
  }) {
    _firestore.collection("users").doc(id).set({
      "globalNotifications": globalNotifications,
      "geoNotifications": geoNotifications,
      "displayName": username,
      "origin": origin,
      "interests": interests
    }, SetOptions(merge: true));
  }

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

  Query<Object?> eventsListQuery() {
    return _firestore.collection("events");
  }

  Future<void> addUserMetaData(
      String id, List<int> interests, String origin, String? pictureURL) async {
    var ending = "";
    if (pictureURL != null && pictureURL.isNotEmpty) {
      ending = pictureURL.split(".").last;
      Reference imageReference = _storage.ref("users/profile/$id.$ending");
      await imageReference.putFile(
          File(pictureURL), SettableMetadata(contentType: "image/$ending"));
    }
    if (pictureURL != null) {
      _firestore.collection("users").doc(id).set({
        "interests": interests,
        "origin": origin,
        "pictureURL": pictureURL.isNotEmpty ? "users/profile/$id.$ending" : "",
      }, SetOptions(merge: true));
    } else {
      _firestore.collection("users").doc(id).set({
        "interests": interests,
        "origin": origin,
        "pictureURL": "",
      }, SetOptions(merge: true));
    }
  }
}
