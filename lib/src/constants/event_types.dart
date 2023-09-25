import 'package:flutter/material.dart';

class EventTypeInformation {
  final IconData icon;
  final String text;

  EventTypeInformation({
    required this.icon,
    required this.text,
  });

  static Map<int, dynamic> numberInfoMap = {
    1: EventTypeInformation(
        icon: Icons.sports_soccer_outlined, text: 'Deportes y Espectáculo'),
    2: EventTypeInformation(
        icon: Icons.soup_kitchen_outlined, text: 'Gastronomía'),
    3: EventTypeInformation(
        icon: Icons.church_outlined, text: 'Historia y Arquitectura'),
    4: EventTypeInformation(
        icon: Icons.palette_outlined, text: 'Arte y Cultura'),
    5: EventTypeInformation(icon: Icons.eco_outlined, text: 'Ecoturismo'),
  };
}
