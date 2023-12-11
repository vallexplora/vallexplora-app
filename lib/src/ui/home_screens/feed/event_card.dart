import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/event_types.dart';
import 'package:vallexplora/src/ui/home_screens/feed/event_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventCard extends StatefulWidget {
  final String name;
  final String description;
  final int entryFee;
  final int eventType;
  final Timestamp startDate;
  final Timestamp endDate;
  final String city;
  final String imagePath;
  final List<Map<String, dynamic>>? location;
  final List<Map<String, dynamic>>? points;
  final bool hasAR;

  const EventCard({
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
    this.points,
    required this.hasAR,
  });

  @override
  State<StatefulWidget> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late String name;
  late String description;
  late int entryFee;
  late int eventType;
  late DateTime startDate;
  late DateTime endDate;
  late String city;
  late String imagePath;
  late List<Map<String, dynamic>>? location;
  late List<Map<String, dynamic>>? points;
  late bool hasAR;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    entryFee = widget.entryFee;
    eventType = widget.eventType;
    startDate = widget.startDate.toDate();
    endDate = widget.endDate.toDate();
    city = widget.city;
    imagePath = widget.imagePath;
    location = widget.location;
    hasAR = widget.hasAR;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EventDetailsScreen(
            name: name,
            description: description,
            entryFee: entryFee,
            eventType: eventType,
            startDate: startDate,
            endDate: endDate,
            city: city,
            imagePath: imagePath,
            location: location,
            hasAR: hasAR,
          ),
        ),
      ),
      child: Card(
        elevation: 0,
        surfaceTintColor: eventTypeColors(context)[eventType]!.group.tone99,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: ShapeDecoration(
            color: eventTypeColors(context)[eventType]!.group.tone98,
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
                        color: eventTypeColors(context)[eventType]!.value,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(128),
                        ),
                      ),
                      child: Icon(
                        EventTypeInformation.numberInfoMap(context)[eventType]
                            .icon,
                        color: eventTypeColors(context)[eventType]!.sys.onColor,
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
                          "${startDate.day}/${startDate.month}/${startDate.year}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 236,
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
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
                              AppLocalizations.of(context)!.sEventEntryFee(
                                  (entryFee == 0).toString(), entryFee),
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
