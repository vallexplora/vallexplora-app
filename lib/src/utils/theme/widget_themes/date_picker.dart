import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

class VDatePickerTheme {
  VDatePickerTheme._();

  static final lightDatePickerTheme = DatePickerThemeData(
    backgroundColor: ColorResources.mayaBlue[100],
    headerBackgroundColor: ColorResources.mayaBlue[200],
    headerForegroundColor: ColorResources.mayaBlue[800],
    dayForegroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[100]!;
        } else {
          return ColorResources.mayaBlue[800]!;
        }
      },
    ),
    dayBackgroundColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[400]!;
        } else {
          return ColorResources.mayaBlue[100]!;
        }
      },
    ),
    todayBackgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[400]!;
        } else {
          return ColorResources.mayaBlue[100]!;
        }
      },
    ),
    surfaceTintColor: ColorResources.mayaBlue[100],
    weekdayStyle: TextStyle(
      color: ColorResources.mayaBlue[900],
    ),
    yearBackgroundColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[400]!;
        } else {
          return ColorResources.mayaBlue[100]!;
        }
      },
    ),
    yearForegroundColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return ColorResources.mayaBlue[100]!;
        } else {
          return ColorResources.mayaBlue[800]!;
        }
      },
    ),
  );
}
