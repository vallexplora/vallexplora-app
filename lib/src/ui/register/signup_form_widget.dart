import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/auth/signup_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/asset_uris.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../home_container_screen.dart';
import '../login/login_screen.dart';

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
        vertical: SizeResources.formHeight,
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              autofillHints: const [
                AutofillHints.username,
              ],
              scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    SizeResources.buttonTextSize * 8,
              ),
              decoration: const InputDecoration(
                label: Text(StringResources.signUpFormFullName),
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              onChanged: (value) {
                _bloc.changeDisplayName(value);
              },
            ),
            const SizedBox(
              height: SizeResources.buttonHeight,
            ),
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
                label: Text(StringResources.signUpFormEmail),
                prefixIcon: Icon(Icons.alternate_email_rounded),
              ),
              onChanged: (value) {
                _bloc.changeEmail(value);
              },
            ),
            const SizedBox(
              height: SizeResources.buttonHeight - 10,
            ),
            const Text(
              StringResources.signUpFormEmailInfo,
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
                    label: const Text(StringResources.signUpFormPassword),
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
            const Text(
              StringResources.signUpFormPasswordInfo,
            ),
            const SizedBox(
              height: SizeResources.buttonHeight,
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
                        SizeResources.buttonTextSize * 8,
                  ),
                  decoration: InputDecoration(
                    label: const Text(StringResources.signUpFormPasswordVerify),
                    prefixIcon: const Icon(Icons.key_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(
                        snapshot.data ?? true
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        _bloc.changeVerifyPasswordVisible(!snapshot.data!);
                      },
                    ),
                  ),
                  onChanged: (value) {
                    _bloc.changeVerifyPassword(value);
                  },
                );
              },
            ),
            const SizedBox(
              height: SizeResources.buttonHeight,
            ),
            ElevatedButton(
              onPressed: () {
                _bloc.registerUser().then((regValue) async {
                  await Fluttertoast.showToast(
                      msg: regValue,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  if (regValue == StringResources.signUpSuccess) {
                    _bloc.loginAfterRegister().then((logValue) async {
                      await Fluttertoast.showToast(
                          msg: logValue,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }).then(
                      (value) => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomeContainerScreen()),
                        ),
                      },
                    );
                  }
                });
              },
              child: const Text(
                StringResources.signUpFormSubmit,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeResources.buttonTextSize,
                ),
              ),
            ),
            const SizedBox(
              height: SizeResources.buttonHeight,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  StringResources.optionOr.toUpperCase(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: SizeResources.buttonHeight,
                ),
                OutlinedButton.icon(
                  onPressed: () {},
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
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(StringResources.signUpLoginInstead),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
