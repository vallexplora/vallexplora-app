import 'package:flutter/material.dart';

@immutable
class RefColor {
  final Color value0;
  final Color value10;
  final Color value20;
  final Color value30;
  final Color value40;
  final Color value50;
  final Color value60;
  final Color value70;
  final Color value80;
  final Color value90;
  final Color value95;
  final Color value99;
  final Color value100;
  final Color value4;
  final Color value6;
  final Color value12;
  final Color value17;
  final Color value22;
  final Color value24;
  final Color value87;
  final Color value92;
  final Color value94;
  final Color value96;
  final Color value5;
  final Color value25;
  final Color value35;
  final Color value98;

  const RefColor({
    required this.value0,
    required this.value10,
    required this.value20,
    required this.value30,
    required this.value40,
    required this.value50,
    required this.value60,
    required this.value70,
    required this.value80,
    required this.value90,
    required this.value95,
    required this.value99,
    required this.value100,
    required this.value4,
    required this.value6,
    required this.value12,
    required this.value17,
    required this.value22,
    required this.value24,
    required this.value87,
    required this.value92,
    required this.value94,
    required this.value96,
    required this.value5,
    required this.value25,
    required this.value35,
    required this.value98,
  });

  RefColor lerp(RefColor? other, double t) {
    if (other is! RefColor) {
      return this;
    }
    return RefColor(
      value0: Color.lerp(value0, other.value0, t)!,
      value10: Color.lerp(value10, other.value10, t)!,
      value20: Color.lerp(value20, other.value20, t)!,
      value30: Color.lerp(value30, other.value30, t)!,
      value40: Color.lerp(value40, other.value40, t)!,
      value50: Color.lerp(value50, other.value50, t)!,
      value60: Color.lerp(value60, other.value60, t)!,
      value70: Color.lerp(value70, other.value70, t)!,
      value80: Color.lerp(value80, other.value80, t)!,
      value90: Color.lerp(value90, other.value90, t)!,
      value95: Color.lerp(value95, other.value95, t)!,
      value99: Color.lerp(value99, other.value99, t)!,
      value100: Color.lerp(value100, other.value100, t)!,
      value4: Color.lerp(value4, other.value4, t)!,
      value6: Color.lerp(value6, other.value6, t)!,
      value12: Color.lerp(value12, other.value12, t)!,
      value17: Color.lerp(value17, other.value17, t)!,
      value22: Color.lerp(value22, other.value22, t)!,
      value24: Color.lerp(value24, other.value24, t)!,
      value87: Color.lerp(value87, other.value87, t)!,
      value92: Color.lerp(value92, other.value92, t)!,
      value94: Color.lerp(value94, other.value94, t)!,
      value96: Color.lerp(value96, other.value96, t)!,
      value5: Color.lerp(value5, other.value5, t)!,
      value25: Color.lerp(value25, other.value25, t)!,
      value35: Color.lerp(value35, other.value35, t)!,
      value98: Color.lerp(value98, other.value98, t)!,
    );
  }
}

@immutable
class RefColors extends ThemeExtension<RefColors> {
  final RefColor primary;
  final RefColor secondary;
  final RefColor tertiary;
  final RefColor error;
  final RefColor neutral;
  final RefColor neutralVariant;

  const RefColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.error,
    required this.neutral,
    required this.neutralVariant,
  });

  @override
  ThemeExtension<RefColors> copyWith({
    RefColor? primary,
    RefColor? secondary,
    RefColor? tertiary,
    RefColor? error,
    RefColor? neutral,
    RefColor? neutralVariant,
  }) {
    return RefColors(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        tertiary: tertiary ?? this.tertiary,
        error: error ?? this.error,
        neutral: neutral ?? this.neutral,
        neutralVariant: neutralVariant ?? this.neutralVariant);
  }

  @override
  ThemeExtension<RefColors> lerp(
      covariant ThemeExtension<RefColors>? other, double t) {
    if (other is! RefColors) {
      return this;
    }
    return RefColors(
      primary: primary.lerp(other.primary, t),
      secondary: secondary.lerp(other.secondary, t),
      tertiary: tertiary.lerp(other.tertiary, t),
      error: error.lerp(other.error, t),
      neutral: neutral.lerp(other.neutral, t),
      neutralVariant: neutralVariant.lerp(other.neutralVariant, t),
    );
  }
}
