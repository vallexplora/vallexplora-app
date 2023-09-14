import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class VSwitchTheme {
  VSwitchTheme._();

  static final lightSwitchTheme = SwitchThemeData(
    thumbColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[50]!;
        } else {
          return ColorResources.twNeutral[500]!;
        }
      },
    ),
    trackColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[600]!;
        } else {
          return ColorResources.twNeutral[50]!;
        }
      },
    ),
    trackOutlineColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[600]!;
        } else {
          return ColorResources.twNeutral[500]!;
        }
      },
    ),
  );
}
