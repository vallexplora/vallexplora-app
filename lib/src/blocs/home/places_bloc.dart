import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/models/place_model.dart';
import 'package:vallexplora/src/resources/repository.dart';

class PlacesBloc extends Bloc {
  final _repository = Repository();

  Stream<QuerySnapshot> placesList() => _repository.placesList();

  Future<List<PlaceModel>> convertToFuture(List<DocumentSnapshot> docs) async {
    List<PlaceModel> places = [];

    for (var doc in docs) {
      PlaceModel challengeModel = await PlaceModel.fromDocument(doc);
      places.add(challengeModel);
    }

    return places;
  }

  @override
  void dispose() {
    
  }

}