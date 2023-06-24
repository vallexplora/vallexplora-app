import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/elevated_button.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/outlined_button.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/text_field.dart';

import '../../constants/colors.dart';

class VAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: GoogleFonts.rubikTextTheme(),
    primarySwatch: MaterialColor(
      ColorResources.mayaBlue[500]!.value,
      ColorResources.mayaBlue,
    ),
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: ColorResources.mayaBlue[500]!,
        onPrimary: ColorResources.mayaBlue[50]!,
        secondary: ColorResources.twAmber[500]!,
        onSecondary: ColorResources.twAmber[50]!,
        error: Colors.red[700]!,
        onError: Colors.red[100]!,
        background: ColorResources.twNeutral[50]!,
        onBackground: Colors.black87,
        surface: ColorResources.mayaBlue[500]!,
        onSurface: ColorResources.mayaBlue[50]!),
    outlinedButtonTheme: VOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: VElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: VTextFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.rubikTextTheme(),
  );
}
