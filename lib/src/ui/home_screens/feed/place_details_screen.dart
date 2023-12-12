import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/constants/screens.dart';
import 'package:vallexplora/src/ui/home_container_screen.dart';
import 'package:vallexplora/src/ui/home_screens/guide/ar_view.dart';

class PlaceDetailsScreen extends StatefulWidget {
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

  const PlaceDetailsScreen({
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
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
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
                imageUrl,
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
                        cityName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        AppLocalizations.of(context)!.sPlaceOpenCloseTimeText(openTime, closeTime),
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
                                AppLocalizations.of(context)!.sPlaceDetailAbout,
                            style: Theme.of(context).textTheme.bodyLarge!.merge(
                                const TextStyle(fontWeight: FontWeight.w600)),
                          ),
                          TextSpan(
                            text: shortDescription,
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
                                final locale = Localizations.localeOf(context)
                                    .languageCode;
                                final index = locale == "es"
                                    ? 0
                                    : locale == "en"
                                        ? 1
                                        : 2; // TODO: This is HORRENDOUS but it can and should be fix later with a map or something
                                final String information =
                                    arText![index]["description"];
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ARView(
                                      information: information,
                                    ),
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
