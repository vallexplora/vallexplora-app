import 'package:flutter/material.dart';
import 'package:vallexplora/src/ui/register/signup_form_widget.dart';
import 'package:vallexplora/src/ui/welcome_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.sRegisterAppBarTitle),
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.sRegisterTitle,
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                      TextStyle(
                          color: Theme.of(context).colorScheme.onSurface)),
                  textAlign: TextAlign.center,
                ),
                const SignUpFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
