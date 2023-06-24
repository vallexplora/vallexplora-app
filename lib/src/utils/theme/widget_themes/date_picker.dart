import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

class VDatePickerTheme {
  VDatePickerTheme._();

  static DatePickerThemeData lightDatePickerTheme = DatePickerThemeData(
    backgroundColor: ColorResources.mayaBlue[50],
    headerBackgroundColor: ColorResources.mayaBlue[600],
    dayForegroundColor: MaterialStatePropertyAll(ColorResources.mayaBlue[800]),
    surfaceTintColor: ColorResources.mayaBlue[300],
  );
}
