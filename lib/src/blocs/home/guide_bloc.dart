import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/resources/repository.dart';

class GuideBloc implements Bloc {
  final _repository = Repository();

  Stream<QuerySnapshot> citiesList() => _repository.citiesList();

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
