import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RewardDetailsScreen extends StatefulWidget {
  final String name;
  final String description;
  final String companyName;
  final DateTime end;
  final DateTime start;
  final int requirement; // points or position
  final bool requirementType;
  final String city;

  const RewardDetailsScreen({
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
  State<RewardDetailsScreen> createState() => _RewardDetailsScreenState();
}

class _RewardDetailsScreenState extends State<RewardDetailsScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.gRewards(1)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(128),
              ),
            ),
            child: IconButton(
              tooltip: AppLocalizations.of(context)!
                  .sRewardDetailTypeTooltip(requirementType.toString()),
              onPressed: () {},
              icon: Icon(
                requirementType
                    ? Icons.leaderboard_outlined
                    : Icons.confirmation_num_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 236,
              // child: Image.network(
              //   imagePath,
              //   fit: BoxFit.cover,
              // ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        city,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        companyName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(AppLocalizations.of(context)!.sRewardDetailType(
                      requirementType.toString(), requirement)),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    constraints: const BoxConstraints(minHeight: 144),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!
                                .sRewardDetailAbout,
                            style: Theme.of(context).textTheme.bodyLarge!.merge(
                                const TextStyle(fontWeight: FontWeight.w600)),
                          ),
                          TextSpan(
                            text: description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FilledButton.icon(
                        icon: const Icon(Icons.check_circle_outline),
                        onPressed: () {},
                        label: Text(
                            AppLocalizations.of(context)!.sRewardDetailClaim),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
