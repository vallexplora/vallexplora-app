import 'package:cloud_firestore/cloud_firestore.dart';

class Season {
  final String id;
  final List<String> challenges;
  final bool enabled;
  final Timestamp start;
  final Timestamp end;
  final String name;

  Season({
    required this.id,
    required this.challenges,
    required this.enabled,
    required this.start,
    required this.end,
    required this.name,
  });

  static Season fromQueryDocument(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Season(
      id: doc.id,
      challenges: (doc.get("challenges") as List)
          .map((e) => (e as String).trim())
          .toList(),
      enabled: doc.get("enabled") ?? true,
      start: doc.get("start"),
      end: doc.get("end"),
      name: doc.get("name"),
    );
  }
}
