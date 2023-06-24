import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/text_strings.dart';

class SalesViewTab extends StatefulWidget {
  const SalesViewTab({super.key});

  @override
  State<StatefulWidget> createState() => _SalesViewTabState();
}

class _SalesViewTabState extends State<SalesViewTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(StringResources.eventsTabTitle),
      ),
    );
  }
}
