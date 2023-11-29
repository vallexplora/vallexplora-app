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
  List<Map<String, dynamic>>? location;
  bool hasAugmentedReality;

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
    this.location,
    required this.hasAugmentedReality,
  });

  static Future<EventModel> fromDocument(DocumentSnapshot document) async {
    return EventModel(
      id: document.id,
      name: document['name'],
      description: document['description'],
      entryFee: document['entryFee'],
      eventType: document['eventType'],
      startDate: document['start'],
      endDate: document['end'],
      city: document['city'],
      imagePath: document['imagePath'],
      location:
          (document['location'] as List<dynamic>).cast<Map<String, dynamic>>(),
      hasAugmentedReality: document["hasAugmentedReality"],
    );
  }

  static EventModel fromDocSnap(QueryDocumentSnapshot<Object?> doc) {
    return EventModel(
      id: doc.id,
      name: doc.get("name"),
      description: doc.get("description"),
      entryFee: doc.get("entryFee"),
      eventType: doc.get("eventType"),
      startDate: doc.get("start"),
      endDate: doc.get("end"),
      city: doc.get("city"),
      imagePath: doc.get("imagePath"),
      location: doc.data().toString().contains("location")
          ? (doc.get("location") as List<dynamic>).cast<Map<String, dynamic>>()
          : null,
      hasAugmentedReality: doc.get("hasAugmentedReality"),
    );
  }
}
