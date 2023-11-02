import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/auth/signup_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vallexplora/src/constants/errors.dart';
import '../../constants/asset_uris.dart';
import '../home_container_screen.dart';
import '../login/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'register_part_2_screen.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  State<SignUpFormWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpFormWidget> {
  final _bloc = SignUpBloc();

  @override
  void initState() {
    super.initState();
    _bloc.changePasswordVisible(false);
    _bloc.changeVerifyPasswordVisible(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    autofillHints: const [
                      AutofillHints.username,
                    ],
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom +
                          Theme.of(context).buttonTheme.height * 8,
                    ),
                    decoration: InputDecoration(
                      label:
                          Text(AppLocalizations.of(context)!.sRegisterUsername),
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                    ),
                    onChanged: (value) {
                      _bloc.changeDisplayName(value);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    autofillHints: const [
                      AutofillHints.email,
                    ],
                    keyboardType: TextInputType.emailAddress,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom +
                          Theme.of(context).buttonTheme.height * 8,
                    ),
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.sRegisterEmail),
                      prefixIcon: const Icon(Icons.alternate_email_rounded),
                      helperText:
                          AppLocalizations.of(context)!.sRegisterEmailHint,
                    ),
                    onChanged: (value) {
                      _bloc.changeEmail(value);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder<bool>(
                    stream: _bloc.passwordVisible,
                    builder: (context, snapshot) {
                      return TextField(
                        autofillHints: const [
                          AutofillHints.password,
                        ],
                        obscureText: snapshot.data ?? true ? false : true,
                        keyboardType: TextInputType.visiblePassword,
                        scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom +
                              Theme.of(context).buttonTheme.height * 8,
                        ),
                        decoration: InputDecoration(
                          label: Text(
                              AppLocalizations.of(context)!.sRegisterPassword),
                          prefixIcon: const Icon(Icons.key_rounded),
                          helperText: AppLocalizations.of(context)!
                              .sRegisterPasswordHint,
                          suffixIcon: IconButton(
                            icon: Icon(
                              snapshot.data ?? true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              _bloc.changePasswordVisible(!snapshot.data!);
                            },
                          ),
                        ),
                        onChanged: (value) {
                          _bloc.changePassword(value);
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder<bool>(
                    stream: _bloc.verifyPasswordVisible,
                    builder: (context, snapshot) {
                      return TextField(
                        autofillHints: const [
                          AutofillHints.password,
                        ],
                        obscureText: snapshot.data ?? true ? false : true,
                        keyboardType: TextInputType.visiblePassword,
                        scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom +
                              Theme.of(context).buttonTheme.height * 8,
                        ),
                        decoration: InputDecoration(
                          label: Text(AppLocalizations.of(context)!
                              .sRegisterPasswordConfirm),
                          prefixIcon: const Icon(Icons.key_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              snapshot.data ?? true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              _bloc
                                  .changeVerifyPasswordVisible(!snapshot.data!);
                            },
                          ),
                        ),
                        onChanged: (value) {
                          _bloc.changeVerifyPassword(value);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
              onPressed: () {
                _bloc.registerUser().then((res) async {
                  await Fluttertoast.showToast(
                      msg: registerErrorCodes(context)[res] ?? "",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  if (res == 0) {
                    _bloc.loginAfterRegister().then((res) async {
                      await Fluttertoast.showToast(
                          msg: registerErrorCodes(context)[res] ?? "",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }).then(
                      (value) => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomeContainerScreen()),
                        ),
                      },
                    );
                  }
                });
              },
              child: Text(
                AppLocalizations.of(context)!.sRegisterConfirm,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              AppLocalizations.of(context)!.gOr,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton.icon(
              onPressed: () {
                _bloc.signInWithGoogle().then((logValue) async {
                  await Fluttertoast.showToast(
                      msg: logValue != -1
                          ? "¡Bienvenido a Vallexplora!"
                          : "Error iniciando sesión",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  FirebaseAuth.instance
                      .authStateChanges()
                      .listen((User? user) async {
                    if (user != null) {
                      if (logValue == 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPart2Screen()),
                        );
                      } else if (logValue == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomeContainerScreen()),
                        );
                      }
                    }
                  });
                });
              },
              icon: const Image(
                image: AssetImage(AssetURIResources.googleLogo),
                width: 20.0,
              ),
              label: Text(
                AppLocalizations.of(context)!.sRegisterGoogle,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.sRegisterLoginInstead,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
