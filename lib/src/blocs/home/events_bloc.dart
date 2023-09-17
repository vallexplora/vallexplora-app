import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/models/event_model.dart';
import 'package:vallexplora/src/resources/repository.dart';

class EventsBloc implements Bloc {
  final _repository = Repository();

  final _name = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _entryFee = BehaviorSubject<String>();
  final _startDate = BehaviorSubject<Timestamp>();
  final _city = BehaviorSubject<String>();

  Stream<String> get name => _name.stream;
  Stream<String> get description => _description.stream;
  Stream<String> get points => _entryFee.stream;
  Stream<Timestamp> get startDate => _startDate.stream;
  Stream<String> get city => _city.stream;

  Function(String) get changeName => _name.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(String) get changePoints => _entryFee.sink.add;
  Function(Timestamp) get changeStartDate => _startDate.sink.add;
  Function(String) get changeCity => _city.sink.add;

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
  void dispose() async {
    await _name.drain();
    _name.close();
    await _description.drain();
    _description.close();
    await _entryFee.drain();
    _entryFee.close();
    await _startDate.drain();
    _startDate.close();
    await _city.drain();
    _city.close();
  }
}
