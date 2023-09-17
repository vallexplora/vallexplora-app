import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/constants/sizes.dart';
import 'package:vallexplora/src/constants/text_strings.dart';
import 'package:vallexplora/src/ui/login/login_screen.dart';
import 'package:vallexplora/src/ui/register/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          foregroundColor: ColorResources.twNeutral[900],
        ),
        body: Container(
          padding: const EdgeInsets.all(SizeResources.defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SizeResources.defaultSpacing,
                    ),
                    child: Text(
                      StringResources.welcomeTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SizeResources.defaultSpacing),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserRegisterScreen()),
                      );
                    },
                    child: const Text(
                      StringResources.register,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeResources.buttonTextSize,
                      ),
                    ),
                  ),
                  const SizedBox(height: SizeResources.buttonHeight),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      StringResources.login,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeResources.buttonTextSize,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
