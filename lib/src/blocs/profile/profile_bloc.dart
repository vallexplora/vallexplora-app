import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/resources/repository.dart';

import '../../constants/text_strings.dart';
import '../../utils/validator.dart';
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
  final _notificationsGlobal = BehaviorSubject<bool>();
  final _notificationsGeo = BehaviorSubject<bool>();
  final _deleteAccountStep = BehaviorSubject<int>();
  final _passwordVissible = BehaviorSubject<bool>();
  final _confirmPasswordVissible = BehaviorSubject<bool>();
  final _newPasswordVisible = BehaviorSubject<bool>();

  Stream<String> get email => _email.stream.transform(_validateEmail);
  Stream<String> get username => _username.stream;
  Stream<String> get password => _password.stream;
  Stream<String> get newPassword => _newPassword.stream;
  Stream<String> get confirmPassword => _confirmPassword.stream;
  Stream<String> get pictureURL => _pictureURL.stream;
  Stream<String> get originPlace => _originPlace.stream;
  Stream<bool> get notificationsGlobal => _notificationsGlobal.stream;
  Stream<bool> get notificationsGeo => _notificationsGeo.stream;
  Stream<int> get deleteAccountStep => _deleteAccountStep.stream;
  Stream<bool> get passwordVisible => _passwordVissible.stream;
  Stream<bool> get confirmPasswordVisible => _confirmPasswordVissible.stream;
  Stream<bool> get newPasswordVisible => _newPasswordVisible.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeNewPassword => _newPassword.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;
  Function(String) get changePictureURL => _pictureURL.sink.add;
  Function(String) get changeOriginPlace => _originPlace.sink.add;
  Function(bool) get changeNotificationsGlobal => _notificationsGlobal.sink.add;
  Function(bool) get changeNotificationsGeo => _notificationsGeo.sink.add;
  Function(int) get changeDeleteAccountStep => _deleteAccountStep.sink.add;
  Function(bool) get changePasswordVisible => _passwordVissible.sink.add;
  Function(bool) get changeConfirmPasswordVisible =>
      _confirmPasswordVissible.sink.add;
  Function(bool) get changeNewPasswordVissible => _newPasswordVisible.sink.add;

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (Validator.validateEmail(email)) {
        sink.add(email);
      } else {
        sink.addError(StringResources.emailIsInvalidError);
      }
    },
  );

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
  }
}
