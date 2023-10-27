import 'package:flutter/material.dart';
import 'package:vallexplora/src/ui/login/login_form_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.sLoginAppBarTitle),
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
                  AppLocalizations.of(context)!.sLoginTitle,
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                      TextStyle(
                          color: Theme.of(context).colorScheme.onSurface)),
                  textAlign: TextAlign.center,
                ),
                const LoginFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
