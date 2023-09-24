import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/text_strings.dart';

import '../../../constants/colors.dart';

class SearchResultCard extends StatefulWidget {
  final String name;
  final String type;
  final String region;
  final String category;

  const SearchResultCard({
    super.key,
    required this.name,
    required this.type,
    required this.region,
    required this.category,
  });

  @override
  State<SearchResultCard> createState() => _SearchResultCardState();
}

class _SearchResultCardState extends State<SearchResultCard> {
  late String name;
  late String type;
  late String region;
  late String category;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    type = widget.type;
    region = widget.region;
    category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 96,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: ShapeDecoration(
        color: ColorResources.twNeutral[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: ColorResources.twNeutral[300]!,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 64,
            width: 64,
            padding: const EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color: ColorResources.mayaBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: ColorResources.mayaBlue[300]!,
                ),
              ),
            ),
            child: Icon(
              category == StringResources.guideSearchSportsShows
                  ? Icons.sports_soccer_outlined
                  : category == StringResources.guideSearchGastro
                      ? Icons.soup_kitchen_outlined
                      : category ==
                              StringResources.guideSearchHistoryArchitecture
                          ? Icons.church_outlined
                          : category == StringResources.guideSearchArtCulture
                              ? Icons.palette_outlined
                              : category == StringResources.guideSearchEco
                                  ? Icons.eco_outlined
                                  : Icons.block_outlined,
              size: 32,
              color: ColorResources.mayaBlue[500],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    category,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
