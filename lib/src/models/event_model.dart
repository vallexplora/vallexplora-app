import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String id;
  String name;
  String description;
  int entryFee;
  int eventType;
  Timestamp startDate;
  Timestamp endDate;
  String city;
  String imagePath;
  Map<String, dynamic> location;

  EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.entryFee,
    required this.eventType,
    required this.startDate,
    required this.endDate,
    required this.city,
    required this.imagePath,
    required this.location,
  });

  static Future<EventModel> fromDocument(DocumentSnapshot document) async {
    return EventModel(
      id: document.id,
      name: document["eventJson"]['name'],
      description: document["eventJson"]['description'],
      entryFee: document["eventJson"]['entryFee'],
      eventType: document["eventJson"]['eventType'],
      startDate: document["eventJson"]['startDate'],
      endDate: document["eventJson"]['endDate'],
      city: document["eventJson"]['city'],
      imagePath: document["eventJson"]['imagePath'],
      location: document["eventJson"]['location'],
    );
  }
}
