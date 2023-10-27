import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vallexplora/src/blocs/auth/login_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              title: Text(AppLocalizations.of(context)!.sForgotTitle),
              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sForgotTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    AppLocalizations.of(context)!.sForgotSteps,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    autofillHints: const [
                      AutofillHints.email,
                    ],
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom +
                          Theme.of(context).buttonTheme.height * 8,
                    ),
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.sForgotEmail),
                      prefixIcon: const Icon(Icons.alternate_email_rounded),
                    ),
                    onChanged: (value) => {_bloc.changeEmail(value)},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.sForgotBackToLogin,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FilledButton(
                    onPressed: () =>
                        _bloc.resetPassword().then((logValue) async {
                      await Fluttertoast.showToast(
                          msg:
                              "${AppLocalizations.of(context)!.sForgotToast} $logValue",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }),
                    child: Text(
                      AppLocalizations.of(context)!.sForgotSend,
                    ),
                  )
                ],
              ),
            )));
  }
}
