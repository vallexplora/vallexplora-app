import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/models/challenge_model.dart';
import 'package:vallexplora/src/ui/home_screens/challenges/challenge_detail_screen.dart';

class ChallengeCard extends StatefulWidget {
  final String id;
  final String name;
  final String description;
  final int points;
  final String place;
  final int type;
  final Stream<String> proofImage;
  final Function pickImageFromGallery;
  final ValueSetter<String> changeProofImage;
  final DateTime expiration;
  final Function(String, int) markAsDone;

  const ChallengeCard({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.place,
    required this.type,
    required this.proofImage,
    required this.pickImageFromGallery,
    required this.changeProofImage,
    required this.expiration,
    required this.markAsDone,
  });

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  late String id;
  late String name;
  late String description;
  late int points;
  late String place;
  late int type;
  late DateTime expiration;
  late Stream<String> proofImage;
  late Function pickImageFromGallery;
  late ValueSetter<String> changeProofImage;
  late Function(String, int) markAsDone;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    name = widget.name;
    description = widget.description;
    points = widget.points;
    place = widget.place;
    type = widget.type;
    proofImage = widget.proofImage;
    pickImageFromGallery = widget.pickImageFromGallery;
    changeProofImage = widget.changeProofImage;
    expiration = widget.expiration;
    markAsDone = widget.markAsDone;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.none,
        builder: (context) => ChallengeDetailScreen(
          id: id,
          name: name,
          description: description,
          points: points,
          place: place,
          type: type,
          proofImage: proofImage,
          pickImageFromGallery: pickImageFromGallery,
          changeProofImage: changeProofImage,
          expirationDate: expiration,
          markAsDone: markAsDone,
        ),
      ),
      child: Container(
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
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 144),
                        child: Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.bodyMedium!.merge(
                                TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
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
              width: 88,
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
                      "${type == -1 ? "Venció hace" : "Vence en"} ${DateTime.now().difference(expiration).inDays.abs()} días",
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
