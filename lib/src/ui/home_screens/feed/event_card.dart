import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/event_types.dart';
import 'package:vallexplora/src/utils/theme/extended.dart';

class EventCard extends StatefulWidget {
  final String name;
  final String description;
  final int entryFee;
  final int eventType;
  final Timestamp startDate;
  final Timestamp endDate;
  final String city;
  final String imagePath;
  final Map<String, dynamic>? location;
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
  late Map<String, dynamic>? location;
  late List<Map<String, dynamic>>? points;
  late bool hasAR;

  Map<int, ExtendedColor> cardColors(context) => {
        1: (Theme.of(context).extensions.entries.last.value as ExtendedColors)
            .categorySport,
        2: (Theme.of(context).extensions.entries.last.value as ExtendedColors)
            .categoryFood,
        3: (Theme.of(context).extensions.entries.last.value as ExtendedColors)
            .categoryArch,
        4: (Theme.of(context).extensions.entries.last.value as ExtendedColors)
            .categoryArt,
        5: (Theme.of(context).extensions.entries.last.value as ExtendedColors)
            .categoryEco,
      };

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
    points = widget.points;
    hasAR = widget.hasAR;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      surfaceTintColor: cardColors(context)[eventType]!.group.tone99,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: ShapeDecoration(
          color: cardColors(context)[eventType]!.group.tone98,
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
                      color: cardColors(context)[eventType]!.value,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(128),
                      ),
                    ),
                    child: Icon(
                      EventTypeInformation.numberInfoMap(context)[eventType]
                          .icon,
                      color: cardColors(context)[eventType]!.sys.onColor,
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
                            entryFee == 0 ? "Entrada Libre" : "\$$entryFee COP",
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
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
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
    );

    // return Container(
    //   clipBehavior: Clip.hardEdge,
    //   height: 360,
    //   margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    //   decoration: ShapeDecoration(
    //     color: neutralRef.value50,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(16),
    //       side: BorderSide(
    //         color: neutralRef.value80,
    //       ),
    //     ),
    //   ),
    //   child: Stack(
    //     fit: StackFit.expand,
    //     children: [
    //       Positioned.fill(
    //         child: Container(
    //           decoration: ShapeDecoration(
    //             image: DecorationImage(
    //               image: NetworkImage(imagePath),
    //               fit: BoxFit.cover,
    //             ),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(16),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned.fill(
    //         child: Opacity(
    //           opacity: 0.7,
    //           child: Container(
    //             decoration: ShapeDecoration(
    //               gradient: LinearGradient(
    //                 begin: const Alignment(0.00, -1.00),
    //                 end: const Alignment(0, 1),
    //                 colors: [
    //                   primaryRef.value12.withOpacity(0.01),
    //                   primaryRef.value5,
    //                 ],
    //               ),
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(16),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned.fill(
    //         child: Container(
    //           decoration: ShapeDecoration(
    //             gradient: RadialGradient(
    //               center: const Alignment(0, 1),
    //               radius: 0,
    //               colors: [
    //                 Colors.black.withOpacity(0),
    //                 Colors.black.withOpacity(0.25),
    //               ],
    //             ),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(16),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         top: 16,
    //         left: 16,
    //         child: Icon(
    //           EventTypeInformation.numberInfoMap[eventType].icon,
    //           color: Colors.black,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
