import 'package:flutter/material.dart';

class ARView extends StatefulWidget {
  const ARView({super.key});

  @override
  State<ARView> createState() => _ARViewState();
}

class _ARViewState extends State<ARView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Aquí pondríamos nuestra vista de AR...\n SI TUVIERAMOS UNA",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
