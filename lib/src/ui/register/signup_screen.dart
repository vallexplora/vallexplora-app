import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/asset_uris.dart';
import 'package:vallexplora/src/constants/sizes.dart';
import 'package:vallexplora/src/constants/text_strings.dart';
import 'package:vallexplora/src/ui/login/login_screen.dart';
import 'package:vallexplora/src/ui/register/signup_form_widget.dart';
import 'package:vallexplora/src/ui/welcome_screen.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var bloc = BlocProvider.of<SignUpBloc>(context);
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
                  StringResources.signUpTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SignUpFormWidget(),
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
        ),
      ),
    );
  }
}
