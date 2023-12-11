import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/models/user_model.dart';
import 'package:vallexplora/src/resources/repository.dart';

import '../../models/challenge_model.dart';

class ChallengesBloc implements Bloc {
  final _repository = Repository();

  final _name = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _points = BehaviorSubject<String>();
  final _startDate = BehaviorSubject<Timestamp>();
  final _expiration = BehaviorSubject<Timestamp>();
  final _place = BehaviorSubject<String>();
  final _proofImage = BehaviorSubject<String>.seeded("");

  Stream<String> get name => _name.stream;
  Stream<String> get description => _description.stream;
  Stream<String> get points => _points.stream;
  Stream<Timestamp> get startDate => _startDate.stream;
  Stream<Timestamp> get expiration => _expiration.stream;
  Stream<String> get place => _place.stream;
  Stream<String> get proofImage => _proofImage.stream;

  Function(String) get changeName => _name.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(String) get changePoints => _points.sink.add;
  Function(Timestamp) get changeStartDate => _startDate.sink.add;
  Function(Timestamp) get changeExpiration => _expiration.sink.add;
  Function(String) get changePlace => _place.sink.add;
  Function(String) get changeProofImage => _proofImage.sink.add;

  Future<DateTime> getCurrentExpirationDate() async =>
      (await _repository.getCurrentExpirationDate()).toDate();

  Future<String> getCurrentExpirationDateAsLocalizedString(
      BuildContext context) async {
    // ignore: use_build_context_synchronously
    String locale = Localizations.localeOf(context).languageCode;

    DateTime expirationDate = await getCurrentExpirationDate();
    return DateFormat.yMd(locale).format(expirationDate);
  }

  Future<List<Stream<QuerySnapshot<Map<String, dynamic>>>>> challengesList() =>
      _repository.challengesList();

  Future<Stream<UserModel>> getUserInfo() async {
    Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> rawUserInfo =
        _repository.getUserInfo(_repository.getUserUID());

    return (await rawUserInfo).map(UserModel.fromDocument);
  }

  List<ChallengeModel> convertToList(List<DocumentSnapshot> docs) {
    List<ChallengeModel> challenges = [];

    for (var doc in docs) {
      ChallengeModel challengeModel = ChallengeModel.fromDocument(doc);
      challenges.add(challengeModel);
    }

    return challenges;
  }

  int checkIfDoneOrExpired(
      ChallengeModel challenge, List<String> completedChallenges) {
    if (completedChallenges.contains(challenge.id)) {
      return ChallengeStates.attained.value; // Got the points
    } /* else if (challenge.expiration.toDate().compareTo(DateTime.now()) < 0) {
      return ChallengeStates.failed.value; // Though luck
    } */
    else {
      return ChallengeStates.open.value; // Still got time
    }
  }

  void markAsDone(String id, int points) {
    _repository.markChallengeAsDone(id, points);
  }

  String currentweekend(BuildContext context) {
    DateTime weekEnd = getWeekEnd();

    String locale = Localizations.localeOf(context).languageCode;

    return DateFormat.yMd(locale).format(weekEnd);
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    changeProofImage(returnedImage.path);
  }

  @override
  void dispose() async {
    await _name.drain();
    _name.close();
    await _description.drain();
    _description.close();
    await _points.drain();
    _points.close();
    await _startDate.drain();
    _startDate.close();
    await _expiration.drain();
    _expiration.close();
    await _place.drain();
    _place.close();
  }
}
