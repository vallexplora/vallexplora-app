import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class VOutlinedButtonTheme {
  VOutlinedButtonTheme._(); // Avoid instantiation

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      foregroundColor: ColorResources.twNeutral[500],
      padding: const EdgeInsets.all(SizeResources.buttonHeight),
    ),
  );
}
