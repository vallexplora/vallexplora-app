import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/ui/home_screens/feed/sale_details_screen.dart';

class SaleCard extends StatefulWidget {
  final String name;
  final String description;
  final String companyName;
  final DateTime end;
  final DateTime start;
  final int requirement; // points or position
  final bool requirementType;
  final String city;

  const SaleCard({
    super.key,
    required this.name,
    required this.description,
    required this.companyName,
    required this.end,
    required this.start,
    required this.requirement,
    required this.requirementType,
    required this.city,
  });

  @override
  State<StatefulWidget> createState() => _SaleCardState();
}

class _SaleCardState extends State<SaleCard> {
  late String name;
  late String description;
  late String companyName;
  late DateTime end;
  late DateTime start;
  late int requirement;
  late bool requirementType;
  late String city;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    companyName = widget.companyName;
    end = widget.end;
    start = widget.start;
    requirement = widget.requirement;
    requirementType = widget.requirementType;
    city = widget.city;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SalesDetailsScreen(
            name: name,
            description: description,
            companyName: companyName,
            end: end,
            start: start,
            requirement: requirement,
            requirementType: requirementType,
            city: city,
          ),
        ),
      ),
      child: Card(
        elevation: 0,
        surfaceTintColor: primaryRef.value95,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: ShapeDecoration(
            color: primaryRef.value95,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ),
          height: 448,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(11),
                      decoration: ShapeDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(128),
                        ),
                      ),
                      child: Icon(
                        requirementType
                            ? Icons.leaderboard_outlined
                            : Icons.confirmation_num_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          city,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          AppLocalizations.of(context)!.sRewardDetailType(
                              requirementType.toString(), requirement),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 236,
                // child: Image.network(
                //   imagePath,
                //   fit: BoxFit.cover,
                // ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 24,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              companyName,
                              style:
                                  Theme.of(context).textTheme.bodyMedium!.merge(
                                        TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                      ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.merge(
                            TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                      maxLines: 2,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
