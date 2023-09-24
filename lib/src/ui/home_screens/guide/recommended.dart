import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/text_strings.dart';
import 'package:vallexplora/src/ui/home_screens/guide/search_result_card.dart';

class Recommended extends StatefulWidget {
  final Stream<String> searchValue;

  const Recommended({
    super.key,
    required this.searchValue,
  });

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
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
      builder: (builder, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(height: 16);
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.data!.isEmpty) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchResultCard(
                name: "Final de Natación Olímpica",
                type: StringResources.guideSearchEvent,
                region: StringResources.guideSearchNorth,
                category: StringResources.guideSearchSportsShows,
              ),
              SizedBox(
                height: 12,
              ),
              SearchResultCard(
                name: "Basílica Menor Señor de Los Milagros",
                type: StringResources.guideSearchPOI,
                region: StringResources.guideSearchSouth,
                category: StringResources.guideSearchHistoryArchitecture,
              ),
              SizedBox(
                height: 12,
              ),
              SearchResultCard(
                name: "Burger Master",
                type: StringResources.guideSearchSale,
                region: StringResources.guideSearchCenter,
                category: StringResources.guideSearchGastro,
              ),
            ],
          );
        }
        return const SizedBox(
          height: 16,
        );
      },
    );
  }
}
