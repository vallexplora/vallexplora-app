import 'package:flutter/material.dart';

class MarkersScreen extends StatefulWidget {
  const MarkersScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MarkersScreenState();
}

class _MarkersScreenState extends State<MarkersScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        "Markers right now",
        textAlign: TextAlign.center,
      ),
    );
  }
}
