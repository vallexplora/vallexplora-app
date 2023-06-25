import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/appbar.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/date_picker.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/elevated_button.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/floating_action_button.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/navigation_bar.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/outlined_button.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/switch.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/tabbar.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/text_field.dart';
import 'package:vallexplora/src/utils/theme/widget_themes/time_picker.dart';

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
      surface: ColorResources.mayaBlue[400]!,
      onSurface: ColorResources.mayaBlue[900]!,
    ),
    appBarTheme: VAppBarTheme.lightAppBarTheme,
    outlinedButtonTheme: VOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: VElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: VTextFieldTheme.lightInputDecorationTheme,
    datePickerTheme: VDatePickerTheme.lightDatePickerTheme,
    timePickerTheme: VTimePickerTheme.lightTimePickerTheme,
    navigationBarTheme: VNavigationBarTheme.lightNavigationBarTheme,
    tabBarTheme: VTabBarTheme.lightTabBarTheme,
    floatingActionButtonTheme:
        VFloatingActionButtonTheme.lightFloatingActionButtonTheme,
        switchTheme: VSwitchTheme.lightSwitchTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.rubikTextTheme(),
  );
}
