import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/event_types.dart';
import 'package:vallexplora/src/utils/theme/extended.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/constants/sizes.dart';

class PersonalInformation extends StatefulWidget {
  final Stream<List<int>> categories;
  final ValueSetter<int> modifyCategoryFilters;

  const PersonalInformation({
    super.key,
    required this.categories,
    required this.modifyCategoryFilters,
  });

  @override
  State<StatefulWidget> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late Stream<List<int>> categories;
  late ValueSetter<int> modifyCategoryFilters;

  @override
  void initState() {
    super.initState();
    categories = widget.categories;
    modifyCategoryFilters = widget.modifyCategoryFilters;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.sProfileCategories,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 16,
        ),
        StreamBuilder<List<int>>(
          stream: categories,
          builder: (context, categorySnapshot) {
            if (categorySnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Wrap(
                spacing: 8,
                children: [
                  InputChip(
                    showCheckmark: false,
                    avatar: Icon(
                      Icons.sports_soccer_outlined,
                      color: (Theme.of(context).extensions.entries.last.value
                              as ExtendedColors)
                          .categorySport
                          .sys
                          .color,
                    ),
                    label: Text(AppLocalizations.of(context)!.gSportsCategory),
                    selected: categorySnapshot.data!.contains(
                        EventTypeInformation.infoNumberMap(context)[
                            AppLocalizations.of(context)!.gSportsCategory]),
                    onSelected: (value) {
                      setState(() {});
                      modifyCategoryFilters(
                          EventTypeInformation.infoNumberMap(context)[
                              AppLocalizations.of(context)!.gSportsCategory]);
                    },
                    selectedColor: (Theme.of(context)
                            .extensions
                            .entries
                            .last
                            .value as ExtendedColors)
                        .categorySport
                        .sys
                        .colorContainer,
                  ),
                  InputChip(
                    showCheckmark: false,
                    avatar: Icon(
                      Icons.eco_outlined,
                      color: (Theme.of(context).extensions.entries.last.value
                              as ExtendedColors)
                          .categoryEco
                          .sys
                          .color,
                    ),
                    label: Text(AppLocalizations.of(context)!.gEcoCategory),
                    selected: categorySnapshot.data!.contains(
                        EventTypeInformation.infoNumberMap(context)[
                            AppLocalizations.of(context)!.gEcoCategory]),
                    onSelected: (value) {
                      setState(() {});
                      modifyCategoryFilters(EventTypeInformation.infoNumberMap(
                          context)[AppLocalizations.of(context)!.gEcoCategory]);
                    },
                    selectedColor: (Theme.of(context)
                            .extensions
                            .entries
                            .last
                            .value as ExtendedColors)
                        .categoryEco
                        .sys
                        .colorContainer,
                  ),
                  InputChip(
                    showCheckmark: false,
                    avatar: Icon(
                      Icons.palette_outlined,
                      color: (Theme.of(context).extensions.entries.last.value
                              as ExtendedColors)
                          .categoryArt
                          .sys
                          .color,
                    ),
                    label: Text(AppLocalizations.of(context)!.gArtCategory),
                    selected: categorySnapshot.data!.contains(
                        EventTypeInformation.infoNumberMap(context)[
                            AppLocalizations.of(context)!.gArtCategory]),
                    onSelected: (value) {
                      setState(() {});
                      modifyCategoryFilters(EventTypeInformation.infoNumberMap(
                          context)[AppLocalizations.of(context)!.gArtCategory]);
                    },
                    selectedColor: (Theme.of(context)
                            .extensions
                            .entries
                            .last
                            .value as ExtendedColors)
                        .categoryArt
                        .sys
                        .colorContainer,
                  ),
                  InputChip(
                    showCheckmark: false,
                    avatar: Icon(
                      Icons.soup_kitchen_outlined,
                      color: (Theme.of(context).extensions.entries.last.value
                              as ExtendedColors)
                          .categoryFood
                          .sys
                          .color,
                    ),
                    label: Text(AppLocalizations.of(context)!.gGastroCategory),
                    selected: categorySnapshot.data!.contains(
                        EventTypeInformation.infoNumberMap(context)[
                            AppLocalizations.of(context)!.gGastroCategory]),
                    onSelected: (value) {
                      setState(() {});
                      modifyCategoryFilters(
                          EventTypeInformation.infoNumberMap(context)[
                              AppLocalizations.of(context)!.gGastroCategory]);
                    },
                    selectedColor: (Theme.of(context)
                            .extensions
                            .entries
                            .last
                            .value as ExtendedColors)
                        .categoryFood
                        .sys
                        .colorContainer,
                  ),
                  InputChip(
                    showCheckmark: false,
                    avatar: Icon(
                      Icons.church_outlined,
                      color: (Theme.of(context).extensions.entries.last.value
                              as ExtendedColors)
                          .categoryArch
                          .sys
                          .color,
                    ),
                    label: Text(AppLocalizations.of(context)!.gHistoryCategory),
                    selected: categorySnapshot.data!.contains(
                        EventTypeInformation.infoNumberMap(context)[
                            AppLocalizations.of(context)!.gHistoryCategory]),
                    onSelected: (value) {
                      setState(() {});
                      modifyCategoryFilters(
                          EventTypeInformation.infoNumberMap(context)[
                              AppLocalizations.of(context)!.gHistoryCategory]);
                    },
                    selectedColor: (Theme.of(context)
                            .extensions
                            .entries
                            .last
                            .value as ExtendedColors)
                        .categoryArch
                        .sys
                        .colorContainer,
                  ),
                ],
              );
            }
          },
        ),
        const SizedBox(
          height: SizeResources.defaultHeight,
        ),
        // Here
        const Divider(
          height: SizeResources.defaultDividerHeight,
        ),
      ],
    );
  }
}
