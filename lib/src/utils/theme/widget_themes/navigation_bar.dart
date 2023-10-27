import 'package:flutter/material.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';
import 'package:vallexplora/src/utils/theme/text_theme.dart';

class VNavigationBarTheme {
  VNavigationBarTheme._();

  static final lightNavigationBarTheme = NavigationBarThemeData(
    height: 96,
    backgroundColor: lightScheme.surfaceContainer,
    surfaceTintColor: lightScheme.surfaceContainer,
    shadowColor: Colors.transparent,
    indicatorColor: lightScheme.primary,
    iconTheme: MaterialStateProperty.resolveWith((state) {
      if (state.contains(MaterialState.selected)) {
        return IconThemeData(
          color: lightScheme.onPrimary,
          opticalSize: 64.0,
        );
      } else {
        return IconThemeData(
          color: lightScheme.onSurfaceVariant,
        );
      }
    }),
    labelTextStyle: MaterialStateProperty.resolveWith((state) {
      if (state.contains(MaterialState.selected)) {
        return vTextTheme.labelMedium!.merge(
          TextStyle(
            color: lightScheme.onSurface,
          ),
        );
      }
      return vTextTheme.labelMedium!.merge(
        TextStyle(
          color: lightScheme.onSurfaceVariant,
        ),
      );
    }),
  );
}
