import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Stream<QuerySnapshot> profileImage() => _repository.eventsList();

  @override
  void dispose() async {
    await _currentIndex.drain();
    _currentIndex.close();
  }

  Future<void> requestPermissions() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      await Permission.location.request().then((status) async {
        if (status.isPermanentlyDenied) {
          openAppSettings();
        } else if (status.isDenied) {
          _repository.signOut();
        } else {
          await Permission.locationAlways.request();
        }
      });
    }
  }
}
