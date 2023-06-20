import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/elevated_button.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/outlined_button.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/text_field.dart';

import '../../constants/colors.dart';

class VAppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.rubikTextTheme(),
    primarySwatch: MaterialColor(
      ColorResources.mayaBlue[500]!.value,
      ColorResources.mayaBlue,
    ),
    outlinedButtonTheme: VOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: VElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: VTextFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.rubikTextTheme(),
  );
}
