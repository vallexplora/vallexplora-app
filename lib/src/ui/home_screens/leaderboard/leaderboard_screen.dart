import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/home/leaderboard_bloc.dart';
import 'package:vallexplora/src/models/user_model.dart';
import 'package:vallexplora/src/ui/home_screens/leaderboard/leaderboard_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final _bloc = LeaderboardBloc();

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
              AppLocalizations.of(context)!.sLeaderboardPodiumTitle,
              style: Theme.of(context).textTheme.titleLarge!.merge(
                  TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            ),
            const SizedBox(
              height: 16,
            ),
            StreamBuilder(
              stream: _bloc.getPodium(),
              builder: (context, podiumSnapshot) {
                if (podiumSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (podiumSnapshot.hasError) {
                  return Center(
                    child: Text("Error: ${podiumSnapshot.error}"),
                  );
                } else {
                  List<UserModel> users = podiumSnapshot.hasData
                      ? _bloc.convertToList(podiumSnapshot.data!.docs)
                      : [];
                  users = _bloc.figureOutPodium(users);
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length > 3 ? 3 : users.length,
                    itemBuilder: (BuildContext context, int index) {
                      var user = users[index];
                      return LeaderboardCard(
                        displayName: user.displayName,
                        place: index + 1,
                        points: user.points.last["amount"],
                        city: user.origin,
                      );
                    },
                  );
                }
              },
            ),
            const Divider(
              height: 32,
            ),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder(
                future: _bloc.getUserInfo(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (userSnapshot.hasError || !userSnapshot.hasData) {
                    return Text("Error: ${userSnapshot.error}");
                  }
                  Stream<UserModel> userInfo = userSnapshot.data!;
                  return StreamBuilder(
                      stream: userInfo,
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (userSnapshot.hasError) {
                          return Center(
                            child: Text("Error: ${userSnapshot.error}"),
                          );
                        } else {
                          return Center(
                            child: LeaderboardCard(
                              displayName: userSnapshot.data!.displayName,
                              place: 1,
                              self: true,
                              points: userSnapshot.data!.points.last["amount"],
                              city: userSnapshot.data!.origin,
                            ),
                          );
                        }
                      });
                }),
          ],
        ),
      ),
    );
  }
}
