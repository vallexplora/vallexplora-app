import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vallexplora/src/blocs/auth/login_bloc.dart';

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  final _bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light),
        child: Scaffold(
            appBar: AppBar(
              title: const Text(StringResources.forgottenPasswordTitle),
              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(SizeResources.defaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    StringResources.forgottenPasswordTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: SizeResources.buttonHeight,
                  ),
                  Text(
                    StringResources.forgottenPasswordSteps,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: SizeResources.buttonHeight,
                  ),
                  TextFormField(
                    autofillHints: const [
                      AutofillHints.email,
                    ],
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom +
                          SizeResources.buttonTextSize * 8,
                    ),
                    decoration: const InputDecoration(
                      label: Text(StringResources.loginFormEmail),
                      prefixIcon: Icon(Icons.alternate_email_rounded),
                    ),
                    onChanged: (value) => {_bloc.changeEmail(value)},
                  ),
                  const SizedBox(
                    height: SizeResources.buttonHeight,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      StringResources.forgottenPasswordLogin,
                    ),
                  ),
                  const SizedBox(
                    height: SizeResources.buttonHeight,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _bloc.resetPassword().then((logValue) async {
                      await Fluttertoast.showToast(
                          msg: logValue,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }),
                    child: const Text(
                      StringResources.forgottenPasswordSubmitRestore,
                    ),
                  )
                ],
              ),
            )));
  }
}
