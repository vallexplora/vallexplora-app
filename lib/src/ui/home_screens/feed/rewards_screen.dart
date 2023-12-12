import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/models/reward_model.dart';
import 'package:vallexplora/src/ui/home_screens/feed/reward_card.dart';

import 'package:vallexplora/src/blocs/home/reward_bloc.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final _bloc = RewardBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bloc.salesList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          List<RewardModel> sales = _bloc.convertToList(docs);
          if (sales.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sales.length,
              itemBuilder: (context, index) {
                var sale = sales[index];
                return RewardCard(
                  name: sale.name,
                  description: sale.description,
                  companyName: sale.companyName,
                  end: sale.end,
                  start: sale.start,
                  requirement: sale.requirement,
                  requirementType: sale.requirementType,
                  city: sale.city,
                );
              },
            );
          } else {
            return const Center(
              child: Text('No hay promociones por el momento :('),
            );
          }
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
    );
  }
}
