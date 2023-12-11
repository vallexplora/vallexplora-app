import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/home/challenges_bloc.dart';
import 'package:vallexplora/src/models/challenge_model.dart';
import 'package:vallexplora/src/models/user_model.dart';
import 'package:vallexplora/src/ui/home_screens/challenges/challenge_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  final _bloc = ChallengesBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.sChallengesCurrentSeason,
              style: Theme.of(context).textTheme.titleLarge!.merge(
                  TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            ),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder(
                future:
                    _bloc.getCurrentExpirationDateAsLocalizedString(context),
                builder: (context, expirationLocalized) {
                  return Text(
                    AppLocalizations.of(context)!.sChallengesCurrentSeasonDate(
                        expirationLocalized.data ?? "01/01/2024"),
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant)),
                  );
                }),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder(
                future: _bloc.challengesList(),
                builder: (context, streamsSnapshot) {
                  if (streamsSnapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: streamsSnapshot.data![0],
                          builder: (context, currentSnapshots) {
                            List<DocumentSnapshot> docs =
                                currentSnapshots.data?.docs ?? [];
                            List<ChallengeModel> challenges =
                                _bloc.convertToList(docs);
                            if (currentSnapshots.hasData) {
                              return FutureBuilder(
                                  future: _bloc.getUserInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError ||
                                        !snapshot.hasData) {
                                      return Text("Error: ${snapshot.error}");
                                    }
                                    Stream<UserModel> userInfo = snapshot.data!;
                                    return StreamBuilder(
                                      stream: userInfo,
                                      builder: (context, userSnapshot) {
                                        if (userSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (userSnapshot.hasError ||
                                            !userSnapshot.hasData ||
                                            userSnapshot.data == null) {
                                          return Center(
                                              child: Text(
                                                  "Error: ${userSnapshot.error}"));
                                        }
                                        if (challenges.isNotEmpty) {
                                          return FutureBuilder(
                                              future: _bloc
                                                  .getCurrentExpirationDate(),
                                              builder:
                                                  (context, futureSnapshot) {
                                                if (futureSnapshot.hasData) {
                                                  return ListView.builder(
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        challenges.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var challenge =
                                                          challenges[index];
                                                      final type = _bloc
                                                          .checkIfDoneOrExpired(
                                                              challenge,
                                                              userSnapshot.data!
                                                                  .completedChallenges
                                                                  .cast<
                                                                      String>());

                                                      return ChallengeCard(
                                                        id: challenge.id,
                                                        name: challenge.name,
                                                        description: challenge
                                                            .description,
                                                        points:
                                                            challenge.points,
                                                        expiration:
                                                            futureSnapshot
                                                                .data!,
                                                        place:
                                                            challenge.cityName,
                                                        type: type,
                                                        proofImage:
                                                            _bloc.proofImage,
                                                        pickImageFromGallery: _bloc
                                                            .pickImageFromGallery,
                                                        changeProofImage: _bloc
                                                            .changeProofImage,
                                                        markAsDone:
                                                            _bloc.markAsDone,
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              });
                                        } else {
                                          return Center(
                                            child: Text(AppLocalizations.of(
                                                    context)!
                                                .sChallengesCurrentSeasonEmpty),
                                          );
                                        }
                                      },
                                    );
                                  });
                            } else if (currentSnapshots.hasError) {
                              return Center(
                                child: Text("Error: ${currentSnapshots.error}"),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .sChallengesPreviousSeason,
                          style: Theme.of(context).textTheme.titleLarge!.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: streamsSnapshot.data![1],
                          builder: (context, currentSnapshots) {
                            List<DocumentSnapshot> docs =
                                currentSnapshots.data?.docs ?? [];
                            List<ChallengeModel> challenges =
                                _bloc.convertToList(docs);
                            if (currentSnapshots.hasData) {
                              return FutureBuilder(
                                  future: _bloc.getUserInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError ||
                                        !snapshot.hasData) {
                                      return Text("Error: ${snapshot.error}");
                                    }
                                    Stream<UserModel> userInfo = snapshot.data!;
                                    return StreamBuilder(
                                      stream: userInfo,
                                      builder: (context, userSnapshot) {
                                        if (userSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (userSnapshot.hasError ||
                                            !userSnapshot.hasData ||
                                            userSnapshot.data == null) {
                                          return Center(
                                              child: Text(
                                                  "Error: ${userSnapshot.error}"));
                                        } else {
                                          if (challenges.isNotEmpty) {
                                            return FutureBuilder(
                                                future: _bloc
                                                    .getCurrentExpirationDate(),
                                                builder:
                                                    (context, futureSnapshot) {
                                                  if (futureSnapshot.hasData) {
                                                    return ListView.builder(
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          challenges.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var challenge =
                                                            challenges[index];
                                                        final type = _bloc
                                                            .checkIfDoneOrExpired(
                                                                challenge,
                                                                userSnapshot
                                                                    .data!
                                                                    .completedChallenges
                                                                    .cast<
                                                                        String>());

                                                        return ChallengeCard(
                                                          id: challenge.id,
                                                          name: challenge.name,
                                                          description: challenge
                                                              .description,
                                                          points:
                                                              challenge.points,
                                                          expiration:
                                                              futureSnapshot
                                                                  .data!,
                                                          place: challenge
                                                              .cityName,
                                                          type: type,
                                                          proofImage:
                                                              _bloc.proofImage,
                                                          pickImageFromGallery:
                                                              _bloc
                                                                  .pickImageFromGallery,
                                                          changeProofImage: _bloc
                                                              .changeProofImage,
                                                          markAsDone:
                                                              _bloc.markAsDone,
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                });
                                          } else {
                                            return Center(
                                              child: Text(AppLocalizations.of(
                                                      context)!
                                                  .sChallengesPreviousSeasonEmpty),
                                            );
                                          }
                                        }
                                      },
                                    );
                                  });
                            } else if (currentSnapshots.hasError) {
                              return Center(
                                child: Text("Error: ${currentSnapshots.error}"),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Text("${streamsSnapshot.error ?? ""}"),
                        Text(streamsSnapshot.connectionState.name),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
