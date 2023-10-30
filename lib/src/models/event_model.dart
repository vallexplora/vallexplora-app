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
      name: document["eventJson"]['name'],
      description: document["eventJson"]['description'],
      entryFee: document["eventJson"]['entryFee'],
      eventType: document["eventJson"]['eventType'],
      startDate: Timestamp.fromDate(DateTime.parse(document["eventJson"]['startDate'])),
      endDate: Timestamp.fromDate(DateTime.parse(document["eventJson"]['endDate'])),
      city: document["eventJson"]['city'],
      imagePath: document["eventJson"]['imagePath'],
      location: (document["eventJson"]['location'] as List<dynamic>).cast<Map<String, dynamic>>(),
      hasAugmentedReality: document["eventJson"]["hasAugmentedReality"],
    );
  }

  static EventModel fromDocSnap(QueryDocumentSnapshot<Object?> doc) {
    return EventModel(
      id: doc.id,
      name: doc.get("eventJson.name"),
      description: doc.get("eventJson.description"),
      entryFee: doc.get("eventJson.entryFee"),
      eventType: doc.get("eventJson.eventType"),
      startDate: doc.get("eventJson.startDate"),
      endDate: doc.get("eventJson.endDate"),
      city: doc.get("eventJson.city"),
      imagePath: doc.get("eventJson.imagePath"),
      location: doc.data().toString().contains("location")
          ? (doc.get("eventJson.location") as List<dynamic>).cast<Map<String, dynamic>>()
          : null,
      hasAugmentedReality: doc.get("eventJson.hasAugmentedReality"),
    );
  }
}
