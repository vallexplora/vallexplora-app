import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class VNavigationBarTheme {
  VNavigationBarTheme._();

  static final lightNavigationBarTheme = NavigationBarThemeData(
    height: 80,
    backgroundColor: ColorResources.mayaBlue[100],
    indicatorColor: ColorResources.mayaBlue[200],
    iconTheme: MaterialStateProperty.resolveWith((state) {
      if (state.contains(MaterialState.selected)) {
        return IconThemeData(
          color: ColorResources.mayaBlue[1200],
          opticalSize: 64.0,
        );
      } else {
        return IconThemeData(
          color: ColorResources.mayaBlue[1200],
        );
      }
    }),
    labelTextStyle: MaterialStateProperty.resolveWith((state) {
      if (state.contains(MaterialState.selected)) {
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: MaterialColor(
            ColorResources.mayaBlue[1000]!.value,
            ColorResources.mayaBlue,
          ),
        );
      }
      return TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: MaterialColor(
          ColorResources.mayaBlue[1200]!.value,
          ColorResources.mayaBlue,
        ),
      );
    }),
  );
}
