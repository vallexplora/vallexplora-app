import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vallexplora/src/models/city_model.dart';

class ChallengeModel {
  String id;
  String name;
  String description;
  int points;
  Timestamp startDate;
  Timestamp expiration;
  String place;

  ChallengeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.startDate,
    required this.expiration,
    required this.place,
  });

  static Future<ChallengeModel> fromDocument(DocumentSnapshot document) async {
    DocumentReference<Map<String, dynamic>> cityRef = document['city'];
    String placeName;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.doc(cityRef.path).get();
    placeName = CityModel.fromDocument(docSnap).canonicalName;

    return ChallengeModel(
      id: document.id,
      name: document['name'],
      description: document['description'],
      points: document['points'],
      startDate: document['startDate'],
      expiration: document['expiration'],
      place: placeName,
    );
  }
}
