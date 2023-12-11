import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/event_types.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/constants/screens.dart';
import 'package:vallexplora/src/ui/home_container_screen.dart';
import 'package:vallexplora/src/ui/home_screens/guide/ar_view.dart';

class EventDetailsScreen extends StatefulWidget {
  final String name;
  final String description;
  final int entryFee;
  final int eventType;
  final DateTime startDate;
  final DateTime endDate;
  final String city;
  final String imagePath;
  final List<Map<String, dynamic>>? location;
  final bool hasAR;

  const EventDetailsScreen({
    super.key,
    required this.name,
    required this.description,
    required this.entryFee,
    required this.startDate,
    required this.city,
    required this.eventType,
    required this.endDate,
    required this.imagePath,
    this.location,
    required this.hasAR,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late String name;
  late String description;
  late int entryFee;
  late int eventType;
  late DateTime startDate;
  late DateTime endDate;
  late String city;
  late String imagePath;
  late List<Map<String, dynamic>>? location;
  late bool hasAR;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    entryFee = widget.entryFee;
    eventType = widget.eventType;
    startDate = widget.startDate;
    endDate = widget.endDate;
    city = widget.city;
    imagePath = widget.imagePath;
    location = widget.location;
    hasAR = widget.hasAR;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.gEvents(1)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          if (hasAR)
            IconButton(
              tooltip: AppLocalizations.of(context)!.sEventDetailARTooltip,
              onPressed: () {},
              icon: Icon(
                Icons.view_in_ar,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: ShapeDecoration(
              color: eventTypeColors(context)[eventType]!.value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(128),
              ),
            ),
            child: IconButton(
              tooltip: AppLocalizations.of(context)!
                  .sEventDetailTypeTooltip(eventType.toString()),
              onPressed: () {},
              icon: Icon(
                EventTypeInformation.numberInfoMap(context)[eventType].icon,
                color: eventTypeColors(context)[eventType]!.sys.onColor,
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
            SizedBox(
              height: 236,
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
              ),
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
                        '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    constraints: const BoxConstraints(minHeight: 144),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                AppLocalizations.of(context)!.sEventDetailAbout,
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
                        icon: const Icon(Icons.view_in_ar),
                        onPressed: hasAR
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ARView(),
                                  ),
                                );
                              }
                            : null,
                        label: Text(hasAR
                            ? AppLocalizations.of(context)!
                                .sEventDetailARButtonLabel
                            : AppLocalizations.of(context)!
                                .sEventDetailARUnavailable),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.map_outlined),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomeContainerScreen(
                                initialScreen: ScreenIDs.guide.number,
                              ),
                            ),
                          );
                        },
                        label: Text(AppLocalizations.of(context)!
                            .sEventDetailMapButtonLabel),
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
