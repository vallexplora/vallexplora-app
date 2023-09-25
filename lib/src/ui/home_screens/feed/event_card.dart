import 'dart:ffi';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/event_types.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class EventCard extends StatefulWidget {
  final String name;
  final String description;
  final int entryFee;
  final int eventType;
  final Timestamp startDate;
  final Timestamp endDate;
  final String city;
  final String imagePath;
  final Map<String, dynamic> location;

  const EventCard({
    super.key,
    required this.name,
    required this.description,
    required this.entryFee,
    required this.startDate,
    required this.city,
    required this.eventType,
    required this.endDate,
    required this.imagePath,
    required this.location,
  });

  @override
  State<StatefulWidget> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late String name;
  late String description;
  late int entryFee;
  late int eventType;
  late DateTime startDate;
  late DateTime endDate;
  late String city;
  late String imagePath;
  late Map<String, dynamic> location;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    entryFee = widget.entryFee;
    eventType = widget.eventType;
    startDate = widget.startDate.toDate();
    endDate = widget.endDate.toDate();
    city = widget.city;
    imagePath = widget.imagePath;
    location = widget.location;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 360,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: ShapeDecoration(
        color: ColorResources.twNeutral[500],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: ColorResources.twNeutral[300]!,
          ),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0, 1),
                    colors: [
                      ColorResources.mayaBlue[900]!.withOpacity(0.01),
                      ColorResources.mayaBlue[1000]!,
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, 1),
                  radius: 0,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.25),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Icon(
              EventTypeInformation.numberInfoMap[eventType].icon,
              color: ColorResources.mayaBlue[300],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    height: 128,
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: ColorResources.mayaBlue[100]!.withOpacity(0.25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: ColorResources.mayaBlue[100],
                              ),
                            ),
                            Text(
                              description,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "\$$entryFee",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: ColorResources.mayaBlue[200],
                                  ),
                                ),
                                Text(
                                  city,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: ColorResources.mayaBlue[200],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
