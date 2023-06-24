import 'package:flutter/material.dart';
import 'package:vallexplora/src/ui/login/login_form_widget.dart';
import 'package:vallexplora/src/ui/register/signup_screen.dart';

import '../../constants/asset_uris.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ),
      body: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast,
          ),
          child: Container(
            padding: const EdgeInsets.all(SizeResources.defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  StringResources.loginTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const LoginFormWidget(),
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
                              builder: (context) => const UserRegisterScreen()),
                        );
                      },
                      child: const Text(StringResources.loginSignUpInstead),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
