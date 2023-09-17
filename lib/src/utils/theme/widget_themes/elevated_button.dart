import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class VElevatedButtonTheme {
  VElevatedButtonTheme._(); // Avoid instantiation

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      foregroundColor: ColorResources.mayaBlue[50],
      padding: const EdgeInsets.all(SizeResources.buttonHeight),
      elevation: 0,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: SizeResources.textBase,
      ),
    ),
  );
}
