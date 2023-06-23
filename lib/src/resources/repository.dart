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

  // Guide

  Stream<QuerySnapshot> citiesList() => _dbResources.citiesList(); 
}
