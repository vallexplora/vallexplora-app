import 'package:cloud_firestore/cloud_firestore.dart';

import 'city_model.dart';

class EventModel {
  String id;
  String name;
  String description;
  int entryFee;
  Timestamp startDate;
  String city;

  EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.entryFee,
    required this.startDate,
    required this.city,
  });

  static Future<EventModel> fromDocument(DocumentSnapshot document) async {
    DocumentReference<Map<String, dynamic>> cityRef = document['city'];
    String placeName;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.doc(cityRef.path).get();
    placeName = CityModel.fromDocument(docSnap).canonicalName;

    return EventModel(
        id: document.id,
        name: document['name'],
        description: document['description'],
        entryFee: document['entryFee'],
        startDate: document['startDate'],
        city: placeName);
  }
}
