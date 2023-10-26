import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vallexplora/src/blocs/auth/login_bloc.dart';
import 'package:vallexplora/src/constants/errors.dart';
import 'package:vallexplora/src/ui/home_container_screen.dart';
import 'package:vallexplora/src/ui/home_screens/feed/home_screen.dart';
import 'package:vallexplora/src/ui/login/forgot_password_screen.dart';
import 'package:vallexplora/src/ui/register/register_part_2_screen.dart';

import '../../constants/asset_uris.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
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
        vertical: SizeResources.verticalFormPadding,
      ),
      child: Form(
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
                    SizeResources.buttonTextSize * 8,
              ),
              decoration: const InputDecoration(
                label: Text(StringResources.loginFormEmail),
                prefixIcon: Icon(Icons.alternate_email_rounded),
              ),
              onChanged: (value) {
                _bloc.changeEmail(value);
              },
            ),
            const SizedBox(
              height: SizeResources.buttonHeight,
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
                        SizeResources.buttonTextSize * 8,
                  ),
                  decoration: InputDecoration(
                    label: const Text(StringResources.loginFormPassword),
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
              height: SizeResources.buttonHeight - 10,
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
                StringResources.loginFormForgot,
              ),
            ),
            const SizedBox(
              height: SizeResources.buttonHeight,
            ),
            ElevatedButton(
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
              child: const Text(
                StringResources.loginFormSubmit,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: SizeResources.buttonHeight,
                ),
                Text(
                  StringResources.optionOr.toUpperCase(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: SizeResources.buttonHeight,
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
                  label: const Text(
                    StringResources.signInWithGoogle,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: SizeResources.buttonTextSize,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserRegisterScreen()),
                    );
                  },
                  child: const Text(
                    StringResources.loginSignUpInstead,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
