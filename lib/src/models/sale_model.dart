import 'package:cloud_firestore/cloud_firestore.dart';

import 'city_model.dart';

class SaleModel {
  String id;
  String name;
  String description;
  String companyID;
  Timestamp expirationDate;
  bool stackable;
  String city;

  SaleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.companyID,
    required this.expirationDate,
    required this.stackable,
    required this.city,
  });

  static Future<SaleModel> fromDocument(DocumentSnapshot document) async {
    DocumentReference<Map<String, dynamic>> cityRef = document['city'];
    String placeName;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.doc(cityRef.path).get();
    placeName = CityModel.fromDocument(docSnap).canonicalName;

    return SaleModel(
        id: document.id,
        name: document['name'],
        description: document['description'],
        companyID: document['companyID'],
        expirationDate: document['expirationDate'],
        stackable: document['stackable'],
        city: placeName);
  }
}
