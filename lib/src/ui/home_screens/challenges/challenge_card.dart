import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/models/challenge_model.dart';

class ChallengeCard extends StatefulWidget {
  final String name;
  final String description;
  final int points;
  final Timestamp startDate;
  final Timestamp expiration;
  final String place;
  final int type;

  const ChallengeCard({
    super.key,
    required this.name,
    required this.description,
    required this.points,
    required this.startDate,
    required this.expiration,
    required this.place,
    required this.type,
  });

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  late String name;
  late String description;
  late int points;
  late DateTime startDate;
  late DateTime expirationDate;
  late String place;
  late int type;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    points = widget.points;
    startDate = widget.startDate.toDate();
    expirationDate = widget.expiration.toDate();
    place = widget.place;
    type = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 112,
      decoration: ShapeDecoration(
        color: type == ChallengeStates.attained.value
            ? Theme.of(context).colorScheme.tertiaryContainer
            : Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: type == ChallengeStates.attained.value
                ? Theme.of(context).colorScheme.onTertiaryContainer
                : Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              bottom: 16,
              top: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: challengeTypeColors(context)[type],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(128),
                    ),
                  ),
                  child: Icon(
                    challengeIcons[type],
                    color: challengeIconColors(context)[type],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                            TextStyle(
                                color: type == ChallengeStates.attained.value
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer
                                    : Theme.of(context).colorScheme.onSurface),
                          ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 160),
                      child: Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyMedium!.merge(
                              TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 96,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    points.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${type == -1 ? "Venció hace" : "Vence en"} ${DateTime.now().difference(expirationDate).inDays.abs()} días",
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
