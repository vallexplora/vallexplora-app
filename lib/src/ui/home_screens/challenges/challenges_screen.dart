import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/home/challenges_bloc.dart';
import 'package:vallexplora/src/models/challenge_model.dart';
import 'package:vallexplora/src/ui/home_screens/challenges/challenge_card.dart';
import 'package:vallexplora/src/ui/home_screens/challenges/new_challenge_screen.dart';

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
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewChallengeScreen(),
              ),
            );
          },
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _bloc.challengesList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> docs = snapshot.data!.docs;
              Future<List<ChallengeModel>> futureChallenges =
                  _bloc.convertToFuture(docs);

              return FutureBuilder<List<ChallengeModel>>(
                future: futureChallenges,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<ChallengeModel> challenges = snapshot.data ?? [];
                    if (challenges.isNotEmpty) {
                      return ListView.builder(
                        itemCount: challenges.length,
                        itemBuilder: (context, index) {
                          var challenge = challenges[index];
                          return ChallengeCard(
                              name: challenge.name,
                              description: challenge.description,
                              points: challenge.points,
                              startDate: challenge.startDate,
                              expiration: challenge.expiration,
                              place: challenge.place);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('No hay desafíos por el momento :('),
                      );
                    }
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Ocurrió un error: ${snapshot.error}"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
