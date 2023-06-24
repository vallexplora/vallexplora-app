import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

class VTimePickerTheme {
  VTimePickerTheme._();

  static final lightTimePickerTheme = TimePickerThemeData(
    backgroundColor: ColorResources.mayaBlue[50],
    dialBackgroundColor: ColorResources.mayaBlue[200],
    dialHandColor: ColorResources.mayaBlue[300],
    dialTextColor: ColorResources.mayaBlue[800],
    entryModeIconColor: ColorResources.mayaBlue[800],
    helpTextStyle: TextStyle(
      color: ColorResources.mayaBlue[800],
    ),
    hourMinuteColor: ColorResources.mayaBlue[200],
    hourMinuteTextColor: ColorResources.mayaBlue[700],
    dayPeriodColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return ColorResources.mayaBlue[200]!;
      } else {
        return ColorResources.mayaBlue[100]!;
      }
    }),
    dayPeriodTextColor: ColorResources.mayaBlue[800],
    dayPeriodBorderSide: BorderSide(
      color: ColorResources.mayaBlue[200]!,
    ),
  );
}
