import 'package:flutter/material.dart';
import 'package:vallexplora/src/models/leaderboard_model.dart';
import 'package:vallexplora/src/utils/extensions/string_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class LeaderboardCard extends StatefulWidget {
  final String displayName;
  final int place;
  bool? self;
  final int points;
  String? city;

  LeaderboardCard({
    super.key,
    required this.displayName,
    required this.place,
    this.self,
    required this.points,
    this.city,
  });

  @override
  State<LeaderboardCard> createState() => _LeaderboardCardState();
}

class _LeaderboardCardState extends State<LeaderboardCard> {
  late String displayName;
  late int place;
  bool? self;
  late int points;
  String? city;

  @override
  void initState() {
    super.initState();
    displayName = widget.displayName;
    place = widget.place;
    self = widget.self;
    points = widget.points;
    city = widget.city;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 112,
      decoration: ShapeDecoration(
        color:
            LeaderboardModel.surfaceColors(context, self ?? false ? -1 : place),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: LeaderboardModel.surfaceBorder(
                context, self ?? false ? -1 : place),
          ),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          if (!(self ?? false))
            Positioned(
              top: -55,
              right: 10,
              child: Text(
                "#$place",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 160,
                  color: LeaderboardModel.iconBackground(
                      context, self ?? false ? -1 : place),
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                  top: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: LeaderboardModel.iconBackground(
                            context, self ?? false ? -1 : place),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(128),
                        ),
                      ),
                      child: self ?? false
                          ? Text(
                              "#$place",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          : Icon(
                              Icons.emoji_events,
                              color: LeaderboardModel.iconColors(
                                  context, self ?? false ? -1 : place),
                            ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 144),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            self ?? false
                                ? AppLocalizations.of(context)!.sLeaderboardYour
                                : displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style:
                                Theme.of(context).textTheme.titleMedium!.merge(
                                      TextStyle(
                                          color: LeaderboardModel.surfaceBorder(
                                              context, place)),
                                    ),
                          ),
                          Text(
                            self ?? false
                                ? displayName
                                : (city ?? " - ").capitalize(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .merge(
                                  TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 88,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${points.toString()} ${AppLocalizations.of(context)!.gPointsAbbreviation}",
                        style: Theme.of(context).textTheme.titleMedium!.merge(
                              TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
