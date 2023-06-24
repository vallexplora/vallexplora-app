import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vallexplora/src/models/city_model.dart';

class FirestoreResources {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> eventsList() => _firestore
      .collection("events")
      .orderBy("startDate", descending: false)
      .snapshots();

  // This method only exists for demo purposes.
  // Final product SHOULDN'T allow for in app
  // administration, since that responsibility is
  // relegated to the web admin panel.
  Future<void> addNewEvent(
      {required String name,
      required description,
      required int entryFee,
      required Timestamp startDate,
      required String city}) {
    if (!CityModel.isValid(city)) {
      city = "cali";
    }

    return _firestore.collection("events").add({
      'name': name,
      'description': description,
      'entryFee': entryFee,
      'startDate': startDate,
      'city': _firestore.doc("/cities/$city"),
    });
  }

  Stream<QuerySnapshot> salesList() => _firestore
      .collection("sales")
      .orderBy("startDate", descending: false)
      .snapshots();

  Stream<QuerySnapshot> citiesList() => _firestore
      .collection("cities")
      .orderBy('canonicalName', descending: false)
      .snapshots();

  Stream<QuerySnapshot> challengesList() => _firestore
      .collection("challenges")
      .orderBy('points', descending: true)
      .snapshots();

  // This method only exists for demo purposes.
  // Final product SHOULDN'T allow for in app
  // administration, since that responsibility is
  // relegated to the web admin panel.
  Future<void> addNewChallenge(
      {required String name,
      required description,
      required int points,
      required Timestamp startDate,
      required Timestamp expiration,
      required String place}) {
    if (!CityModel.isValid(place)) {
      place = "cali";
    }

    return _firestore.collection("challenges").add({
      'name': name,
      'description': description,
      'points': points,
      'startDate': startDate,
      'expiration': expiration,
      'place': _firestore.doc("/cities/$place"),
    });
  }
}
