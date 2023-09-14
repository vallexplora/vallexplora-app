import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

class VAppBarTheme {
  VAppBarTheme._();

  static final lightAppBarTheme = AppBarTheme(
    toolbarHeight: 56,
    backgroundColor: ColorResources.mayaBlue[600],
    foregroundColor: ColorResources.mayaBlue[50],
    titleTextStyle: const TextStyle(
      fontSize: 20,
    ),
  );
}
