import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';
import 'package:vallexplora/src/utils/theme/extended.dart';
import 'package:vallexplora/src/utils/theme/ref.dart';
import 'package:vallexplora/src/utils/theme/text_theme.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/appbar.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/buttons.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/text_field.dart';

import '../../constants/colors.dart';

class VAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: GoogleFonts.rubikTextTheme(vTextTheme),
    colorScheme: lightScheme,
    extensions: <ThemeExtension<dynamic>>[
      RefColors(
        primary: primaryRef,
        secondary: secondaryRef,
        tertiary: tertiaryRef,
        error: errorRef,
        neutral: neutralRef,
        neutralVariant: neutralVariantRef,
      ),
      ExtendedColors(
        tertiaryAlt: tertiaryAltEx,
        categoryEco: categoryEcoEx,
        categoryArch: categoryArchEx,
        categoryFood: categoryFoodEx,
        categoryArt: categoryArtEx,
        categorySport: categorySportEx,
        gold: goldEx,
        bronze: bronzeEx,
      ),
    ],
    filledButtonTheme: VFilledButtonTheme.lightFilledButtonTheme,
    outlinedButtonTheme: VOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: VElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: VAppBarTheme.lightAppBarTheme,
    inputDecorationTheme: VTextFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.rubikTextTheme(),
    colorScheme: darkScheme,
    extensions: <ThemeExtension<dynamic>>[
      RefColors(
        primary: primaryRef,
        secondary: secondaryRef,
        tertiary: tertiaryRef,
        error: errorRef,
        neutral: neutralRef,
        neutralVariant: neutralVariantRef,
      ),
      ExtendedColors(
        tertiaryAlt: tertiaryAltEx.merge(sys: tertiaryAltExDark),
        categoryEco: categoryEcoEx.merge(sys: categoryEcoExDark),
        categoryArch: categoryArchEx.merge(sys: categoryArchExDark),
        categoryFood: categoryFoodEx.merge(sys: categoryFoodExDark),
        categoryArt: categoryArtEx.merge(sys: categoryArtExDark),
        categorySport: categorySportEx.merge(sys: categorySportExDark),
        gold: goldEx.merge(sys: goldExDark),
        bronze: bronzeEx.merge(sys: bronzeExDark),
      ),
    ],
  );
}
