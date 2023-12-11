import 'package:cloud_firestore/cloud_firestore.dart';

class SaleModel {
  String id;
  String name;
  String description;
  String companyName;
  DateTime end;
  DateTime start;
  int requirement;
  bool requirementType;
  String city;

  SaleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.companyName,
    required this.end,
    required this.start,
    required this.requirement,
    required this.requirementType,
    required this.city,
  });

  static SaleModel fromDocument(DocumentSnapshot document) {
    return SaleModel(
      id: document.id,
      name: document['name'],
      description: document['description'],
      companyName: document['companyName'],
      end: (document['end'] as Timestamp).toDate(),
      start: (document['start'] as Timestamp).toDate(),
      requirement: document['requeriment'],
      requirementType: document['requirementType'],
      city: document['city'],
    );
  }
}
