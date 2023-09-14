import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class EventCard extends StatefulWidget {
  final String name;
  final String description;
  final int entryFee;
  final Timestamp startDate;
  final String place;

  const EventCard({
    super.key,
    required this.name,
    required this.description,
    required this.entryFee,
    required this.startDate,
    required this.place,
  });

  @override
  State<StatefulWidget> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late String name;
  late String description;
  late int entryFee;
  late DateTime startDate;
  late String place;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    entryFee = widget.entryFee;
    startDate = widget.startDate.toDate();
    place = widget.place;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 320,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: ShapeDecoration(
        color: ColorResources.twNeutral[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: ColorResources.twNeutral[300]!,
          ),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Container(
            height: 128,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: ShapeDecoration(
              color: ColorResources.mayaBlue[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$$entryFee",
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
