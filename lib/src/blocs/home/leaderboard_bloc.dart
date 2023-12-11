import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/models/user_model.dart';
import 'package:vallexplora/src/resources/repository.dart';

class LeaderboardBloc extends Bloc {
  final _repository = Repository();

  Stream<QuerySnapshot<Map<String, dynamic>>> getPodium() =>
      _repository.getPodium();

  Future<Stream<UserModel>> getUserInfo() async {
    Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> rawUserInfo =
        _repository.getUserInfo(_repository.getUserUID());

    return (await rawUserInfo).map(UserModel.fromDocument);
  }

  List<UserModel> convertToList(
      List<DocumentSnapshot<Map<String, dynamic>>> docs) {
    List<UserModel> challenges = [];

    for (var doc in docs) {
      UserModel challengeModel = UserModel.fromDocument(doc);
      challenges.add(challengeModel);
    }

    return challenges;
  }

  List<UserModel> figureOutPodium(List<UserModel> users) {
    users.sort((user1, user2) {
      // Get the latest "amount" for each user
      final latestAmount1 =
          user1.points.isNotEmpty ? user1.points.last['amount'] : 0;
      final latestAmount2 =
          user2.points.isNotEmpty ? user2.points.last['amount'] : 0;

      // Sort by "amount" in descending order
      if (latestAmount1 > latestAmount2) {
        return -1;
      } else if (latestAmount1 < latestAmount2) {
        return 1;
      } else {
        return 0;
      }
    });

    return users;
  }

  @override
  void dispose() {}
}
