import 'package:flutter/material.dart';

class VFilledButtonTheme {
  VFilledButtonTheme._();

  static final lightFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, 48),
    ),
  );
}

class VElevatedButtonTheme {
  VElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, 48),
    ),
  );
}

class VOutlinedButtonTheme {
  VOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, 48),
    ),
  );
}
