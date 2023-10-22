import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

import '../../../constants/sizes.dart';

class ChallengeCard extends StatefulWidget {
  final String name;
  final String description;
  final int points;
  final Timestamp startDate;
  final Timestamp expiration;
  final String place;

  const ChallengeCard({
    super.key,
    required this.name,
    required this.description,
    required this.points,
    required this.startDate,
    required this.expiration,
    required this.place,
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

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    points = widget.points;
    startDate = widget.startDate.toDate();
    expirationDate = widget.expiration.toDate();
    place = widget.place;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: ShapeDecoration(
        color: neutralRef.value94,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: neutralRef.value70,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 128,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: ShapeDecoration(
              color: primaryRef.value92,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$points puntos",
                ),
                Text(
                  place,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: SizeResources.buttonHeight,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "${startDate.day}/${startDate.month}/${startDate.year}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "Expira en ${expirationDate.difference(startDate).inDays} días",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
