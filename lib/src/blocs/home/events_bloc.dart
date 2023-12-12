import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/models/event_model.dart';
import 'package:vallexplora/src/resources/repository.dart';

class EventsBloc implements Bloc {
  final _repository = Repository();

  Stream<QuerySnapshot> eventsList() => _repository.eventsList();

  Future<List<EventModel>> convertToFuture(List<DocumentSnapshot> docs) async {
    List<EventModel> events = [];

    for (var doc in docs) {
      EventModel challengeModel = await EventModel.fromDocument(doc);
      events.add(challengeModel);
    }

    return events;
  }

  @override
  void dispose() {
    
  }
}
