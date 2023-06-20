import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
  });

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
                label: Text(StringResources.loginFormPassword),
                prefixIcon: Icon(Icons.key_rounded),
              ),
            ),
            const SizedBox(
              height: SizeResources.buttonHeight - 10,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                StringResources.loginFormForgot,
              ),
            ),
            const SizedBox(
              height: SizeResources.buttonHeight,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                StringResources.signUpFormSubmit,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeResources.buttonTextSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
