import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vallexplora/src/resources/auth_resources.dart';
import 'package:vallexplora/src/resources/firestore_resources.dart';

class Repository {
  final _authResources = AuthenticationResources();
  final _dbResources = FirestoreResources();

  /// Authentication
  Stream<User?> get onAuthStateChange => _authResources.onAuthStateChange;

  Future<String> loginWithEmailAndPassword(String email, String password) =>
      _authResources.loginWithEmailAndPassword(email, password);

  Future<String> signUpWithEmailAndPassword(
          String email, String password, String displayName) =>
      _authResources.signUpWithEmailAndPassword(email, password, displayName);
  Future<void> signOut() => _authResources.signOut;

  Future<String> getUserUID() => _authResources.getUserUID();

  Future<UserCredential> signInWithGoogle() =>
      _authResources.singInWIthGoogle();

  Future<String> resetPassword(email) => _authResources.updatePassword(email);

  // Home

  // Events
  Stream<QuerySnapshot> eventsList() => _dbResources.eventsList();
  Future<void> addNewEvent({
    required String name,
    String description = "Sin descripción.",
    required int entryFee,
    required Timestamp startDate,
    String city = "cali",
  }) =>
      _dbResources.addNewEvent(
          name: name,
          description: description,
          entryFee: entryFee,
          startDate: startDate,
          city: city);

  // Sales
  Stream<QuerySnapshot> salesList() => _dbResources.salesList();
  Future<void> addNewSale({
    required String name,
    String description = "Sin descripción.",
    required String companyID,
    required Timestamp expirationDate,
    required bool stackable,
    String city = "cali",
  }) =>
      _dbResources.addNewSale(
          name: name,
          description: description,
          companyID: companyID,
          expirationDate: expirationDate,
          stackable: stackable,
          city: city);

  /// Guide

  Stream<QuerySnapshot> citiesList() => _dbResources.citiesList();

  /// Challenges

  Stream<QuerySnapshot> challengesList() => _dbResources.challengesList();
  Future<void> addNewChallenge({
    required String name,
    String description = "Sin descripción.",
    required int points,
    required Timestamp startDate,
    required Timestamp expiration,
    String place = "cali",
  }) =>
      _dbResources.addNewChallenge(
          name: name,
          description: description,
          points: points,
          startDate: startDate,
          expiration: expiration,
          place: place);

  // User markers
}
