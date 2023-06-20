import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

class VTextFieldTheme {
  VTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: ColorResources.twNeutral[500]!,
      ),
    ),
    prefixIconColor: ColorResources.mayaBlue[500],
    floatingLabelStyle: TextStyle(
      color: ColorResources.mayaBlue[500],
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: ColorResources.mayaBlue[500]!,
      ),
    ),
    
  );
}
