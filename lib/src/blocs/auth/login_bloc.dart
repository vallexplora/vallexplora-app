import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/resources/repository.dart';

import '../bloc.dart';

class LoginBloc implements Bloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _passwordVisible = BehaviorSubject<bool>();

  Stream<String> get email => _email.stream;
  Stream<String> get password => _password.stream;
  Stream<bool> get passwordVisible => _passwordVisible.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(bool) get changePasswordVisible => _passwordVisible.sink.add;

  Future<int> logUserIn() async {
    bool emailFine = _email.hasValue;
    bool passwordFine = _password.hasValue;

    if (emailFine && passwordFine) {
      return await _repository.loginWithEmailAndPassword(
          _email.value, _password.value);
    } else {
      return 3;
    }
  }

  Future<int> signInWithGoogle() async {
    return await _repository.signInWithGoogle();
  }

  @override
  void dispose() async {
    await _email.drain();
    _email.close();
    await _password.drain();
    _password.close();
  }

  Future<String> resetPassword() {
    return _repository.resetPassword(_email.value);
  }
}
