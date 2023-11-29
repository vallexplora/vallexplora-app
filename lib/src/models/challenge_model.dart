import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

class ChallengeModel {
  String id;
  String name;
  String description;
  int points;
  String cityName;

  ChallengeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.cityName,
  });

  static Future<ChallengeModel> fromDocument(DocumentSnapshot document) async {
    return ChallengeModel(
      id: document.id,
      name: document['name'],
      description: document['description'],
      points: document['points'],
      cityName: document['city'],
    );
  }
}

enum ChallengeStates {
  attained(value: 1),
  failed(value: -1),
  open(value: 0);

  final int value;

  const ChallengeStates({required this.value});
}

Map<int, Color> challengeTypeColors(context) => {
      ChallengeStates.open.value: Theme.of(context).colorScheme.primary,
      ChallengeStates.failed.value:
          Theme.of(context).colorScheme.errorContainer,
      ChallengeStates.attained.value: tertiaryRef.value98,
    };

Map<int, Color> challengeIconColors(context) => {
      ChallengeStates.open.value: Theme.of(context).colorScheme.onPrimary,
      ChallengeStates.failed.value: Theme.of(context).colorScheme.error,
      ChallengeStates.attained.value: Theme.of(context).colorScheme.tertiary,
    };

Map<int, IconData> challengeIcons = {
  ChallengeStates.open.value: Icons.pin_drop_outlined,
  ChallengeStates.failed.value: Icons.wrong_location_outlined,
  ChallengeStates.attained.value: Icons.where_to_vote_outlined,
};

DateTime getWeekStart() {
  DateTime utcNow = DateTime.now().toUtc();
  int weekday = utcNow.weekday;

  DateTime weekStart = utcNow.subtract(Duration(days: weekday - 1));
  weekStart = weekStart.copyWith(hour: 0, minute: 0, second: 0, microsecond: 0);

  return weekStart;
}

DateTime getWeekEnd() {
  DateTime weekEnd = getWeekStart().add(const Duration(days: 6));
  weekEnd =
      weekEnd.copyWith(hour: 23, minute: 59, second: 59, microsecond: 999999);

  return weekEnd;
}
