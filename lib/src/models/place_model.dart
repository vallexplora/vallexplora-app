import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  String id;
  String name;
  String shortDescription;
  int fee;
  String climate;
  String closeTime;
  String openTime;
  String cityName;
  String imageUrl;
  String imageAlt;
  bool enabled;
  bool hasAugmentedReality;
  List<Map<String, dynamic>> area;
  List<Map<String, dynamic>>? arText;


  PlaceModel({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.fee,
    required this.climate,
    required this.closeTime,
    required this.openTime,
    required this.cityName,
    required this.imageUrl,
    required this.imageAlt,
    required this.enabled,
    required this.hasAugmentedReality,
    required this.area,
    this.arText,
  });

  static Future<PlaceModel> fromDocument(DocumentSnapshot document) async {
    return PlaceModel(
      id: document.id,
      name: document['name'],
      shortDescription: document['shortDescription'],
      fee: document['fee'],
      climate: document['climate'],
      closeTime: document['closeTime'],
      openTime: document['openTime'],
      cityName: document['cityName'],
      imageUrl: document['imageUrl'],
      imageAlt: document['imageAlt'],
      enabled: document["enabled"],
      hasAugmentedReality: document["hasAugmentedReality"],
      area: (document["area"]).cast<Map<String, dynamic>>(),
      arText: document.data().toString().contains("arText") ? (document["arText"] ?? []).cast<Map<String, dynamic>>() : [],
    );
  }

  static PlaceModel fromDocSnap(QueryDocumentSnapshot<Object?> doc) {
    return PlaceModel(
      id: doc.id,
      name: doc.get("name"),
      shortDescription: doc.get("shortDescription"),
      fee: doc.get("fee"),
      climate: doc.get("climate"),
      closeTime: doc.get("closeTime"),
      openTime: doc.get("openTime"),
      cityName: doc.get("cityName"),
      imageUrl: doc.get("imageUrl"),
      imageAlt: doc.get('imageAlt'),
      enabled: doc.get("enabled"),
      hasAugmentedReality: doc.get("hasAugmentedReality"),
      area: (doc.get("area")).cast<Map<String, dynamic>>(),
      arText: (doc.get("arText") ?? []).cast<Map<String, dynamic>>(),
    );
  }
}
