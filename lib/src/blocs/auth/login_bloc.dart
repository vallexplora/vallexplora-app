import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/resources/repository.dart';

import '../../constants/text_strings.dart';
import '../../utils/validator.dart';
import '../bloc.dart';

class LoginBloc implements Bloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream<String> get email => _email.stream.transform(_validateEmail);
  Stream<String> get password => _password.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (Validator.validateEmail(email)) {
        sink.add(email);
      } else {
        sink.addError(StringResources.emailIsInvalidError);
      }
    },
  );

  Future<String> logUserIn() async {
    bool emailFine = _email.hasValue;
    bool passwordFine = _password.hasValue;

    if (emailFine && passwordFine) {
      return await _repository.loginWithEmailAndPassword(
          _email.value, _password.value);
    } else {
      return "Datos incompletos";
    }
  }

  @override
  void dispose() async {
    await _email.drain();
    _email.close();
    await _password.drain();
    _password.close();
  }
}
