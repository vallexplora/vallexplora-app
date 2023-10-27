import 'package:flutter/material.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';

class VTextFieldTheme {
  VTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: lightScheme.outline,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: lightScheme.outline,
      ),
    ),
    prefixIconColor: lightScheme.primary,
    suffixIconColor: lightScheme.primary,
  );
}
