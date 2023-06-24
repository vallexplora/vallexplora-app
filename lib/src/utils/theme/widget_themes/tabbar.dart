import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

class VTabBarTheme {
  VTabBarTheme._();

  static final lightTabBarTheme = TabBarTheme(
    indicatorColor: ColorResources.mayaBlue[1200],
    unselectedLabelColor: ColorResources.mayaBlue[700],
    labelColor: ColorResources.mayaBlue[1200],
    dividerColor: ColorResources.mayaBlue[300],
  );
}
