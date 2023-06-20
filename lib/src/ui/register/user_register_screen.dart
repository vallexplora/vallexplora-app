import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/asset_uris.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/constants/sizes.dart';
import 'package:vallexplora/src/constants/text_strings.dart';
import 'package:vallexplora/src/ui/register/sign_up_form_widget.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: AppBar(
          foregroundColor: ColorResources.mayaBlue[50],
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      StringResources.signUpTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SignUpFormWidget(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          StringResources.optionOr.toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Image(
                            image: AssetImage(AssetURIResources.googleLogo),
                            width: 20.0,
                          ),
                          label: const Text(StringResources.signInWithGoogle),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(StringResources.signUpLoginInstead),
                        ),
                      ],
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
