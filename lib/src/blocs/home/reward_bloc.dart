import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vallexplora/src/resources/repository.dart';
import 'package:vallexplora/src/models/reward_model.dart';
import 'package:vallexplora/src/blocs/bloc.dart';

class RewardBloc implements Bloc {
  final _repository = Repository();

  Stream<QuerySnapshot> salesList() => _repository.salesList();

  List<RewardModel> convertToList(List<DocumentSnapshot> docs) {
    List<RewardModel> sales = [];

    for (var doc in docs) {
      RewardModel saleModel = RewardModel.fromDocument(doc);
      sales.add(saleModel);
    }

    return sales;
  }

  @override
  void dispose() async {
    
  }
}
