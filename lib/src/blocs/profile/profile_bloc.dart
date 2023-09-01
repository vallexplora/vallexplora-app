import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../constants/text_strings.dart';
import '../../utils/validator.dart';
import '../bloc.dart';

class ProfileBloc implements Bloc {
  final _email = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();

  Stream<String> get password => _password.stream;
  Stream<String> get email => _email.stream.transform(_validateEmail);
  Stream<String> get name => _name.stream;
  Stream<String> get phone => _phone.stream;

  Function(String) get changeName => _name.sink.add;
  Function(String) get changephone => _phone.sink.add;
  Function(String) get changeEmail => _email.sink.add;

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

    await _name.drain();
    _name.close();

    await _phone.drain();
    _phone.close();

    await _password.drain();
    _password.close();
  }
}
