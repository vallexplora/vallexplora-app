import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vallexplora/src/blocs/auth/login_bloc.dart';
import 'package:vallexplora/src/constants/errors.dart';
import 'package:vallexplora/src/ui/home_container_screen.dart';
import 'package:vallexplora/src/ui/home_screens/feed/home_screen.dart';
import 'package:vallexplora/src/ui/login/forgot_password_screen.dart';
import 'package:vallexplora/src/ui/register/register_part_2_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constants/asset_uris.dart';
import '../register/signup_screen.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormWidget> {
  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _bloc.changePasswordVisible(false);
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
                      AutofillHints.email,
                    ],
                    keyboardType: TextInputType.emailAddress,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom +
                          Theme.of(context).buttonTheme.height * 8,
                    ),
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.sLoginEmail),
                      prefixIcon: const Icon(Icons.alternate_email_rounded),
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
                              AppLocalizations.of(context)!.sLoginPassword),
                          prefixIcon: const Icon(Icons.key_rounded),
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.sLoginForgotPassword,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
              onPressed: () {
                _bloc.logUserIn().then((logValue) async {
                  await Fluttertoast.showToast(
                      msg: loginErrorCodes(context)[logValue]!,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                    if (user != null) {
                      if (logValue == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomeContainerScreen()),
                        );
                      }
                    }
                  });
                });
              },
              child: Text(
                AppLocalizations.of(context)!.sLoginConfirm,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              AppLocalizations.of(context)!.gOr.toUpperCase(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton.icon(
              onPressed: () {
                _bloc.signInWithGoogle().then((logValue) async {
                  await Fluttertoast.showToast(
                      msg: loginErrorCodes(context)[logValue]!,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPart2Screen()),
                        );
                      } else if (logValue == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
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
                AppLocalizations.of(context)!.sLoginGoogle,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserRegisterScreen()),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.sLoginRegisterInstead,
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
