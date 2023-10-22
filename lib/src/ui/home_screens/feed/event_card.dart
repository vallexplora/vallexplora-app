import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/event_types.dart';

import '../../../constants/colors.dart';

class EventCard extends StatefulWidget {
  final String name;
  final String description;
  final int entryFee;
  final int eventType;
  final Timestamp startDate;
  final Timestamp endDate;
  final String city;
  final String imagePath;
  final Map<String, dynamic>? location;
  final List<Map<String, dynamic>>? points;

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
    this.location,
    this.points,
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
  late Map<String, dynamic>? location;
  late List<Map<String, dynamic>>? points;

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
    points = widget.points;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 360,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: ShapeDecoration(
        color: neutralRef.value50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: neutralRef.value80,
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
                      primaryRef.value12.withOpacity(0.01),
                      primaryRef.value5,
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
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
