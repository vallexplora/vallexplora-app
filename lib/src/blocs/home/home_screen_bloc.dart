import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/blocs/bloc.dart';

class HomeScreenBloc implements Bloc {
  final _activeTabIndex = BehaviorSubject<int>();

  Stream<int> get activeTabIndex => _activeTabIndex.stream;

  Function(int) get changeActiveTab => _activeTabIndex.sink.add;

  @override
  void dispose() async {
    await _activeTabIndex.drain();
    _activeTabIndex.close();
  }
}
