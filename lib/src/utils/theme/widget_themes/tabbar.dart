import 'package:flutter/material.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';

class VTabBarTheme {
  VTabBarTheme._();

  static final lightTabBarTheme = TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      color: lightScheme.surface,
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    dividerColor: lightScheme.surface,
  );
}
