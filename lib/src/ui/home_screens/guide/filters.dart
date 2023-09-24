import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/constants/text_strings.dart';

class Filters extends StatefulWidget {
  final Function(String) modifyCategoryFilters;
  final Function(String) modifyRegionFilters;
  final Function(String) modifyClassificationFilters;
  final Stream<List<String>> categoryFilters;
  final Stream<List<String>> regionFilters;
  final Stream<List<String>> classificationFilters;
  final Stream<bool> showFilters;

  const Filters({
    super.key,
    required this.modifyCategoryFilters,
    required this.modifyRegionFilters,
    required this.modifyClassificationFilters,
    required this.categoryFilters,
    required this.regionFilters,
    required this.classificationFilters,
    required this.showFilters,
  });

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  late Function(String) modifyCategoryFilters;
  late Function(String) modifyRegionFilters;
  late Function(String) modifyClassificationFilters;
  late Stream<List<String>> categoryFilters;
  late Stream<List<String>> regionFilters;
  late Stream<List<String>> classificationFilters;
  late Stream<bool> showFilters;

  @override
  void initState() {
    super.initState();
    modifyCategoryFilters = widget.modifyCategoryFilters;
    modifyRegionFilters = widget.modifyRegionFilters;
    modifyClassificationFilters = widget.modifyClassificationFilters;
    categoryFilters = widget.categoryFilters;
    regionFilters = widget.regionFilters;
    classificationFilters = widget.classificationFilters;
    showFilters = widget.showFilters;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: showFilters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.data!) {
            return const SizedBox(width: 2);
          } else {
            return SizedBox(
              height: 304,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(StringResources.guideSearchCategories),
                  StreamBuilder<List<String>>(
                      stream: categoryFilters,
                      builder: (context, categorySnapshot) {
                        if (categorySnapshot.connectionState ==
                                ConnectionState.waiting ||
                            categorySnapshot.hasError) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              children: [
                                FilterChip(
                                  label: const Text(StringResources.guideSearchSportsShows),
                                  selected: categorySnapshot.data!
                                      .contains(StringResources.guideSearchSportsShows),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyCategoryFilters(
                                        StringResources.guideSearchSportsShows);
                                  },
                                  avatar: const Icon(Icons.sports_soccer),
                                  showCheckmark: false,
                                  selectedColor: ColorResources.mayaBlue[400],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                FilterChip(
                                  label: const Text(StringResources.guideSearchGastro),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyCategoryFilters(StringResources.guideSearchGastro);
                                  },
                                  avatar:
                                      const Icon(Icons.soup_kitchen_outlined),
                                  selected: categorySnapshot.data!
                                      .contains(StringResources.guideSearchGastro),
                                  showCheckmark: false,
                                  selectedColor: ColorResources.mayaBlue[400],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                FilterChip(
                                  label: const Text(StringResources.guideSearchHistoryArchitecture),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyCategoryFilters(
                                        StringResources.guideSearchHistoryArchitecture);
                                  },
                                  avatar: const Icon(Icons.church_outlined),
                                  selected: categorySnapshot.data!
                                      .contains(StringResources.guideSearchHistoryArchitecture),
                                  showCheckmark: false,
                                  selectedColor: ColorResources.mayaBlue[400],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                FilterChip(
                                  label: const Text(StringResources.guideSearchArtCulture),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyCategoryFilters(StringResources.guideSearchArtCulture);
                                  },
                                  avatar: const Icon(Icons.palette_outlined),
                                  selected: categorySnapshot.data!
                                      .contains(StringResources.guideSearchArtCulture),
                                  showCheckmark: false,
                                  selectedColor: ColorResources.mayaBlue[400],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                FilterChip(
                                  label: const Text(StringResources.guideSearchEco),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyCategoryFilters(StringResources.guideSearchEco);
                                  },
                                  avatar: const Icon(Icons.eco_outlined),
                                  selected: categorySnapshot.data!
                                      .contains(StringResources.guideSearchEco),
                                  showCheckmark: false,
                                  selectedColor: ColorResources.mayaBlue[400],
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                  const Text(StringResources.guideSearchRegions),
                  StreamBuilder<List<String>>(
                      stream: regionFilters,
                      builder: (context, regionSnapshot) {
                        if (regionSnapshot.connectionState ==
                                ConnectionState.waiting ||
                            regionSnapshot.hasError) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              children: [
                                FilterChip(
                                  label: const Text(StringResources.guideSearchNorth),
                                  selected:
                                      regionSnapshot.data!.contains(StringResources.guideSearchNorth),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyRegionFilters(StringResources.guideSearchNorth);
                                  },
                                  showCheckmark: false,
                                  avatar: const Icon(Icons.north),
                                  selectedColor: ColorResources.mayaBlue[400],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                FilterChip(
                                  label: const Text(StringResources.guideSearchEast),
                                  selected:
                                      regionSnapshot.data!.contains(StringResources.guideSearchEast),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyRegionFilters(StringResources.guideSearchEast);
                                  },
                                  selectedColor: ColorResources.mayaBlue[400],
                                  showCheckmark: false,
                                  avatar: const Icon(Icons.east),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                FilterChip(
                                  label: const Text(StringResources.guideSearchCenter),
                                  selected:
                                      regionSnapshot.data!.contains(StringResources.guideSearchCenter),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyRegionFilters(StringResources.guideSearchCenter);
                                  },
                                  selectedColor: ColorResources.mayaBlue[400],
                                  showCheckmark: false,
                                  avatar: const Icon(Icons.adjust),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                FilterChip(
                                  label: const Text(StringResources.guideSearchSouth),
                                  selected:
                                      regionSnapshot.data!.contains(StringResources.guideSearchSouth),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyRegionFilters(StringResources.guideSearchSouth);
                                  },
                                  selectedColor: ColorResources.mayaBlue[400],
                                  showCheckmark: false,
                                  avatar: const Icon(Icons.south),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                FilterChip(
                                  label: const Text(StringResources.guideSearchWest),
                                  selected: regionSnapshot.data!
                                      .contains(StringResources.guideSearchWest),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyRegionFilters(StringResources.guideSearchWest);
                                  },
                                  selectedColor: ColorResources.mayaBlue[400],
                                  showCheckmark: false,
                                  avatar: const Icon(Icons.west),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                  const Text(StringResources.guideSearchClassification),
                  StreamBuilder<List<String>>(
                      stream: classificationFilters,
                      builder: (context, classificationSnapshot) {
                        if (classificationSnapshot.connectionState ==
                                ConnectionState.waiting ||
                            classificationSnapshot.hasError) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              children: [
                                FilterChip(
                                  label: const Text(StringResources.guideSearchEvent),
                                  selected: classificationSnapshot.data!
                                      .contains(StringResources.guideSearchEvent),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyClassificationFilters(StringResources.guideSearchEvent);
                                  },
                                  showCheckmark: false,
                                  avatar: const Icon(Icons.event_outlined),
                                  selectedColor: ColorResources.mayaBlue[400],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                FilterChip(
                                  label: const Text(StringResources.guideSearchPOI),
                                  selected: classificationSnapshot.data!
                                      .contains(StringResources.guideSearchPOI),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyClassificationFilters(
                                        StringResources.guideSearchPOI);
                                  },
                                  selectedColor: ColorResources.mayaBlue[400],
                                  showCheckmark: false,
                                  avatar:
                                      const Icon(Icons.attractions_outlined),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                FilterChip(
                                  label: const Text(StringResources.guideSearchSale),
                                  selected: classificationSnapshot.data!
                                      .contains(StringResources.guideSearchSale),
                                  onSelected: (value) {
                                    setState(() {});
                                    modifyClassificationFilters(StringResources.guideSearchSale);
                                  },
                                  selectedColor: ColorResources.mayaBlue[400],
                                  showCheckmark: false,
                                  avatar:
                                      const Icon(Icons.local_activity_outlined),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                ],
              ),
            );
          }
        });
  }
}
