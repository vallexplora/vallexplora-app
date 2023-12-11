import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/season_model.dart';

class FirestoreResources {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Events

  Stream<QuerySnapshot> eventsList() => _firestore
      .collection("events")
      .orderBy("start", descending: false)
      .snapshots();

  // Sales

  Stream<QuerySnapshot> salesList() => _firestore
      .collection("rewards")
      .orderBy("end", descending: false)
      .snapshots();

  // Map

  Stream<QuerySnapshot> citiesList() => _firestore
      .collection("city")
      .orderBy('canonicalName', descending: false)
      .snapshots();

  // Challenges

  Future<List<Stream<QuerySnapshot<Map<String, dynamic>>>>>
      challengesList() async {
    final seasons = await _firestore
        .collection('seasons')
        .orderBy('end', descending: true)
        .limit(1)
        .get();
    final seasonChallenges =
        Season.fromQueryDocument(seasons.docs.first).challenges;

    List<QuerySnapshot<Map<String, dynamic>>> currentSeasonChallenges = [];

    for (String challengeId in seasonChallenges) {
      QuerySnapshot<Map<String, dynamic>> challengeSnapshot = await _firestore
          .collection('challenges')
          .where(FieldPath.documentId, isEqualTo: challengeId)
          .get();

      currentSeasonChallenges.add(challengeSnapshot);
    }

    List<QuerySnapshot<Map<String, dynamic>>> allOtherChallenges = [];

    for (String challengeId in seasonChallenges) {
      QuerySnapshot<Map<String, dynamic>> challengeSnapshot = await _firestore
          .collection('challenges')
          .where(FieldPath.documentId, isNotEqualTo: challengeId)
          .get();

      allOtherChallenges.add(challengeSnapshot);
    }

    return [
      Stream.fromIterable(currentSeasonChallenges),
      Stream.fromIterable(allOtherChallenges)
    ];
  }

  Future<Timestamp> getCurrentExpirationDate() async {
    final snaps = await _firestore
        .collection("seasons")
        .orderBy("end", descending: true)
        .limit(1)
        .get();
    return snaps.docs.first.data()["end"];
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getLatestSeason() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('seasons')
        .orderBy('end', descending: true)
        .limit(1)
        .get();
    return snapshot.docs.first;
  }

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
    if (id.isEmpty) return;
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
        "completedChallenges": [],
        "points": [
          {"claimedOn": Timestamp.now(), "amount": 0}
        ],
        "pointsTotal": 0,
        "globalNotifications": false,
        "geoNotifications": false,
        "municipalitiesVisited": 1,
      }, SetOptions(merge: true));
    } else {
      _firestore.collection("users").doc(id).set({
        "interests": interests,
        "origin": origin,
        "pictureURL": "",
        "completedChallenges": [],
        "points": [
          {"claimedOn": Timestamp.now(), "amount": 0}
        ],
        "pointsTotal": 0,
        "globalNotifications": false,
        "geoNotifications": false,
        "municipalitiesVisited": 1,
      }, SetOptions(merge: true));
    }
  }

  Future<void> markChallengeAsDone(
      Future<String> uid, String challengeId, int points) async {
    // final seasons = await _firestore
    //     .collection('seasons')
    //     .orderBy('end', descending: true)
    //     .limit(1)
    //     .get();
    // final String seasonId = Season.fromQueryDocument(seasons.docs.first).id;
    // final Map<String, dynamic> pointsField =
    //     UserModel.fromDocument(await (await getUserInfo(uid)).first)
    //         .points
    //         .firstWhere((a) {
    //   return (a as Map<String, dynamic>)["seasonId"] == seasonId;
    // });
    // Logger l = Logger();
    // l.i(pointsField);
    // pointsField["amount"] = (pointsField["amount"] as int) + points;
    _firestore.collection("users").doc(await uid).update({
      "completedChallenges": FieldValue.arrayUnion([challengeId]),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPodium() {
    return _firestore
        .collection("users")
        .where("roles", arrayContains: 'tourist')
        .orderBy('roles')
        // .orderBy("points.claimedOn", descending: true) // TODO: figure out how to actually do this thing
        // .orderBy("points.amount", descending: true)
        .snapshots();
  }
}
