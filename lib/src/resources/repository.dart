import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vallexplora/src/resources/auth_resources.dart';
import 'package:vallexplora/src/resources/firestore_resources.dart';

class Repository {
  final _authResources = AuthenticationResources();
  final _dbResources = FirestoreResources();

  /// Authentication
  Stream<User?> get onAuthStateChange => _authResources.onAuthStateChange;

  Future<int> loginWithEmailAndPassword(String email, String password) =>
      _authResources.loginWithEmailAndPassword(email, password);

  Future<int> signUpWithEmailAndPassword(
          String email, String password, String displayName) =>
      _authResources.signUpWithEmailAndPassword(email, password, displayName);
  Future<void> signOut() => _authResources.signOut;

  Future<String> getUserUID() => _authResources.getUserUID();

  User getCurrentUser() => _authResources.getCurrentUser;

  Future<int> signInWithGoogle() => _authResources.singInWIthGoogle();

  Future<String> resetPassword(email) =>
      _authResources.sendPasswordResetEmail(email);

  // Home

  // Events
  Stream<QuerySnapshot> eventsList() => _dbResources.eventsList();

  // Sales
  Stream<QuerySnapshot> salesList() => _dbResources.salesList();

  /// Guide

  Stream<QuerySnapshot> citiesList() => _dbResources.citiesList();

  /// Challenges

  Stream<QuerySnapshot> challengesList() => _dbResources.challengesList();

  /// Profile

  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getUserInfo(
          Future<String> uid) =>
      _dbResources.getUserInfo(uid);

  Future<bool> uploadPassword(
      String newPassword, String email, String password) {
    return _authResources
        .updatePassword(
            email: email, password: password, newPassword: newPassword)
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  Future<bool> uploadEmail(String newEmail, String email, String password) {
    return _authResources
        .updateEmail(password: password, email: email, newEmail: newEmail)
        .then((value) async {
      if (value) {
        return _dbResources
            .updateEmail(id: await getUserUID(), email: newEmail)
            .then((value) => true)
            .onError((error, stackTrace) => false);
      } else {
        return false;
      }
    });
  }

  Future<void> uploadUsername(String username) async =>
      _dbResources.updateUsername(id: await getUserUID(), username: username);

  Future<void> updateNotificationsGlobal(bool value) async {
    _dbResources.updateGlobalNotifications(
        id: await _authResources.getUserUID(), value: value);
  }

  Future<void> updateNotificationsGeo(bool value) async {
    _dbResources.updateGeoNotifications(
        id: await _authResources.getUserUID(), value: value);
  }

  Query<Object?> eventsListQuery() {
    return _dbResources.eventsListQuery();
  }

  Future<void> addUserMetaData(List<String> interests, String origin, String pictureURL) async {
    return _dbResources.addUserMetaData(await getUserUID(), interests, origin, pictureURL);
  }

  // User markers
}
