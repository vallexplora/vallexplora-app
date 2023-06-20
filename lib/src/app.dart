import 'package:flutter/material.dart';
import 'package:vallexplora/src/ui/welcome_screen.dart';
import 'package:vallexplora/src/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vallexplora",
      theme: VAppTheme.lightTheme,
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
