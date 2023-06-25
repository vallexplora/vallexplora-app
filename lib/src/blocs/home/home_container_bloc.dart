import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/resources/repository.dart';

import '../bloc.dart';

class HomeContainerBloc implements Bloc {
  final _repository = Repository();
  final _currentIndex = BehaviorSubject<int>();

  Stream<int> get currentIndex => _currentIndex.stream;

  Function(int) get changeIndex => _currentIndex.sink.add;

  Future<void> logout() async {
    return await _repository.signOut();
  }

  @override
  void dispose() async {
    await _currentIndex.drain();
    _currentIndex.close();
  }
}
