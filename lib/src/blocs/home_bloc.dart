import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class HomeBloc implements Bloc {
  final _dataSubject = BehaviorSubject<List<String>>();

  Stream<List<String>> get dataStream => _dataSubject.stream;

  void fetchData() {
    // TODO: Request data from firebase
    _dataSubject.add(["Item 1", "Item 2", "Item 3"]);
  }

  @override
  void dispose() {
    _dataSubject.close(); 
  }
}
