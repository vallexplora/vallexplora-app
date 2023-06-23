import 'package:rxdart/rxdart.dart';

import '../bloc.dart';

class HomeContainerBloc implements Bloc {
  final _currentIndex = BehaviorSubject<int>();

  Stream<int> get currentIndex => _currentIndex.stream;

  Function(int) get changeIndex => _currentIndex.sink.add;

  @override
  void dispose() async {
    await _currentIndex.drain();
    _currentIndex.close();
  }
}
