import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/home/events_bloc.dart';

import '../../../models/event_model.dart';
import 'event_card.dart';

class EventsViewTab extends StatefulWidget {
  const EventsViewTab({super.key});

  @override
  State<StatefulWidget> createState() => _EventsViewTabState();
}

class _EventsViewTabState extends State<EventsViewTab> {
  final _bloc = EventsBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bloc.eventsList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          Future<List<EventModel>> futureEvents = _bloc.convertToFuture(docs);

          return FutureBuilder<List<EventModel>>(
            future: futureEvents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<EventModel> challenges = snapshot.data ?? [];
                if (challenges.isNotEmpty) {
                  return ListView.builder(
                    itemCount: challenges.length,
                    itemBuilder: (context, index) {
                      var event = challenges[index];
                      return EventCard(
                          name: event.name,
                          description: event.description,
                          entryFee: event.entryFee,
                          startDate: event.startDate,
                          place: event.city);
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No hay eventos por el momento :('),
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
    );
  }
}
