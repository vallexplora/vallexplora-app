import 'package:flutter/material.dart';

@immutable
class ExtendedSys {
  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;

  const ExtendedSys({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  ExtendedSys lerp(ExtendedSys? other, double t) {
    if (other is! ExtendedSys) {
      return this;
    }
    return ExtendedSys(
        color: Color.lerp(color, other.color, t)!,
        onColor: Color.lerp(onColor, other.onColor, t)!,
        colorContainer: Color.lerp(colorContainer, other.colorContainer, t)!,
        onColorContainer:
            Color.lerp(onColorContainer, other.onColorContainer, t)!);
  }
}

@immutable
class ExtendedGroup {
  final Color tone0;
  final Color tone5;
  final Color tone10;
  final Color tone15;
  final Color tone20;
  final Color tone25;
  final Color tone30;
  final Color tone35;
  final Color tone40;
  final Color tone50;
  final Color tone60;
  final Color tone70;
  final Color tone80;
  final Color tone90;
  final Color tone95;
  final Color tone98;
  final Color tone99;
  final Color tone100;

  const ExtendedGroup({
    required this.tone0,
    required this.tone5,
    required this.tone10,
    required this.tone15,
    required this.tone20,
    required this.tone25,
    required this.tone30,
    required this.tone35,
    required this.tone40,
    required this.tone50,
    required this.tone60,
    required this.tone70,
    required this.tone80,
    required this.tone90,
    required this.tone95,
    required this.tone98,
    required this.tone99,
    required this.tone100,
  });

  ExtendedGroup lerp(ExtendedGroup? other, double t) {
    if (other is! ExtendedGroup) {
      return this;
    }
    return ExtendedGroup(
      tone0: Color.lerp(tone0, other.tone0, t)!,
      tone5: Color.lerp(tone5, other.tone5, t)!,
      tone10: Color.lerp(tone10, other.tone10, t)!,
      tone15: Color.lerp(tone15, other.tone15, t)!,
      tone20: Color.lerp(tone20, other.tone20, t)!,
      tone25: Color.lerp(tone25, other.tone25, t)!,
      tone30: Color.lerp(tone30, other.tone30, t)!,
      tone35: Color.lerp(tone35, other.tone35, t)!,
      tone40: Color.lerp(tone40, other.tone40, t)!,
      tone50: Color.lerp(tone50, other.tone50, t)!,
      tone60: Color.lerp(tone60, other.tone60, t)!,
      tone70: Color.lerp(tone70, other.tone70, t)!,
      tone80: Color.lerp(tone80, other.tone80, t)!,
      tone90: Color.lerp(tone90, other.tone90, t)!,
      tone95: Color.lerp(tone95, other.tone95, t)!,
      tone98: Color.lerp(tone98, other.tone98, t)!,
      tone99: Color.lerp(tone99, other.tone99, t)!,
      tone100: Color.lerp(tone100, other.tone100, t)!,
    );
  }
}

@immutable
class ExtendedColor {
  final Color seed;
  final Color value;
  final ExtendedSys sys;
  final ExtendedGroup group;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.sys,
    required this.group,
  });

  ExtendedColor lerp(ExtendedColor? other, double t) {
    if (other is! ExtendedColor) {
      return this;
    }
    return ExtendedColor(
      seed: Color.lerp(seed, other.seed, t)!,
      value: Color.lerp(value, other.value, t)!,
      sys: sys.lerp(other.sys, t),
      group: group.lerp(other.group, t),
    );
  }

  ExtendedColor merge(
      {Color? seed, Color? value, ExtendedSys? sys, ExtendedGroup? group}) {
    return ExtendedColor(
      seed: seed ?? this.seed,
      value: value ?? this.value,
      sys: sys ?? this.sys,
      group: group ?? this.group,
    );
  }
}

@immutable
class ExtendedColors extends ThemeExtension<ExtendedColors> {
  final ExtendedColor tertiaryAlt;
  final ExtendedColor categoryEco;
  final ExtendedColor categoryArch;
  final ExtendedColor categoryFood;
  final ExtendedColor categoryArt;
  final ExtendedColor categorySport;
  final ExtendedColor gold;
  final ExtendedColor bronze;

  const ExtendedColors({
    required this.tertiaryAlt,
    required this.categoryEco,
    required this.categoryArch,
    required this.categoryFood,
    required this.categoryArt,
    required this.categorySport,
    required this.gold,
    required this.bronze,
  });

  @override
  ThemeExtension<ExtendedColors> copyWith({
    ExtendedColor? tertiaryAlt,
    ExtendedColor? categoryEco,
    ExtendedColor? categoryArch,
    ExtendedColor? categoryFood,
    ExtendedColor? categoryArt,
    ExtendedColor? categorySport,
    ExtendedColor? gold,
    ExtendedColor? bronze,
  }) {
    return ExtendedColors(
      tertiaryAlt: tertiaryAlt ?? this.tertiaryAlt,
      categoryEco: categoryEco ?? this.categoryEco,
      categoryArch: categoryArch ?? this.categoryArch,
      categoryFood: categoryFood ?? this.categoryFood,
      categoryArt: categoryArt ?? this.categoryArt,
      categorySport: categorySport ?? this.categorySport,
      gold: gold ?? this.gold,
      bronze: bronze ?? this.bronze,
    );
  }

  @override
  ThemeExtension<ExtendedColors> lerp(
      covariant ThemeExtension<ExtendedColors>? other, double t) {
    if (other is! ExtendedColors) {
      return this;
    }
    return ExtendedColors(
      tertiaryAlt: tertiaryAlt.lerp(other.tertiaryAlt, t),
      categoryEco: categoryEco,
      categoryArch: categoryArch,
      categoryFood: categoryFood,
      categoryArt: categoryArt,
      categorySport: categorySport,
      gold: gold,
      bronze: bronze,
    );
  }
}
