import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/models/user_model.dart';
import 'package:vallexplora/src/resources/repository.dart';

import '../bloc.dart';

class ProfileBloc implements Bloc {
  final _repository = Repository();

  final _email = BehaviorSubject<String>();
  final _username = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _newPassword = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();
  final _pictureURL = BehaviorSubject<String>();
  final _originPlace = BehaviorSubject<String>();
  final _municipalitiesVisited = BehaviorSubject<int>();
  final _notificationsGlobal = BehaviorSubject<bool>.seeded(false);
  final _notificationsGeo = BehaviorSubject<bool>.seeded(false);
  final _deleteAccountStep = BehaviorSubject<int>();
  final _passwordVissible = BehaviorSubject<bool>.seeded(false);
  final _confirmPasswordVissible = BehaviorSubject<bool>.seeded(false);
  final _newPasswordVisible = BehaviorSubject<bool>.seeded(false);
  final _editingUsername = BehaviorSubject<bool>.seeded(false);
  final _categories = BehaviorSubject<List<int>>();

  Stream<String> get email => _email.stream;
  Stream<String> get username => _username.stream;
  Stream<String> get password => _password.stream;
  Stream<String> get newPassword => _newPassword.stream;
  Stream<String> get confirmPassword => _confirmPassword.stream;
  Stream<String> get pictureURL => _pictureURL.stream;
  Stream<String> get originPlace => _originPlace.stream;
  Stream<int> get municipalitiesVisited => _municipalitiesVisited.stream;
  Stream<bool> get notificationsGlobal => _notificationsGlobal.stream;
  Stream<bool> get notificationsGeo => _notificationsGeo.stream;
  Stream<int> get deleteAccountStep => _deleteAccountStep.stream;
  Stream<bool> get passwordVisible => _passwordVissible.stream;
  Stream<bool> get confirmPasswordVisible => _confirmPasswordVissible.stream;
  Stream<bool> get newPasswordVisible => _newPasswordVisible.stream;
  Stream<bool> get editingUsername => _editingUsername.stream;
  Stream<List<int>> get categories => _categories.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeNewPassword => _newPassword.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;
  Function(String) get changePictureURL => _pictureURL.sink.add;
  Function(String) get changeOriginPlace => _originPlace.sink.add;
  Function(int) get changeMunicipalities => _municipalitiesVisited.sink.add;
  Function(bool) get changeNotificationsGlobal => _notificationsGlobal.sink.add;
  Function(bool) get changeNotificationsGeo => _notificationsGeo.sink.add;
  Function(int) get changeDeleteAccountStep => _deleteAccountStep.sink.add;
  Function(bool) get changePasswordVisible => _passwordVissible.sink.add;
  Function(bool) get changeConfirmPasswordVisible =>
      _confirmPasswordVissible.sink.add;
  Function(bool) get changeNewPasswordVisible => _newPasswordVisible.sink.add;
  Function(bool) get changeEditingUsername => _editingUsername.sink.add;
  Function(List<int>) get changeCategories => _categories.sink.add;

  User get _user => _repository.getCurrentUser();

  Future<Stream<UserModel>> getUserInfo() async {
    Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> rawUserInfo =
        _repository.getUserInfo(_repository.getUserUID());

    return (await rawUserInfo).map(UserModel.fromDocument);
  }

  bool isGoogleAccount() {
    return _user.providerData[0].providerId == "google.com";
  }

  modifyCategoryFilters(int category) {
    categories.listen((event) {
      if (event.contains(category)) {
        event.remove(category);
      } else if (event.length != 3) {
        event.add(category);
      }
    });
  }

  String getDownloadedPicURL() {
    if (isGoogleAccount()) {
      return _user.photoURL!.replaceAll(RegExp(r"\=s96\-c$"), "=s512-c");
    }
    return "";
  }

  void uploadUsername() => _repository.uploadUsername(_username.value);

  void uploadPassword(String email) =>
      _repository.uploadPassword(_newPassword.value, email, _password.value);

  void uploadEmail(String email) =>
      _repository.uploadEmail(_email.value, email, _password.value);

  void updateNotificationsGlobal(bool value) => _repository
      .updateNotificationsGlobal(value)
      .then((_) => changeNotificationsGlobal(value));

  void updateNotificationsGeo(bool value) => _repository
      .updateNotificationsGeo(value)
      .then((_) => changeNotificationsGeo(value));

  Future<String> getProfilePictureDownloadURL(String pictureURL) {
    return FirebaseStorage.instance
        .ref()
        .child(pictureURL)
        .getDownloadURL()
        .onError((error, stackTrace) => "");
  }

  void uploadStreams() {
    _repository.updateProfile(
      _username.value,
      _municipalitiesVisited.value,
      _originPlace.value,
      _categories.value,
      _notificationsGeo.value,
      _notificationsGlobal.value,
    );
  }

  @override
  void dispose() async {
    await _email.drain();
    _email.close();
    await _username.drain();
    _username.close();
    await _password.drain();
    _password.close();
    await _newPassword.drain();
    _newPassword.close();
    await _confirmPassword.drain();
    _confirmPassword.close();
    await _pictureURL.drain();
    _pictureURL.close();
    await _originPlace.drain();
    _originPlace.close();
    await _municipalitiesVisited.drain();
    _municipalitiesVisited.close();
    await _notificationsGlobal.drain();
    _notificationsGlobal.close();
    await _notificationsGeo.drain();
    _notificationsGeo.close();
    await _deleteAccountStep.drain();
    _deleteAccountStep.close();
    await _passwordVissible.drain();
    _passwordVissible.close();
    await _confirmPasswordVissible.drain();
    _confirmPasswordVissible.close();
    await _newPasswordVisible.drain();
    _newPasswordVisible.close();
    await _editingUsername.drain();
    _editingUsername.close();
  }
}
