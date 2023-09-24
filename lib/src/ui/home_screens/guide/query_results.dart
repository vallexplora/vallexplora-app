import 'package:flutter/material.dart';

class QueryResults extends StatefulWidget {
  final Stream<String> searchValue;

  const QueryResults({
    super.key,
    required this.searchValue,
  });

  @override
  State<QueryResults> createState() => _QueryResultsState();
}

class _QueryResultsState extends State<QueryResults> {
  late Stream<String> searchValue;

  @override
  void initState() {
    super.initState();
    searchValue = widget.searchValue;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: searchValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.data!.isNotEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox(
              width: 16,
            );
          }
        });
  }
}
