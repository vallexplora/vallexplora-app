import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/constants/text_strings.dart';
import 'package:vallexplora/src/utils/validator.dart';

import '../../resources/repository.dart';

class SignUpBloc implements Bloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _displayName = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _verifyPassword = BehaviorSubject<String>();
  final _isLoggedIn = BehaviorSubject<bool>();

  Stream<String> get email => _email.stream.transform(_validateEmail);
  Stream<String> get displayName =>
      _displayName.stream.transform(_validateEmail);
  Stream<String> get phone => _phone.stream.transform(_validateEmail);
  Stream<String> get password => _password.stream.transform(_validateEmail);
  Stream<bool> get isLoggedIn => _isLoggedIn.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeDisplayName => _displayName.sink.add;
  Function(String) get changePhone => _phone.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeVerifyPassword => _verifyPassword.sink.add;
  Function(bool) get showLoginProgress => _isLoggedIn.sink.add;

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (Validator.validateEmail(email)) {
        sink.add(email);
      } else {
        sink.addError(StringResources.emailIsInvalidError);
      }
    },
  );

  Future<int> registerUser() async {
    // showLoginProgress(true);
    int response = await _repository.signUpWithEmailAndPassword(
        _email.value, _password.value, _displayName.value);
    // showLoginProgress(false);
    return response;
  }

  @override
  void dispose() async {
    await _email.drain();
    _email.close();
    await _displayName.drain();
    _displayName.close();
    await _phone.drain();
    _phone.close();
    await _password.drain();
    _password.close();
    await _verifyPassword.drain();
    _verifyPassword.close();
    await _isLoggedIn.drain();
    _isLoggedIn.close();
  }
}
