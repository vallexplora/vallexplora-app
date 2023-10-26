import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vallexplora/src/constants/asset_uris.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/ui/login/login_screen.dart';
import 'package:vallexplora/src/ui/register/signup_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryRef.value90,
                Theme.of(context).colorScheme.surface,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 64),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(AssetURIResources.vallexploraLogo),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppLocalizations.of(context)!.sWelcomeTitle,
                      style: Theme.of(context).textTheme.headlineMedium!.merge(
                          TextStyle(
                              color: Theme.of(context).colorScheme.onSurface)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppLocalizations.of(context)!.sWelcomeCopy,
                      style: Theme.of(context).textTheme.bodyLarge!.merge(
                          TextStyle(
                              color: Theme.of(context).colorScheme.onSurface)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserRegisterScreen()),
                        );
                      },
                      child:
                          Text(AppLocalizations.of(context)!.sWelcomeRegister),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.sWelcomeLogin),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
