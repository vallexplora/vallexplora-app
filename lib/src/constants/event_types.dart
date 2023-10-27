import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventTypeInformation {
  final IconData icon;
  final String text;

  EventTypeInformation({
    required this.icon,
    required this.text,
  });

  static Map<int, dynamic> numberInfoMap(context) => {
        1: EventTypeInformation(
            icon: Icons.sports_soccer_outlined,
            text: AppLocalizations.of(context)!.gSportsCategory),
        2: EventTypeInformation(
            icon: Icons.soup_kitchen_outlined,
            text: AppLocalizations.of(context)!.gGastroCategory),
        3: EventTypeInformation(
            icon: Icons.church_outlined,
            text: AppLocalizations.of(context)!.gHistoryCategory),
        4: EventTypeInformation(
            icon: Icons.palette_outlined,
            text: AppLocalizations.of(context)!.gArtCategory),
        5: EventTypeInformation(
            icon: Icons.eco_outlined,
            text: AppLocalizations.of(context)!.gEcoCategory),
      };
}
