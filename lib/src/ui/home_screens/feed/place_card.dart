import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/ui/home_screens/feed/place_details_screen.dart';

class PlaceCard extends StatefulWidget {
  final String name;
  final String shortDescription;
  final int fee;
  final String climate;
  final String closeTime;
  final String openTime;
  final String cityName;
  final String imageUrl;
  final String imageAlt;
  final bool enabled;
  final bool hasAR;
  final List<Map<String, dynamic>> area;
  final List<Map<String, dynamic>>? arText;

  const PlaceCard({
    super.key,
    required this.name,
    required this.shortDescription,
    required this.fee,
    required this.climate,
    required this.closeTime,
    required this.openTime,
    required this.cityName,
    required this.imageUrl,
    required this.imageAlt,
    required this.enabled,
    required this.hasAR,
    required this.area,
    this.arText,
  });

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  late String name;
  late String shortDescription;
  late int fee;
  late String climate;
  late String closeTime;
  late String openTime;
  late String cityName;
  late String imageUrl;
  late String imageAlt;
  late bool enabled;
  late bool hasAR;
  late List<Map<String, dynamic>> area;
  List<Map<String, dynamic>>? arText;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    shortDescription = widget.shortDescription;
    fee = widget.fee;
    climate = widget.climate;
    closeTime = widget.closeTime;
    openTime = widget.openTime;
    cityName = widget.cityName;
    imageUrl = widget.imageUrl;
    imageAlt = widget.imageAlt;
    enabled = widget.enabled;
    hasAR = widget.hasAR;
    area = widget.area;

    if (hasAR) {
      arText = widget.arText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlaceDetailsScreen(
            name: name,
            shortDescription: shortDescription,
            fee: fee,
            climate: climate,
            closeTime: closeTime,
            openTime: openTime,
            cityName: cityName,
            imageUrl: imageUrl,
            imageAlt: imageAlt,
            enabled: enabled,
            hasAR: hasAR,
            area: area,
            arText: arText,
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
                      child: Row(
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "$climate °C",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .merge(
                                  TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                          )
                        ],
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
                          cityName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .sPlaceOpenCloseTimeText(openTime, closeTime),
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
                  imageUrl,
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
                              AppLocalizations.of(context)!
                                  .sEventEntryFee((fee == 0).toString(), fee),
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
                      shortDescription,
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
