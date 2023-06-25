import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class VSwitchTheme {
  VSwitchTheme._();

  static final lightSwitchTheme = SwitchThemeData(
    thumbColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[100]!;
        } else {
          return ColorResources.twNeutral[400]!;
        }
      },
    ),
    trackColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[300]!;
        } else {
          return ColorResources.twNeutral[100]!;
        }
      },
    ),
    trackOutlineColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[300]!;
        } else {
          return ColorResources.twNeutral[300]!;
        }
      },
    ),
  );
}
