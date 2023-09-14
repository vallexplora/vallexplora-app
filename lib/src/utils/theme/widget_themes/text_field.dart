import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

class VTextFieldTheme {
  VTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        width: 2,
        color: ColorResources.twNeutral[400]!,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        width: 2,
        color: ColorResources.twNeutral[400]!,
      ),
    ),
    prefixIconColor: ColorResources.mayaBlue[600],
    suffixIconColor: ColorResources.mayaBlue[600],
    contentPadding: const EdgeInsets.symmetric(vertical: 20),
    floatingLabelStyle: TextStyle(
      color: ColorResources.mayaBlue[600],
    ),
    labelStyle: TextStyle(
      color: ColorResources.twNeutral[500],
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        width: 2,
        color: ColorResources.mayaBlue[600]!,
      ),
    ),
  );
}
