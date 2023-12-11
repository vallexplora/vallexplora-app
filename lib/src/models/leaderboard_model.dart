import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/utils/theme/extended.dart';

class LeaderboardModel {
  static surfaceColors(BuildContext context, int place) {
    final t = Theme.of(context).extensions.entries.last.value as ExtendedColors;
    switch (place) {
      case 1:
        return t.gold.sys.colorContainer;
      case 2:
        return neutralRef.value87;
      case 3:
        return t.bronze.sys.colorContainer;
      default:
        return Theme.of(context).colorScheme.tertiaryContainer;
    }
  }

  static iconColors(BuildContext context, int place) {
    final t = Theme.of(context).extensions.entries.last.value as ExtendedColors;
    switch (place) {
      case 1:
        return t.gold.sys.color;
      case 2:
        return neutralRef.value30;
      case 3:
        return t.bronze.group.tone30;
      default:
        return Theme.of(context).colorScheme.tertiary;
    }
  }

  static iconBackground(BuildContext context, int place) {
    final t = Theme.of(context).extensions.entries.last.value as ExtendedColors;
    switch (place) {
      case 1:
        return t.gold.group.tone95;
      case 2:
        return neutralRef.value95;
      case 3:
        return t.bronze.group.tone95;
      default:
        return tertiaryRef.value98;
    }
  }

  static surfaceBorder(BuildContext context, int place) {
    final t = Theme.of(context).extensions.entries.last.value as ExtendedColors;
    switch (place) {
      case 1:
        return t.gold.sys.onColorContainer;
      case 2:
        return neutralRef.value17;
      case 3:
        return t.bronze.sys.onColorContainer;
      default:
        return Theme.of(context).colorScheme.onTertiaryContainer;
    }
  }
}
