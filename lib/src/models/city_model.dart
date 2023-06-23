import 'package:cloud_firestore/cloud_firestore.dart';

class CityModel {
  String id;
  String canonicalName;

  CityModel({required this.id, required this.canonicalName});

  factory CityModel.fromDocument(DocumentSnapshot document) {
    return CityModel(
      id: document.id,
      canonicalName: document['canonicalName'],
    );
  }
}
