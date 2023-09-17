import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String displayName;
  String email;
  String pictureURL;
  List<dynamic> roles;
  String origin;
  int municipalitiesVisited;
  bool globalNotifications;
  bool geoNotifications;

  UserModel({
    required this.displayName,
    required this.email,
    required this.pictureURL,
    required this.roles,
    required this.origin,
    required this.municipalitiesVisited,
    required this.globalNotifications,
    required this.geoNotifications,
  });

  static UserModel fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return UserModel(
      displayName: document['displayName'],
      email: document['email'],
      roles: document['roles'],
      origin: document['origin'],
      municipalitiesVisited: document['municipalitiesVisited'],
      globalNotifications: document['globalNotifications'],
      geoNotifications: document['geoNotifications'],
      pictureURL: document['pictureURL'],
    );
  }
}
