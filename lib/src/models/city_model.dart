import 'package:cloud_firestore/cloud_firestore.dart';

class CityModel {
  String id;
  String canonicalName;

  static final List _validCitieIds = [
    "aguila",
    "alcala",
    "andalucia",
    "ansermanuevo",
    "argelia",
    "bolivar",
    "buenaventura",
    "buga",
    "bugalagrande",
    "caicedonia",
    "cairo",
    "cali",
    "calima",
    "candelaria",
    "cartago",
    "cerrito",
    "cumbre",
    "dagua",
    "dovio",
    "florida",
    "ginebra",
    "guacari",
    "jamundi",
    "launion",
    "obando",
    "palmira",
    "pradera",
    "restrepo",
    "riofrio",
    "roldanillo",
    "sanpedro",
    "sevilla",
    "toro",
    "trujillo ",
    "tulua ",
    "ulloa ",
    "versalles ",
    "victoria",
    "vijes ",
    "yotoco ",
    "yumbo ",
    "zarzal"
  ];

  CityModel({required this.id, required this.canonicalName});

  factory CityModel.fromDocument(DocumentSnapshot document) {
    return CityModel(
      id: document.id,
      canonicalName: document['canonicalName'],
    );
  }

  static bool isValid(String city) {
    return _validCitieIds.contains(city);
  }
}
