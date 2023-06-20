import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/auth/signup_bloc.dart';

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key});

  @override
  State<SignUpFormWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpFormWidget> {
  final _bloc = SignUpBloc();

  @override
  void initState() {
    super.initState();
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
            TextFormField(
              autofillHints: const [
                AutofillHints.telephoneNumber,
              ],
              keyboardType: TextInputType.phone,
              scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    SizeResources.buttonTextSize * 8,
              ),
              decoration: const InputDecoration(
                label: Text(StringResources.signUpFormPhone +
                    StringResources.optionalField),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              onChanged: (value) {
                _bloc.changePhone(value);
              },
            ),
            const SizedBox(
              height: SizeResources.buttonHeight,
            ),
            TextFormField(
              autofillHints: const [
                AutofillHints.password,
              ],
              keyboardType: TextInputType.visiblePassword,
              scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    SizeResources.buttonTextSize * 8,
              ),
              decoration: const InputDecoration(
                label: Text(StringResources.signUpFormPassword),
                prefixIcon: Icon(Icons.key_rounded),
              ),
              onChanged: (value) {
                _bloc.changePassword(value);
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
            TextFormField(
              autofillHints: const [
                AutofillHints.password,
              ],
              keyboardType: TextInputType.visiblePassword,
              scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    SizeResources.buttonTextSize * 8,
              ),
              decoration: const InputDecoration(
                label: Text(StringResources.signUpFormPasswordVerify),
                prefixIcon: Icon(Icons.key_rounded),
              ),
              onChanged: (value) {
                _bloc.changeVerifyPassword(value);
              },
            ),
            const SizedBox(
              height: SizeResources.buttonHeight,
            ),
            ElevatedButton(
              onPressed: () {
                _bloc.registerUser();
              },
              child: const Text(
                StringResources.signUpFormSubmit,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeResources.buttonTextSize,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
