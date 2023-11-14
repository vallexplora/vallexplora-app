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
  List<dynamic> interests;
  List<dynamic> points;
  List<dynamic> completedChallenges;
  int pointsTotal;

  UserModel({
    required this.displayName,
    required this.email,
    required this.pictureURL,
    required this.roles,
    required this.origin,
    required this.municipalitiesVisited,
    required this.globalNotifications,
    required this.geoNotifications,
    required this.interests,
    required this.points,
    required this.completedChallenges,
    required this.pointsTotal,
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
      interests: document['interests'],
      points: document['points'],
      pointsTotal: document['pointsTotal'],
      completedChallenges:
          document.data().toString().contains('completedChallenges')
              ? document['completedChallenges']
              : [],
    );
  }
}
