import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/blocs/bloc.dart';

import '../../resources/repository.dart';

class SignUpBloc implements Bloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _displayName = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _verifyPassword = BehaviorSubject<String>();
  final _isLoggedIn = BehaviorSubject<bool>();
  final _passwordVisible = BehaviorSubject<bool>();
  final _verifyPasswordVisible = BehaviorSubject<bool>();

  Stream<String> get email => _email.stream;
  Stream<String> get displayName => _displayName.stream;
  Stream<String> get password => _password.stream;
  Stream<String> get verifyPassword => _verifyPassword.stream;
  Stream<bool> get passwordVisible => _passwordVisible.stream;
  Stream<bool> get verifyPasswordVisible => _verifyPasswordVisible.stream;
  Stream<bool> get isLoggedIn => _isLoggedIn.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeDisplayName => _displayName.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeVerifyPassword => _verifyPassword.sink.add;
  Function(bool) get changePasswordVisible => _passwordVisible.sink.add;
  Function(bool) get changeVerifyPasswordVisible =>
      _verifyPasswordVisible.sink.add;
  Function(bool) get showLoginProgress => _isLoggedIn.sink.add;

  Future<int> signInWithGoogle() async {
    return await _repository.signInWithGoogle();
  }

  Future<int> registerUser() async {
    // showLoginProgress(true);
    bool emailFine = _email.hasValue;
    bool passwordFine = _password.hasValue;
    bool displayNameFine = _displayName.hasValue;

    if (emailFine && passwordFine && displayNameFine) {
      return await _repository.signUpWithEmailAndPassword(
          _email.value, _password.value, _displayName.value);
    } else {
      return 3;
    }

    // showLoginProgress(false);
  }

  Future<int> loginAfterRegister() async {
    bool emailFine = _email.hasValue;
    bool passwordFine = _password.hasValue;

    if (emailFine && passwordFine) {
      return await _repository.loginWithEmailAndPassword(
          _email.value, _password.value);
    } else {
      return 3;
    }
  }

  @override
  void dispose() async {
    await _email.drain();
    _email.close();
    await _displayName.drain();
    _displayName.close();
    await _password.drain();
    _password.close();
    await _verifyPassword.drain();
    _verifyPassword.close();
    await _isLoggedIn.drain();
    _isLoggedIn.close();
  }
}
