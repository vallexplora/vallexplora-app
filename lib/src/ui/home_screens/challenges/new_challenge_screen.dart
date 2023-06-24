import 'package:flutter/material.dart';

class NewChallengeScreen extends StatefulWidget {
  const NewChallengeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewChallengeScreenState();
}

class _NewChallengeScreenState extends State<NewChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo desafío"),
        leading: const Icon(Icons.close),
      ),
      body: Text("Yo this is new"),
    );
  }
}
